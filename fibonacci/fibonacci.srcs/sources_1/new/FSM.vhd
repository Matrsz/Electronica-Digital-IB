----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2020 01:12:44 AM
-- Design Name: 
-- Module Name: FSM - FSM_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    Port ( start    : in  STD_LOGIC;
           clk      : in  STD_LOGIC;
           rst      : in  STD_LOGIC;
           done_sig : in  STD_LOGIC;
           op_sig   : out STD_LOGIC;
           load     : out STD_LOGIC;
           ready    : out STD_LOGIC;
           done_tick: out STD_LOGIC);
end FSM;

architecture FSM_arch of FSM is
    type state_type is (idle, op, done);
    signal q_nxt, q_now : state_type := idle;
begin 
    sync: process(clk, rst)
    begin
        if rst = '1' then
            q_now <= idle;
        elsif rising_edge(clk) then
            q_now <= q_nxt;
        end if;
    end process;

    nxt: process(clk, rst, start, done_sig)
    begin
        q_nxt <= q_now;
        case q_now is
            when idle => if start = '1' then
                            q_nxt <= op;
                         end if;
            when op   => if done_sig = '1' then
                            q_nxt <= done;
                         end if;
            when done => q_nxt <= idle;
        end case;
    end process;
    
    op_sig    <= '1' when q_now = op   and done_sig = '0'  else '0';
    load      <= '1' when q_now = idle and start = '1'     else '0';
    ready     <= '1' when q_now = idle else '0';
    done_tick <= '1' when q_now = done else '0';
end FSM_arch;
