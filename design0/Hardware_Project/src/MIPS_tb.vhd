									LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MIPSProcessor_tb IS
END MIPSProcessor_tb;

ARCHITECTURE behavior OF MIPSProcessor_tb IS

    -- Component declaration for the MIPS Processor
    COMPONENT MIPSProcessor
    PORT(
        clk : IN std_logic;
        reset : IN std_logic
    );
    END COMPONENT;

    -- Clock and reset signals
    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '0';	 
	
	
	



    -- Clock period definition
    CONSTANT clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: MIPSProcessor PORT MAP(
        clk => clk,
        reset => reset
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
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for 7 ns;
        reset <= '0';

        -- wait for 500 ns to observe the behavior of the MIPS Processor
        wait for 500 ns;

        -- Add additional stimulus here if necessary

        -- Stop the simulation
        wait;
    end process;

END;
