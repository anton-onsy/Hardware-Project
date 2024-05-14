library IEEE;
use IEEE.std_logic_1164.all;

Package ALU_Add_Package is
	
	component ALU_Adder is 					   
	   port(
         ALU_ADD_IN1 : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_ADD_IN2 : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_ADD_OUT : out STD_LOGIC_VECTOR(31 downto 0)
	       ); 
	end component;
	
end  ALU_Add_Package;
