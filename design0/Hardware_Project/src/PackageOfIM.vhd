library IEEE;
use IEEE.std_logic_1164.all;

Package IM_Package is
	
	component InstructionMemory is 	
	port(
		ReadAddress : in STD_LOGIC_VECTOR(31 downto 0);
		Instruction : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
end  IM_Package;