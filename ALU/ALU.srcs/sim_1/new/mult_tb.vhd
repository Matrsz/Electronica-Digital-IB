----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: mult_tb of mult - mult_arch                                      --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mult_tb is
end;

architecture bench of mult_tb is
  component mult
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           err : out STD_LOGIC);
  end component;

  signal A_i, B_i: STD_LOGIC_VECTOR (3 downto 0);
  signal r_o: STD_LOGIC_VECTOR (3 downto 0);
  signal err: STD_LOGIC;

begin
  uut: mult generic map ( N =>  4)
            port map (A_i => A_i,
                     B_i => B_i,
                     r_o => r_o,
                     err => err );

  stimulus: process
  begin
    A_i <= "0010"; B_i <= "0010";
    wait for 5 ns;
    assert r_o = "0100" and err = '0' report "<Error de operación>" severity warning;
    wait for 5 ns;
    
    A_i <= "0010"; B_i <= "1110";
    wait for 5 ns;
    assert r_o = "1100" and err = '0' report "<Error de operación>" severity warning;
    wait for 5 ns;
    
    A_i <= "0111"; B_i <= "0010";
    wait for 5 ns;
    assert err = '1' report "<Error de detección de overflow>" severity warning;
    wait for 5 ns;
    
    A_i <= "0111"; B_i <= "1110";
    wait for 5 ns;
    assert err = '1' report "<Error de detección de overflow>" severity warning;
    wait for 5 ns;
    
    A_i <= "1111"; B_i <= "1111";
    wait for 5 ns;
    assert r_o = "0001" and err = '0' report "<Error de conversión>" severity warning;
    wait for 5 ns;
    
    A_i <= "1100"; B_i <= "0000";
    wait for 5 ns;
    assert r_o = "0000" and err = '0' report "<Error de conversión>" severity warning;
    wait for 5 ns;
    
    A_i <= "0100"; B_i <= "1110";
    wait for 5 ns;
    assert err = '1' report "<Error de detección de overflow>" severity warning;
    wait for 5 ns;
      
    assert false report "<Fin de simulación>" severity failure;
    wait;
  end process;
end;