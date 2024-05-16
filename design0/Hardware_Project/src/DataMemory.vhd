library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DataMemory is
	port( 
		clk : in STD_LOGIC;
		Address : in STD_LOGIC_VECTOR(31 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0); 
		MemRead : in STD_LOGIC;
		MemWrite : in STD_LOGIC;
		ReadData : out STD_LOGIC_VECTOR(31 downto 0)
	);
end DataMemory;

architecture Behavioral of DataMemory is
	type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);

	signal DM: RAM_16_x_32 := (
		x"00000000", x"00000000", x"00000000", x"00000000",
		x"00000000", x"00000000", x"00000000", x"00000000",
		x"00000000", x"00000000", x"00000000", x"00000000",
		x"00000000", x"00000000", x"00000000", x"00000000"
	);

	signal AddrIndex: integer;
begin
	AddrIndex <= (to_integer(unsigned(Address(31 downto 2))) - (268500592 / 4));

	process(clk)
	begin
		if rising_edge(clk) then
			if MemWrite = '1' then
				if AddrIndex >= 0 and AddrIndex < 16 then
					DM(AddrIndex) <= WriteData;
				end if;
			end if;
		end if;
	end process;

	process(Address, MemRead)
	begin
		if MemRead = '1' then
			if AddrIndex >= 0 and AddrIndex < 16 then
				ReadData <= DM(AddrIndex);
			else
				ReadData <= (others => '0'); -- Default value for out of range
			end if;
		else
			ReadData <= (others => '0'); -- Default value when not reading
		end if;
	end process;
end Behavioral;
