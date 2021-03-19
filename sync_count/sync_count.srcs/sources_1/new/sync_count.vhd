----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: sync_count - sync_count_arch                                    --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sync_count is
    Generic (N : integer := 4);
    Port (pll_data: in  STD_LOGIC_VECTOR(N-1 downto 0);
          clk     : in  STD_LOGIC;
          syn_clr : in  STD_LOGIC;
          load    : in  STD_LOGIC;
          up      : in  STD_LOGIC;
          en      : in  STD_LOGIC;
          Q       : out STD_LOGIC_VECTOR(N-1 downto 0);
          max_tick: out STD_LOGIC;
          min_tick: out STD_LOGIC);
end sync_count;

architecture sync_count_arch of sync_count is
    signal incr : STD_LOGIC_VECTOR(N-1 downto 0); 
    signal q_inc: STD_LOGIC_VECTOR(N-1 downto 0);
    signal q_ena: STD_LOGIC_VECTOR(N-1 downto 0);
    signal q_nxt: STD_LOGIC_VECTOR(N-1 downto 0);
    signal d_now: STD_LOGIC_VECTOR(N-1 downto 0);
    signal q_now: STD_LOGIC_VECTOR(N-1 downto 0);
    
    signal one  : std_logic_vector(N-1 downto 0) := (0 => '1', others => '0'); 
    signal zero : std_logic_vector(N-1 downto 0) := (others => '0');
    signal max  : std_logic_vector(N-1 downto 0) := (others => '1');
begin
    -- Lógica combinacional estado siguiente
    with up select incr <= one when '1',
                           max when others;
     
    increment: entity work.add(add_arch)
        generic map(N => N)
        port map(a_i => q_now,
                 b_i => incr,
                 err => open,
                 r_o => q_inc);
    
    with en      select q_ena <= q_inc when '1',
                                 q_now when others;
    with load    select q_nxt <= pll_data when '1',
                                 q_ena when others; 
    with syn_clr select d_now <= zero when '1',
                                 q_nxt when others;
    
    -- Memoria sincrónica
    sync: entity work.FF_D(FF_D_arch)
        generic map(N => N)
        port map(clk => clk,
                 D => d_now,
                 Q => q_now);
    
    -- Lógica combinacional salida 
    max_tick <= '1' when q_now = max  else '0';
    min_tick <= '1' when q_now = zero else '0';
    
    Q <= q_now;
end architecture;
