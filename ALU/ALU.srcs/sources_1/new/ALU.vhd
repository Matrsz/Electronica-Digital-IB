----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: ALU - ALU_arch                                                  --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Generic ( N : integer := 4);
    Port ( A_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_i : in STD_LOGIC_VECTOR (N-1 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           r_o : out STD_LOGIC_VECTOR (N downto 0);
           err : out STD_LOGIC);
end ALU;

architecture ALU_arch of ALU is
    signal A_ext, B_ext, r_sig : STD_LOGIC_VECTOR(N downto 0);
    signal A_sig, B_sig : STD_LOGIC_VECTOR(N-1 downto 0);
    signal A_a, A_s, A_m, A_e : STD_LOGIC_VECTOR(N downto 0);
    signal B_a, B_s, B_m, B_e : STD_LOGIC_VECTOR(N downto 0);
    signal r_a, r_s, r_m, r_e : STD_LOGIC_VECTOR(N downto 0);
    signal err_a, err_s, err_m, err_e : STD_LOGIC;
begin
    Atosigned: entity work.tosigned(tosigned_arch)
        Generic map (N => N)
        Port map (X => A_i, Y => A_sig);
    Btosigned: entity work.tosigned(tosigned_arch)
        Generic map (N => N)
        Port map (X => B_i, Y => B_sig);
    Aextend: entity work.extend(extend_arch)
        Generic map (N => N)
        Port map (X => A_sig, Y => A_ext);
    Bextend: entity work.extend(extend_arch)
        Generic map (N => N)
        Port map (X => B_sig, Y => B_ext);
    
    Ademux: entity work.demux4(demux4_arch)
        Generic map (N => N+1)
        Port map (sel => sel,
                  Z_i => A_ext,
                  Z_00 => A_a, 
                  Z_01 => A_s, 
                  Z_10 => A_m, 
                  Z_11 => A_e);
    Bdemux: entity work.demux4(demux4_arch)
        Generic map (N => N+1)
        Port map (sel => sel,
                  Z_i => B_ext,
                  Z_00 => B_a, 
                  Z_01 => B_s, 
                  Z_10 => B_m, 
                  Z_11 => B_e);
    
    add: entity work.add(add_arch)
        Generic map (N => N+1)
        Port map (A_i => A_a, 
                  B_i => B_a,
                  r_o => r_a,
                  err => err_a);
    subt: entity work.subt(subt_arch)
        Generic map (N => N+1)
        Port map (A_i => A_s, 
                  B_i => B_s,
                  r_o => r_s,
                  err => err_s);
    mult: entity work.mult(mult_arch)
        Generic map (N => N+1)
        Port map (A_i => A_m, 
                  B_i => B_m,
                  r_o => r_m,
                  err => err_m);
    eq: entity work.eq(eq_arch)
        Generic map (N => N+1)
        Port map (A_i => A_e, 
                  B_i => B_e,
                  r_o => r_e,
                  err => err_e);
    
    rmux: entity work.mux4(mux4_arch)
        Generic map (N => N+1)
        Port map (sel => sel,
                  Z_o => r_sig,
                  Z_00 => r_a, 
                  Z_01 => r_s, 
                  Z_10 => r_m, 
                  Z_11 => r_e);
    emux: entity work.bmux4(mux4_arch)
        Generic map (N => N+1)
        Port map (sel => sel,
                  Z_o => err,
                  Z_00 => err_a, 
                  Z_01 => err_s, 
                  Z_10 => err_m, 
                  Z_11 => err_e);
                           
    rfromsigned: entity work.tosigned(tosigned_arch)
        Generic map (N => N+1)
        Port map (X => r_sig, Y => r_o);
end architecture;
