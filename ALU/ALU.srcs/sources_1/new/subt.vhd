----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: subt - subt_arch                                                --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subt is
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           err : out STD_LOGIC);
end entity;

architecture subt_arch of subt is
    signal A_ext, B_ext, r_ext : STD_LOGIC_VECTOR(N downto 0);
begin
    A_ext <= A_i(N-1) & A_i;
    B_ext <= B_i(N-1) & B_i;
    r_ext <= STD_LOGIC_VECTOR(signed(A_ext) - signed(B_ext));
    r_o <= r_ext(N-1 downto 0);
    err <= r_ext(N) XOR r_ext(N-1);
end architecture;
