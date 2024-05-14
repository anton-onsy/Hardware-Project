library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity WordAdder is
	port(
		WordAdder_in : in STD_LOGIC_VECTOR(31 downto 0);
		WordAdder_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end WordAdder;


architecture WordAdder of WordAdder is
begin

WordAdder_out <= WordAdder_in+4;

end WordAdder;
