library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity InstructionMemory is
	port(
		ReadAddress : in STD_LOGIC_VECTOR(31 downto 0);
		Instruction : out STD_LOGIC_VECTOR(31 downto 0)
	);
end InstructionMemory;

architecture InstructionMemory of InstructionMemory is

	type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);   	

	signal IM: RAM_16_x_32 := ( x"01285024", --0x0040 0000: and $t2, $t1, $t0
							    x"018b6825", --0x0040 0004: or $t5, $t4, $t3 ||| and so on for the next examples
								x"01285020",
								x"01285022",
								x"0149402a",
								x"1211fffb",
								x"01285024",
								x"018b6825",
								x"01285020",
								x"01285022",
								x"0149402a",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000"
								);
begin 
	--NOTE: 4194304 = 0x0040 0000
	Instruction <= x"00000000" when ReadAddress = x"003FFFFC" else
		IM( (to_integer(unsigned(ReadAddress))-4194304)/4 );

end InstructionMemory;
