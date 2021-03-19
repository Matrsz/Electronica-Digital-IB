----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: top_level_tb of top_level - top_level_arch                       --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity top_level_tb is
end;

architecture bench of top_level_tb is

  component top_level
      Generic (N : integer := 5);
      Port ( clk: in STD_LOGIC;
             rst: in STD_LOGIC;
             A: in STD_LOGIC;
             B: in STD_LOGIC;
             load: in STD_LOGIC;
             pll_data: in STD_LOGIC_VECTOR(N-1 downto 0);
             autos: out STD_LOGIC_VECTOR (N-1 downto 0);
             full : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal A: STD_LOGIC;
  signal B: STD_LOGIC;
  signal load: STD_LOGIC;
  signal pll_data: STD_LOGIC_VECTOR(5-1 downto 0);
  signal autos: STD_LOGIC_VECTOR (5-1 downto 0);
  signal full: STD_LOGIC;
    
  constant T: time := 20 ns;
  constant clk_T: time := 10 ns;

begin
 uut: top_level generic map ( N        =>  5)
                    port map ( clk      => clk,
                               rst      => rst,
                               A        => A,
                               B        => B,
                               load     => load,
                               pll_data => pll_data,
                               autos    => autos,
                               full     => full );
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
    rst <= '1';
    A <= '0';
    B <= '0';
    pll_data <= "11110";
    load <= '0';
    wait for clk_T;
    rst <= '0';
    
    -- Simulación auto entrante
    A <= '1';
    B <= '0';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '0';
    B <= '1';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "00001" report "Error cuenta" severity warning;

    -- Simulación auto saliente
    A <= '0';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "00000" report "Error cuenta" severity warning;
 
-- Simulación auto cambia de idea 1
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "00000" report "Error cuenta" severity warning;

     -- Simulación auto cambia de idea 2
    A <= '1';
    B <= '0';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "00000" report "Error cuenta" severity warning;

    -- Simulación auto cambia de idea 3
    A <= '1';
    B <= '0';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '0';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "00000" report "Error cuenta" severity warning;
    
-- Quitar el siguiente comentario si se desea hacer solamente la prueba de conteo
--    assert false report "Fin de simulación" severity failure; 

    -- Carga Paralela
    load <= '1';
    wait for T;
    load <= '0';
    wait for T;
    assert autos = "11110" report "Error cuenta" severity warning;
    
    -- Simulación auto entrante
    A <= '1';
    B <= '0';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '0';
    B <= '1';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "11111" report "Error cuenta" severity warning;

    -- Simulación auto saliente
    A <= '0';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '1';
    wait for T;
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;
    assert autos = "11110" report "Error cuenta" severity warning;

    assert false report "Fin de simulación" severity failure;
    wait;
  end process;end;