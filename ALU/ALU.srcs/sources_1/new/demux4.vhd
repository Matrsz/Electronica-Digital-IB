----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: demux4 - demux4_arch                                            --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux4 is
    Generic (N : integer := 4);
    Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
           Z_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           Z_00, Z_01, Z_10, Z_11 : out STD_LOGIC_VECTOR (N-1 downto 0));
end entity;

architecture demux4_Arch of demux4 is
begin
    Z_00 <= Z_i when sel = "00" else (others => 'Z');
    Z_01 <= Z_i when sel = "01" else (others => 'Z');
    Z_10 <= Z_i when sel = "10" else (others => 'Z');
    Z_11 <= Z_i when sel = "11" else (others => 'Z');
end architecture;
