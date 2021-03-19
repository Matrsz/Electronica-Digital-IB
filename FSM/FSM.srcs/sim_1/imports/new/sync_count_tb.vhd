----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: sync_count_tb of sync_count - sync_count_arch                    --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity sync_count_tb is
end;

architecture bench of sync_count_tb is
  component sync_count
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
  end component;

  signal pll_data: STD_LOGIC_VECTOR(4-1 downto 0);
  signal clk: STD_LOGIC;
  signal syn_clr: STD_LOGIC;
  signal load: STD_LOGIC;
  signal up: STD_LOGIC;
  signal en: STD_LOGIC;
  signal Q: STD_LOGIC_VECTOR(4-1 downto 0);
  signal max_tick: STD_LOGIC;
  signal min_tick: STD_LOGIC;
  
  constant T: time := 40 ns;
  constant clk_T: time := 10 ns;
  
begin
  uut: sync_count generic map ( N        =>  4)
                     port map ( pll_data => pll_data,
                                clk      => clk,
                                syn_clr  => syn_clr,
                                load     => load,
                                up       => up,
                                en       => en,
                                Q        => Q,
                                max_tick => max_tick,
                                min_tick => min_tick ); 
   clk_process :process
   begin
		clk <= '0';
		wait for clk_T/2;
		clk <= '1';
		wait for clk_T/2;
   end process;
 
  stimulus: process
  begin
    -- Inicialización
    pll_data <= "0101";
    syn_clr <= '0';
    en <= '1';
    up <= '1';
    load <= '1';
    wait for clk_t;
    load <='0';
    -- Test de cuenta ascendente y descendente
    wait for clk_t*13;
    up <= '0';
    wait for clk_T*4;
    -- Test de prioridades
    en <= '0';
    wait for clk_T;
    load <= '1';
    wait for clk_T;
    assert q = pll_data report "Error de prioridad" severity warning;
    syn_clr <= '1';
    wait for clk_T;
    assert q = "0000" report "Error de prioridad" severity warning;
    syn_clr <= '0';
    load <= '0';
    up <= '1';
    en <= '1';
    wait for clk_T*2;
    assert false report "Fin de simulación" severity failure;
  wait;
  end process;


end;