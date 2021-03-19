----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: mult - mult_arch                                                --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N-1 downto 0);
           err : out STD_LOGIC);
end entity;

architecture mult_arch of mult is
    signal r_ext : STD_LOGIC_VECTOR(2*N-1 downto 0);
    signal r_sig : STD_LOGIC_VECTOR(N-1 downto 0);
    signal limit : STD_LOGIC_VECTOR(N-1 downto 0) := (N-1 => '1', others => '0');
begin
    r_ext <= STD_LOGIC_VECTOR(signed(A_i) * signed(B_i));
    r_sig <= r_ext(N-1 downto 0);
    err <= '1' when r_sig = limit else r_ext(2*N-1) XOR r_ext(N-1);
    r_o <= r_sig; 
end architecture;
