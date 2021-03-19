----------------------------------------------------------------------------------
-- Matías Daniel Roqueta                                                        --
--                                                                              --
-- Instituto Balseiro - Comisión Nacional de Energía Atómica                    --
--                                                                              --
-- Module Name: controlpath - controlpath_arch                                  --
-- Revision 0.01 - File Created                                                 --
----------------------------------------------------------------------------------


-- La máquina de control es etremadamente simple. Es una máquina de 1 bit y usa un diseño puramente Mealy
-- Notar que no tiene señal de salida done_tick
-- Esto es porque la responsabilidad de informar si la salida es válida se delegó al datapath
-- La forma de interpretar está máquina es que informa la validez del resultado por nivel, no con un pulso.
-- Almacena el resultado de la última instrucción informándolo como válido hasta que reciba una nueva instrucción de división

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controlpath is
      Port (rst   : in  STD_LOGIC := '0';
            clk   : in  STD_LOGIC;
            div   : in  STD_LOGIC;
            start : out STD_LOGIC;
            op_sig: out STD_LOGIC;
            done  : in  STD_LOGIC;
            ready : out STD_LOGIC); 
end controlpath;

architecture controlpath_arch of controlpath is
    type state_type is (idle, op);
    signal q_now, q_nxt : state_type := idle;
begin
    sync: process(clk, rst)
    begin
        if rst = '1' then
            q_now <= idle;
        elsif rising_edge(clk) then
            q_now <= q_nxt;
        end if;
    end process;

    nxt: process(clk, rst, div, done)
    begin
        q_nxt <= q_now;
        case q_now is
            when idle => if div = '1' then
                            q_nxt <= op;
                         end if;
            when op   => if done = '1' then
                            q_nxt <= idle;
                         end if;
        end case;
    end process;
    
    op_sig    <= '1' when q_now = op   and done = '0' else '0';
    start     <= '1' when q_now = idle and div  = '1' else '0';
    ready     <= '1' when q_now = idle else '0';
end architecture;
