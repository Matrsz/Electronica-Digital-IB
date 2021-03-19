----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: FSN_tb of FSM - FSM_arch                                         --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_tb is
end;

architecture bench of FSM_tb is
  component FSM
      port (clk: in  STD_LOGIC;
            rst: in  STD_LOGIC;
            A: in  STD_LOGIC;
            B: in  STD_LOGIC;
            entr_sig: out STD_LOGIC;
            exit_sig: out STD_LOGIC;
            ctrl: out STD_LOGIC_VECTOR(1 downto 0));
  end component;

  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC;
  signal A: STD_LOGIC;
  signal B: STD_LOGIC;
  signal entr_sig: STD_LOGIC;
  signal exit_sig: STD_LOGIC;
  signal ctrl: STD_LOGIC_VECTOR(1 downto 0);

  constant T: time := 30 ns;
  constant clk_T: time := 10 ns;
  
begin
  uut: FSM port map ( clk      => clk,
                      rst      => rst,
                      A        => A,
                      B        => B,
                      entr_sig => entr_sig,
                      exit_sig => exit_sig,
                      ctrl     => ctrl );
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
    rst <= '0';
    A <= '0';
    B <= '0';
    wait for clk_T;

    -- Simulación auto entrante
    A <= '1';
    B <= '0';
    wait for T;
    assert ctrl = "01" report "Error transición wait->entr" severity warning;
    A <= '1';
    B <= '1';
    wait for T;
    assert ctrl = "00" report "Error transición entr->wait" severity warning;
    A <= '0';
    B <= '1';
    wait for T;
    assert ctrl = "10" report "Error transición entr->exit" severity warning;
    A <= '0';
    B <= '0';
    wait for T;
    assert ctrl = "00" report "Error transición exit->entr" severity warning;

    -- Simulación auto saliente
    A <= '0';
    B <= '1';
    wait for T;
    assert ctrl = "10" report "Error transición wait->exit" severity warning;
    A <= '1';
    B <= '1';
    wait for T;
    assert ctrl = "00" report "Error transición exit->wait" severity warning;
    A <= '1';
    B <= '0';
    wait for T;
    assert ctrl = "01" report "Error transición wait->entr" severity warning;
    A <= '0';
    B <= '0';
    wait for T;
    assert ctrl = "00" report "Error transición entr->wait" severity warning;
 
    -- Simulación auto cambia de idea 1
    A <= '1';
    B <= '0';
    wait for T;
    A <= '0';
    B <= '0';
    wait for T;

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
    
    assert false report "Fin de simulación" severity failure;
    wait;
  end process;
end;