----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: twocomplement - twocomplement_arch                              --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity twocomplement is
    Generic ( N : integer := 4);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Y : out STD_LOGIC_VECTOR (N-1 downto 0)
         );
end entity;

architecture twocomplement_arch of twocomplement is
    signal one : STD_LOGIC_VECTOR(N-1 downto 0) := (0 => '1', others => '0');
begin
    Y <= STD_LOGIC_VECTOR(unsigned(not X) + unsigned(one));
end architecture;
