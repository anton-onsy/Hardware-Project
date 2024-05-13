-------------------------------------------------------------------------------
--
-- Title       : Registers
-- Design      : Hardware_Project
-- Author      : Anton
-- Company     : Zagazig_University
--
-------------------------------------------------------------------------------
--
-- File        : C:/My_Designs/design0/Hardware_Project/src/Registers.vhd
-- Generated   : Mon May 13 17:21:57 2024
-- From        : Interface description file
-- By          : ItfToHdl ver. 1.0
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--    and may be overwritten
--{entity {Registers} architecture {Registers}}

library IEEE;
use IEEE.std_logic_1164.all;

entity Registers is
	port(
		RegWrite : in STD_LOGIC;
		Read_reg1 : in STD_LOGIC_VECTOR(4 downto 0);
		Read_reg2 : in STD_LOGIC_VECTOR(4 downto 0);
		Write_reg : in STD_LOGIC_VECTOR(4 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0);
		Read_data1 : in STD_LOGIC_VECTOR(31 downto 0);
		Read_data2 : in STD_LOGIC_VECTOR(31 downto 0)
	);
end Registers;

--}} End of automatically maintained section

architecture Registers of Registers is
begin

	-- Enter your statements here --

end Registers;
