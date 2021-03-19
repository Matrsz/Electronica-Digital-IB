----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: ALU_tb of ALU - ALU_arch                                         --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ALU_tb is
end;

architecture bench of ALU_tb is
  component ALU
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N downto 0);
           err : out STD_LOGIC);
  end component;

  signal A_i, B_i: STD_LOGIC_VECTOR (3 downto 0);
  signal r_o: STD_LOGIC_VECTOR (4 downto 0);
  signal sel: STD_LOGIC_VECTOR (1 downto 0);
  signal err: STD_LOGIC;

begin
  uut: ALU generic map ( N =>  4)
           port map (A_i => A_i,
                     B_i => B_i,
                     sel => sel,
                     r_o => r_o,
                     err => err );

  stimulus: process
  begin
    -- Tests de suma
    A_i <= "0101"; B_i <= "0010";
    sel <= "00";
    wait for 5 ns;
    assert r_o = "00111" and err = '0' report "<Error de operación suma>" severity warning;
    wait for 5 ns;
    
    A_i <= "1101"; B_i <= "1010";
    sel <= "00";
    wait for 5 ns;
    assert r_o = "10111" and err = '0' report "<Error de operación suma>" severity warning;
    wait for 5 ns;
    
    --Tests de resta
    A_i <= "0100"; B_i <= "0101";
    sel <= "01";
    wait for 5 ns;
    assert r_o = "10001" and err = '0' report "<Error de operación resta>" severity warning;
    wait for 5 ns;
    
    A_i <= "1010"; B_i <= "0011";
    sel <= "01";
    wait for 5 ns;
    assert r_o = "10101" and err = '0' report "<Error de operación resta>" severity warning;
    wait for 5 ns;
    
    -- Tests de multiplicación
    A_i <= "0011"; B_i <= "0010";
    sel <= "10";
    wait for 5 ns;
    assert r_o = "00110" and err = '0' report "<Error de operación multipl>" severity warning;
    wait for 5 ns;

    A_i <= "1100"; B_i <= "1011";
    sel <= "10";
    wait for 5 ns;
    assert r_o = "01100" and err = '0' report "<Error de operación multipl>" severity warning;
    wait for 5 ns;

    A_i <= "0111"; B_i <= "0100";
    sel <= "10";
    wait for 5 ns;
    assert err = '1' report "<Error de detección de overflow>" severity warning;
    wait for 5 ns;

    A_i <= "0100"; B_i <= "1100";
    sel <= "10";
    wait for 5 ns;
    assert err = '1' report "<Error de detección de overflow>" severity warning;
    wait for 5 ns;
    
    -- Tests de igualdad
    A_i <= "0111"; B_i <= "0111";
    sel <= "11";
    wait for 5 ns;
    assert r_o = "00001" and err = '0' report "<Error de operación igual>" severity warning;
    wait for 5 ns;

    A_i <= "0001"; B_i <= "0111";
    sel <= "11";
    wait for 5 ns;
    assert r_o = "00000" and err = '0' report "<Error de operación igual>" severity warning;
    wait for 5 ns;

    assert false report "<Fin de Simulación>" severity failure;
    wait;
  end process;
end;