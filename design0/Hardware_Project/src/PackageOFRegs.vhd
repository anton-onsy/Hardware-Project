library IEEE;
use IEEE.std_logic_1164.all;

Package Regisrers_Package is
	
	component Registers is 	
	port(	  
		clk : in std_logic;
		RegWrite : in STD_LOGIC;
		Read_reg1 : in STD_LOGIC_VECTOR(4 downto 0);
		Read_reg2 : in STD_LOGIC_VECTOR(4 downto 0);
		Write_reg : in STD_LOGIC_VECTOR(4 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0);
		Read_data1 : out STD_LOGIC_VECTOR(31 downto 0);
		Read_data2 : out STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
end  Regisrers_Package;