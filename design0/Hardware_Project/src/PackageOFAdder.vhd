library IEEE;
use IEEE.std_logic_1164.all;

Package Adder_Package is
	
	component Adder is 
		port(
		Adder_in : in STD_LOGIC_VECTOR(31 downto 0);
		Adder_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
	 
	end component;
	
end  Adder_Package;