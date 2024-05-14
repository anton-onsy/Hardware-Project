library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity Adder is
	port(
		Adder_in : in STD_LOGIC_VECTOR(31 downto 0);
		Adder_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end Adder;


architecture Adder of Adder is
begin

Adder_out <= Adder_in+4;

end Adder;
