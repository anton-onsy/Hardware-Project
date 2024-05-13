library IEEE;
use IEEE.std_logic_1164.all;

Package mux2to1_Package is
	 constant n: integer :=32;
	component mux2to1 is 	
	port(				   
	     input0 : in STD_LOGIC_VECTOR(n-1 downto 0);
	     input1 : in STD_LOGIC_VECTOR(n-1 downto 0);
	     output : out STD_LOGIC_VECTOR(n-1 downto 0);
		 sel : in STD_LOGIC
	); 
	end component;
	
end  mux2to1_Package;

