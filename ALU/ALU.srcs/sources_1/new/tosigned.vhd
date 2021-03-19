----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: tosigned - tosigned_arch                                        --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tosigned is
    Generic ( N : integer := 4);
    Port ( X : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Y : out STD_LOGIC_VECTOR (N-1 downto 0)
         );
end entity;

architecture tosigned_arch of tosigned is
    signal sig : STD_LOGIC;
    signal val : STD_LOGIC_VECTOR(N-1 downto 0);
    signal ca2 : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    sig <= X(N-1);
    val <= ('0' & X(N-2 downto 0));
    twocomplement: entity work.twocomplement(twocomplement_arch)
        Generic map (N => N)
        Port map (X => val, Y => ca2);
    with sig select Y <= ca2 when '1', val when others;
end architecture;
