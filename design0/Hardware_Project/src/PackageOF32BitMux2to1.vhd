library IEEE;
use IEEE.std_logic_1164.all;

Package ThirtyTwoBitMux2to1_Package is
	component ThirtyTwoBitMUX2to1 is 	
	port(				   
	     input0 : in STD_LOGIC_VECTOR(31 downto 0);
	     input1 : in STD_LOGIC_VECTOR(31 downto 0);
	     output : out STD_LOGIC_VECTOR(31 downto 0);
		 sel : in STD_LOGIC
	); 
	end component;
	
end  ThirtyTwoBitMux2to1_Package;
