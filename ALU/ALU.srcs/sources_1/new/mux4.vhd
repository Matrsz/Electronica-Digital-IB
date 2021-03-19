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

entity mux4 is
    Generic (N : integer := 4);
    Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
           Z_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           Z_00, Z_01, Z_10, Z_11 : in STD_LOGIC_VECTOR (N-1 downto 0));
end entity;

architecture mux4_arch of mux4 is
begin
    with sel select Z_o <= Z_11 when "11", 
                           Z_10 when "10",
                           Z_01 when "01",
                           Z_00 when others;
end architecture;
