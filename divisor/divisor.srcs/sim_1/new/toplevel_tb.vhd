----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: toplevel_tb of top_level(top_level_arch)                        --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity toplevel_tb is
end;

architecture bench of toplevel_tb is

  component top_level
      Generic (N: integer := 4);
      Port (clk   : in  STD_LOGIC;
            A     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            B     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            div   : in  STD_LOGIC;
            ready : out  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(N-1 downto 0);
            R     : out STD_LOGIC_VECTOR(N-1 downto 0);
            done  : out STD_LOGIC);
  end component;
  constant N : integer := 4;
  signal clk: STD_LOGIC;
  signal A: STD_LOGIC_VECTOR(N-1 downto 0);
  signal B: STD_LOGIC_VECTOR(N-1 downto 0);
  signal div: STD_LOGIC;
  signal ready: STD_LOGIC;
  signal Q: STD_LOGIC_VECTOR(N-1 downto 0);
  signal R: STD_LOGIC_VECTOR(N-1 downto 0);
  signal done: STD_LOGIC;
  constant clk_T : time := 10 ns;
begin

   clk_process :process
   begin
		clk <= '0';
		wait for clk_T/2;
		clk <= '1';
		wait for clk_T/2;
   end process;
 
  uut: top_level generic map ( N      =>  N)
                   port map ( clk    => clk,
                              A      => A,
                              B      => B,
                              div    => div,
                              ready  => ready,
                              Q      => Q,
                              R      => R,
                              done   => done );

  stimulus: process
  begin
  
  -- Pruebas de división exacta
  
   A <= "1111";
   B <= "0101";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0011" and R = "0000" report "Error en 15/5" severity warning;  
   wait for clk_T;

   A <= "1111";
   B <= "0011";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0101" and R = "0000" report "Error en 15/3" severity warning;  
   wait for clk_T;
   
   A <= "1111";
   B <= "1111";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0001" and R = "0000" report "Error en 15/15" severity warning;  
   wait for clk_T;

   A <= "1111";
   B <= "0001";   
   div <= '1';
   wait for clk_T;
   div <= '0';   
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "1111" and R = "0000" report "Error en 15/1" severity warning;  
   wait for clk_T;

    -- Pruebas de división con resto
   A <= "1111";
   B <= "0100";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0011" and R = "0011" report "Error en 15/4" severity warning;  
   wait for clk_T;

   A <= "0110";
   B <= "0100";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0001" and R = "0010" report "Error en 6/4" severity warning;  
   wait for clk_T;
   
   A <= "0101";
   B <= "0010";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0010" and R = "0001" report "Error en 5/2" severity warning;  
   wait for clk_T;
   
   A <= "0101";
   B <= "1111";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0000" and R = "0101" report "Error en 5/15" severity warning;  
   wait for clk_T;

   A <= "0100";
   B <= "1010";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0000" and R = "0100" report "Error en 4/10" severity warning;  
   wait for clk_T;
   
   A <= "0000";
   B <= "1010";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert Q = "0000" and R = "0000" report "Error en 0/10" severity warning;  
   wait for clk_T;
   
   -- Solo para saber que sucede en una división por 0
   A <= "0101";
   B <= "0000";   
   div <= '1';
   wait for clk_T;
   div <= '0';
   wait until rising_edge(ready);
   wait for clk_T;
   assert false report "#Err_div0" severity warning;
   wait for clk_T;
   
   assert false report "Fin de simulación" severity failure;
   end process;


end;