--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:15:41 08/02/2015
-- Design Name:   
-- Module Name:   C:/IMF/_2015/_06_fsmd/fibonacci/tb_fibonacci.vhd
-- Project Name:  fibonacci
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fib
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
 
ENTITY tb_fibonacci IS
END tb_fibonacci;
 
ARCHITECTURE behavior OF tb_fibonacci IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fib
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         start : IN  std_logic;
         i : IN  std_logic_vector(4 downto 0);
         ready : OUT  std_logic;
         done_tick : OUT  std_logic;
         f : OUT  std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';
   signal i : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ready : std_logic;
   signal done_tick : std_logic;
   signal f : std_logic_vector(19 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fib PORT MAP (
          clk => clk,
          rst => rst,
          start => start,
          i => i,
          ready => ready,
          done_tick => done_tick,
          f => f
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold rst state for 100 ns.
		rst <= '1';
      wait for 5 ns;	
		
		rst <= '0';
	
		-- caso 0
		i<= (others => '0');
		start <= '1';
		
		wait until rising_edge(done_tick);
		start <= '0';
		assert f = CONV_STD_LOGIC_VECTOR(0,20) report "Fallo caso cero" severity failure;
		
		wait until ready <= '1';
		
		-- caso 1
		i<= CONV_STD_LOGIC_VECTOR(1,5);
		start <= '1';

		wait until rising_edge(done_tick);
		start <= '0';
		assert f = CONV_STD_LOGIC_VECTOR(1,20) report "Fallo caso uno" severity failure;


		wait until ready <= '1';
		
		-- caso 11
		i <= CONV_STD_LOGIC_VECTOR(11,5);
		start <= '1';

		wait until rising_edge(done_tick);
		start <= '0';
		assert f = CONV_STD_LOGIC_VECTOR(89,20) report "Fallo caso once" severity failure;

		wait until ready <= '1';
		assert false report "Fin simulacion OK" severity failure;


   end process;

END;
