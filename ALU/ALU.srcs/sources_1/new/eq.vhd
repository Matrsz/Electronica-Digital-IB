----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: eq - eq_arch                                                    --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eq is
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           err : out STD_LOGIC);
end entity;

architecture eq_arch of eq is
begin
    err <= '0';
    r_o <= (0 => '1', others => '0') when A_i = B_i else (others => '0');
end architecture;
