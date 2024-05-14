library IEEE;
use IEEE.std_logic_1164.all;

Package ALU_Control_Package is
	
	component ALU_Control is 
		port(
		funct : in STD_LOGIC_VECTOR(5 downto 0);
		ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
		operation : out STD_LOGIC_VECTOR(3 downto 0)
	);
	 
	end component;
	
end  ALU_Control_Package;