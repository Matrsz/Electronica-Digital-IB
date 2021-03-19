----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: bmux4 - bmux4_arch                                              --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bmux2 is
    Generic (N : integer := 4);
    Port ( sel : in STD_LOGIC;
           Z_o : out STD_LOGIC;
           Z_0, Z_1: in STD_LOGIC);
end entity;

architecture mux2_arch of bmux2 is
begin
    with sel select Z_o <= Z_1 when '1',
                           Z_0 when others;
end architecture;
