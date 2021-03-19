----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: top_level - top_level_arch                                      --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Generic (N : integer := 5);
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC := '0';
           load: in STD_LOGIC := '0';
           A: in STD_LOGIC;
           B: in STD_LOGIC;
           pll_data: in STD_LOGIC_VECTOR(N-1 downto 0);
           autos: out STD_LOGIC_VECTOR (N-1 downto 0);
           full : out STD_LOGIC;
           empty: out STD_LOGIC);
end entity;

architecture arch of top_level is
    signal entr_sig, exit_sig, en, up: std_logic;
begin
    FSM: entity work.FSM(FSM_alt)
        port map(clk => clk,
                 rst => rst,
                 A => A,
                 B => B,
                 entr_sig => entr_sig,
                 exit_sig => exit_sig,
                 ctrl => open);   
                  
    en <= entr_sig OR exit_sig;
    up <= entr_sig OR not exit_sig;
    
    Contador: entity work.sync_count(sync_count_arch)
        generic map (N => N)
        port map(clk  => clk,
                 rst  => rst,
                 load => load,
                 pll_data => pll_data,
                 en => en,
                 up => up,
                 Q  => autos,
                 max_tick => full,
                 min_tick => empty);       
end arch;
