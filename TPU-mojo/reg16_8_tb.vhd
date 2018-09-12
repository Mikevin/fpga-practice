--------------------------------------------------------------------------------
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test. Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg16_8_tb IS
END reg16_8_tb;

ARCHITECTURE behavior OF reg16_8_tb IS

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT reg16_8
		PORT (
			I_clk : IN std_logic;
			I_en : IN std_logic;
			I_dataD : IN std_logic_vector(15 DOWNTO 0);
			O_dataA : OUT std_logic_vector(15 DOWNTO 0);
			O_dataB : OUT std_logic_vector(15 DOWNTO 0);
			I_selA : IN std_logic_vector(2 DOWNTO 0);
			I_selB : IN std_logic_vector(2 DOWNTO 0);
			I_selD : IN std_logic_vector(2 DOWNTO 0);
			I_we : IN std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL I_clk : std_logic := '0';
	SIGNAL I_en : std_logic := '0';
	SIGNAL I_dataD : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL I_selA : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL I_selB : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL I_selD : std_logic_vector(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL I_we : std_logic := '0';

	--Outputs
	SIGNAL O_dataA : std_logic_vector(15 DOWNTO 0);
	SIGNAL O_dataB : std_logic_vector(15 DOWNTO 0);

	-- Clock period definitions
	CONSTANT I_clk_period : TIME := 10 ns;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : reg16_8
	PORT MAP(
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
	I_clk_process : PROCESS
	BEGIN
		I_clk <= '0';
		WAIT FOR I_clk_period/2;
		I_clk <= '1';
		WAIT FOR I_clk_period/2;
	END PROCESS;
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		WAIT FOR I_clk_period * 2;

		-- insert stimulus here

		I_en <= '1';

		-- test for writing.
		-- r0 = 0xfab5
		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "000";
		I_dataD <= X"FAB5";
		I_we <= '1';
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"0000") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 1 failed" SEVERITY error;

		-- r2 = 0x2222
		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "010";
		I_dataD <= X"2222";
		I_we <= '1';
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"FAB5") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 2 failed" SEVERITY error;

		-- r3 = 0x3333
		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "010";
		I_dataD <= X"3333";
		I_we <= '1';
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"FAB5") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 3 failed" SEVERITY error;

		--test just reading, with no write
		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "000";
		I_dataD <= X"FEED";
		I_we <= '0';
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"FAB5") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 4 failed" SEVERITY error;

		--at this point dataA should not be 'feed'

		I_selA <= "001";
		I_selB <= "010";
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"0000") AND (O_dataB = X"3333")) -- expected output
		REPORT "Step 5 failed" SEVERITY error;

		I_selA <= "011";
		I_selB <= "100";
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"0000") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 6 failed" SEVERITY error; 

		I_selA <= "000";
		I_selB <= "001";
		I_selD <= "100";
		I_dataD <= X"4444";
		I_we <= '1';
		WAIT FOR I_clk_period;
		ASSERT ((O_dataA = X"FAB5") AND (O_dataB = X"0000")) -- expected output
		REPORT "Step 7 failed" SEVERITY error;

		I_we <= '0';
		WAIT FOR I_clk_period;

		-- nop
		WAIT FOR I_clk_period;

		I_selA <= "100";
		I_selB <= "100";
		WAIT FOR I_clk_period;

		wait;
	END PROCESS;

END;