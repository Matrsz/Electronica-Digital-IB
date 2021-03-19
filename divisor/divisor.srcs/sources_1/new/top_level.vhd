----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: top_level - top_level_arch                                      --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Generic (N :integer := 4);
      Port (clk   : in  STD_LOGIC;
            A     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            B     : in  STD_LOGIC_VECTOR(N-1 downto 0);
            div   : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(N-1 downto 0);
            R     : out STD_LOGIC_VECTOR(N-1 downto 0);
            done  : out STD_LOGIC;
            ready : out STD_LOGIC); 
end top_level;

architecture top_level_arch of top_level is
    signal op_sig, done_sig, start : STD_LOGIC;
begin
    datapath : entity work.datapath(datapath_arch)
      Generic map (N  => N)
      Port map (clk   => clk,
                A     => A,
                B     => B,
                op_sig=> op_sig,
                start => start,
                Q     => Q,
                R     => R,
                done  => done_sig); 
    controlpath : entity work.controlpath(controlpath_arch)
      Port map (clk   => clk,
                div   => div,
                op_sig=> op_sig,
                start => start,
                done  => done_sig,
                ready => ready); 
    done <= done_sig;
end top_level_arch;
