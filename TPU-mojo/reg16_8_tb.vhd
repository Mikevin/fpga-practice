--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:01:57 09/06/2018
-- Design Name:   
-- Module Name:   D:/Fpga/fpga-practice/TPU-mojo/reg16_8_tb.vhd
-- Project Name:  Mojo-Base
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg16_8
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
--USE ieee.numeric_std.ALL;
 
ENTITY reg16_8_tb IS
END reg16_8_tb;
 
ARCHITECTURE behavior OF reg16_8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg16_8
    PORT(
         I_clk : IN  std_logic;
         I_en : IN  std_logic;
         I_dataD : IN  std_logic_vector(15 downto 0);
         O_dataA : OUT  std_logic_vector(15 downto 0);
         O_dataB : OUT  std_logic_vector(15 downto 0);
         I_selA : IN  std_logic_vector(2 downto 0);
         I_selB : IN  std_logic_vector(2 downto 0);
         I_selD : IN  std_logic_vector(2 downto 0);
         I_we : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal I_clk : std_logic := '0';
   signal I_en : std_logic := '0';
   signal I_dataD : std_logic_vector(15 downto 0) := (others => '0');
   signal I_selA : std_logic_vector(2 downto 0) := (others => '0');
   signal I_selB : std_logic_vector(2 downto 0) := (others => '0');
   signal I_selD : std_logic_vector(2 downto 0) := (others => '0');
   signal I_we : std_logic := '0';

 	--Outputs
   signal O_dataA : std_logic_vector(15 downto 0);
   signal O_dataB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg16_8 PORT MAP (
          I_clk => I_clk,
          I_en => I_en,
          I_dataD => I_dataD,
          O_dataA => O_dataA,
          O_dataB => O_dataB,
          I_selA => I_selA,
          I_selB => I_selB,
          I_selD => I_selD,
          I_we => I_we
        );

   -- Clock process definitions
   I_clk_process :process
   begin
		I_clk <= '0';
		wait for I_clk_period/2;
		I_clk <= '1';
		wait for I_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for I_clk_period*10;

      -- insert stimulus here 
		I_en <= '1';
		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "000";
		I_dataD <= x"FAB5";
		I_we <= '1';
		wait for I_clk_period;

      wait;
   end process;

END;
