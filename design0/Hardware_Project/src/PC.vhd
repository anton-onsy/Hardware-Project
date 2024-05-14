
library IEEE;
use IEEE.std_logic_1164.all;

entity PC is
	port( 
	    clk:in std_logic;
	    reset: in std_logic;
		Address_in : in STD_LOGIC_VECTOR(31 downto 0);
		Address_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end PC;



architecture PC of PC is
begin	 
	process(clk,reset) 
	begin
	if(rising_edge(clk)) then
		if (reset='0') then
        Address_out<=Address_in;
	else
		Address_out<=x"00000000";
	end if;
	end if;
	end process;

end PC;