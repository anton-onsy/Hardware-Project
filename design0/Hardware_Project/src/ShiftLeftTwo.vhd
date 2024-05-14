	  library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeftTwo is
	Port (
        input : in STD_LOGIC_VECTOR (31 downto 0);
        output : out STD_LOGIC_VECTOR (31 downto 0)
    );
end ShiftLeftTwo;

--}} End of automatically maintained section

architecture ShiftLeftTwo of ShiftLeftTwo is
begin

	process(input)
    begin
        output <= input(29 downto 0) & "00";
    end process;

end ShiftLeftTwo;
