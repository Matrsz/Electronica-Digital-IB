----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: FF_D - FF_D_arch                                                --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_D is
    Generic ( N : integer := 4);
    Port ( clk : in STD_LOGIC;
           en  : in STD_LOGIC := '1';
           rst : in STD_LOGIC := '0';
           D : in  STD_LOGIC_VECTOR(N-1 downto 0);
           Q : out STD_LOGIC_VECTOR(N-1 downto 0));
end entity;

architecture FF_D_arch of FF_D is
begin
    sync:process (clk, en, rst)
         begin 
         if rst = '1' then
            Q <= (others => '0');
         elsif rising_edge(clk) and en = '1' then
            Q <= D;
         end if;
    end process;
end architecture;
