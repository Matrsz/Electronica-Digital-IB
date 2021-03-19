----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 10:43:21 PM
-- Design Name: 
-- Module Name: datapath - datapath_arch
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
    Generic (N: natural := 32);
    Port ( i : in STD_LOGIC_VECTOR(4 downto 0);
           op_sig : in STD_LOGIC;
           load: in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           done_sig : out STD_LOGIC;
           fib : out STD_LOGIC_VECTOR(19 downto 0));
end entity;

architecture datapath_arch of datapath is
    signal n_nxt,  n_now : STD_LOGIC_VECTOR(4 downto 0);
    signal t0_nxt, t0_now: STD_LOGIC_VECTOR(19 downto 0);
    signal t1_nxt, t1_now: STD_LOGIC_VECTOR(19 downto 0);
  
    signal minus_one : STD_LOGIC_VECTOR(4 downto 0) := (others => '1');  
    signal zero : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal one  : STD_LOGIC_VECTOR(4 downto 0) := (0 => '1', others => '0');
begin
    t0_reg: process(clk, rst)
    begin
        if rst = '1' then
            t0_now <= (others => '0');
        elsif rising_edge(clk) then
            t0_now <= t0_nxt;
        end if;
    end process;
    
    t1_reg: process(clk, rst)
    begin
        if rst = '1' then
            t1_now <= (others => '0');
        elsif rising_edge(clk) then
            t1_now <= t1_nxt;
        end if;
    end process;
    
    n_reg: process(clk, rst)
    begin
        if rst = '1' then
            n_now <= (others => '0');
        elsif rising_edge(clk) then
            n_now <= n_nxt;
        end if;
    end process;
    
    t0_nxt <= (others => '0') when load='1'   else
              t1_now          when op_sig='1' else
              t0_now;
              
    t1_nxt <= (0 => '1', others => '0')                             when load='1'   else
              (others => '0')                                       when n_now=zero else 
              std_logic_vector(unsigned(t0_now)+unsigned(t1_now))   when op_sig='1' else
              t1_now;
              
    n_nxt <=  i                                                     when load='1'   else
              std_logic_vector(unsigned(n_now)+unsigned(minus_one)) when op_sig='1' else
              n_now;
    
    done_sig <= '1' when n_now = zero or n_now = one else '0';
    fib <= t1_now;
end architecture;
