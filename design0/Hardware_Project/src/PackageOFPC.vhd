library IEEE;
use IEEE.std_logic_1164.all;

Package PC_Package is
	
	component PC is 
		port(
		clk:in std_logic;
	    reset: in std_logic;
		Address_in : in STD_LOGIC_VECTOR(31 downto 0);
		Address_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
	 
	end component;
	
end  PC_Package;