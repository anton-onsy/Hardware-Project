library IEEE;
use IEEE.std_logic_1164.all;

Package fiveBitMux2to1_Package is
	component fiveBitMux2to1 is 	
	port(				   
	     input0 : in STD_LOGIC_VECTOR(4 downto 0);
	     input1 : in STD_LOGIC_VECTOR(4 downto 0);
	     output : out STD_LOGIC_VECTOR(4 downto 0);
		 sel : in STD_LOGIC
	); 
	end component;
	
end  fiveBitMux2to1_Package;

