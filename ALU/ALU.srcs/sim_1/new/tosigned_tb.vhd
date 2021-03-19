----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Test Bench: tosigned_tb of tosigned - tosigned_arch                          --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tosigned_tb is
end;

architecture bench of tosigned_tb is
  component tosigned
      Generic ( N : integer := 3);
      Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0);
             Y : out STD_LOGIC_VECTOR (N-1 downto 0)
           );
  end component;

  signal X: STD_LOGIC_VECTOR (3-1 downto 0);
  signal Y: STD_LOGIC_VECTOR (3-1 downto 0) ;

begin
  uut: tosigned generic map ( N =>  3)
                port map ( X => X,
                           Y => Y );

  stimulus: process
  begin
    X <= "000";
    wait for 5 ns;
    assert Y = "000" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "001";
    wait for 5 ns;
    assert Y = "001" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "010";
    wait for 5 ns;
    assert Y = "010" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "011";
    wait for 5 ns;
    assert Y = "011" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "100";
    wait for 5 ns;
    assert Y = "000" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "101";
    wait for 5 ns;
    assert Y = "111" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "110";
    wait for 5 ns;
    assert Y = "101" report "<Error de conversión>" severity warning;
    wait for 5 ns;       
    
    X <= "111";
    wait for 5 ns;
    assert Y = "100" report "<Error de conversión>" severity warning;
    wait for 5 ns;
       
    assert false report "<Fin de Simulación>" severity failure;
    wait;
  end process;
end;