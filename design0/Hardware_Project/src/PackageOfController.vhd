		   			   library IEEE;
use IEEE.std_logic_1164.all;

Package Controller_Package is
	
	component Controller is 
		port(
		RegDst : out STD_LOGIC;
		Jump : out STD_LOGIC;
		Branch : out STD_LOGIC;
		MemRead : out STD_LOGIC;
		MemToReg : out STD_LOGIC;
		MemWrite : out STD_LOGIC;
		ALUSrc : out STD_LOGIC;
		RegWrite : out STD_LOGIC;
		OpCode : in STD_LOGIC_VECTOR(5 downto 0);
		ALUOp : out STD_LOGIC_VECTOR(1 downto 0)
	);
	 
	end component;
	
end  Controller_Package;