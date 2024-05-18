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
        x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA",
        x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA",
        x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA",
        x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA", x"AAAAAAAA"
    );

    signal AddrIndex: integer;
begin
    process(Address)
    begin
        AddrIndex <= to_integer(unsigned(Address(31 downto 2))); -- Address in word offset
    end process;

    process(clk)
    begin 
        if rising_edge(clk) then
            if MemWrite = '1' then
                if AddrIndex >= 0 and AddrIndex < 16 then
                    DM(AddrIndex) <= WriteData;
                else
                    report("DataMemory:: WRITE ERR: Address out of range");
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
                report("DataMemory:: READ ERR: Address out of range");
                ReadData <= (others => '0'); -- Default value for out of range
            end if;
        else
            ReadData <= (others => '0'); -- Default value when not reading
        end if;
    end process;
end Behavioral;
