----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: mux4 - mux4_arch                                            --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Generic (N : integer := 4);
    Port ( sel : in STD_LOGIC;
           Z_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           Z_0, Z_1 : in STD_LOGIC_VECTOR (N-1 downto 0));
end entity;

architecture mux2_arch of mux2 is
begin
    with sel select Z_o <= Z_1 when '1',
                           Z_0 when others;
end architecture;
