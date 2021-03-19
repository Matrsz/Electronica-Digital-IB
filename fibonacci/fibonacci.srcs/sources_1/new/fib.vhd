----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2020 02:33:02 AM
-- Design Name: 
-- Module Name: fib - fib_tb
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

entity fib is
    Generic (N : integer := 32);
    Port ( start    : in  STD_LOGIC;
           clk      : in  STD_LOGIC;
           rst      : in  STD_LOGIC;
           i        : in  STD_LOGIC_VECTOR(4 downto 0);
           f        : out STD_LOGIC_VECTOR(19 downto 0);
           ready    : out STD_LOGIC;
           done_tick: out STD_LOGIC);
end entity;

architecture fib_arch of fib is
    signal done_sig, load, op_sig : STD_LOGIC; 
begin
    FSM: entity work.FSM(FSM_arch)
        port map(clk => clk,
                 rst => rst,
                 start => start,
                 done_sig => done_sig,
                 op_sig => op_sig,
                 load => load,
                 ready => ready,
                 done_tick => done_tick);
    datapath: entity work.datapath(datapath_arch)
        generic map (N => N)
        port map(clk => clk,
                 rst => rst,
                 load => load,
                 i => i,
                 done_sig => done_sig,
                 op_sig => op_sig,
                 fib => f);
end architecture;
