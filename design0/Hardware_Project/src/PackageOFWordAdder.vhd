library IEEE;
use IEEE.std_logic_1164.all;

Package WordAdder_Package is
	
	component WordAdder is 
		port(
		WordAdder_in : in STD_LOGIC_VECTOR(31 downto 0);
		WordAdder_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
	 
	end component;
	
end  WordAdder_Package;