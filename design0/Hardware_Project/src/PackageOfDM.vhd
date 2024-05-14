library IEEE;
use IEEE.std_logic_1164.all;

Package DM_Package is
	
	component DataMemory is 	
	port(	
		clk : in std_logic;
		Address : in STD_LOGIC_VECTOR(31 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0); 
		MemRead : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		ReadData : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
end  DM_Package;