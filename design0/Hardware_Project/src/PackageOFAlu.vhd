library IEEE;
use IEEE.std_logic_1164.all;

Package MAIN_ALU_Package is
	 constant n: integer :=32;
	component ALU is 	
	port(				   
	    Zero_flag : out STD_LOGIC;
		Alu_in1 : in STD_LOGIC_VECTOR(31 downto 0);
		Alu_in2 : in STD_LOGIC_VECTOR(31 downto 0);	 
		Alu_control:in STD_LOGIC_VECTOR(3 downto 0);
		Alu_out : out STD_LOGIC_VECTOR(31 downto 0)
	); 
	end component;
	
end package;