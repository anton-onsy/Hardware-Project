library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DataMemory is
	port(
		Address : in STD_LOGIC_VECTOR(31 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0); 
		MemRead : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		ReadData : out STD_LOGIC_VECTOR(31 downto 0)
	);
end DataMemory;

--}} End of automatically maintained section

architecture DataMemory of DataMemory is   

	type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);   	

	signal DM: RAM_16_x_32 := ( x"00000000", --Assume starts at 0x100010000
							    x"00000000", 
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000",
								x"00000000"
	
								);
begin
	process(MemRead,MemWrite)
	begin
		if(MemWrite = '1') then
			DM( (to_integer(unsigned(Address))-268500592) /4 ) <= WriteData;
		end if;
		
		
		if(MemRead = '1') then
			ReadData <= DM( (to_integer(unsigned(Address))-268500592) /4 );
		end if;	 
	end process;

end DataMemory;
