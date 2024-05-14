library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU_Adder is
	port(
		ALU_ADD_IN1 : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_ADD_IN2 : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_ADD_OUT : out STD_LOGIC_VECTOR(31 downto 0)
	);
end ALU_Adder;



architecture ALU_Adder of ALU_Adder is
begin
 
   ALU_ADD_OUT <= ALU_ADD_IN1 +	(ALU_ADD_IN2(29 downto 0) & "00");

end ALU_Adder;
