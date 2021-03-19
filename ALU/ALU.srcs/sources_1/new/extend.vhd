----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: extend - extend_arch                                            --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extend is
    Generic ( N : integer := 4);
    Port ( X : in STD_LOGIC_VECTOR (N-1 downto 0);
           Y : out STD_LOGIC_VECTOR (N downto 0));
end entity;

architecture extend_arch of extend is
begin
    Y <= X(N-1) & X;
end architecture;
