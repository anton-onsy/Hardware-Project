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
        x"00000000", x"11111111", x"22222222", x"33333333",
        x"44444444", x"55555555", x"66666666", x"77777777",
        x"88888888", x"99999999", x"AAAAAAAA", x"BBBBBBBB",
        x"CCCCCCCC", x"DDDDDDDD", x"EEEEEEEE", x"FFFFFFFF"
    );



begin
    process(clk)
        variable AddrIndex: integer;
    begin
        if rising_edge(clk) then
            AddrIndex := to_integer(unsigned(Address(3 downto 0))); -- 4 LSBs for address range 0-15
            if MemWrite = '1' then
                if AddrIndex >= 0 and AddrIndex < 16 then
                    DM(AddrIndex) <= WriteData;
                else
                    report "DataMemory:: WRITE ERR: Address out of range";
                end if;
            end if;
        end if;
    end process;

    process(Address, MemRead)
        variable AddrIndex: integer;
    begin
        AddrIndex := to_integer(unsigned(Address(3 downto 0))); -- 4 LSBs for address range 0-15
        if MemRead = '1' then
            if AddrIndex >= 0 and AddrIndex < 16 then
                ReadData <= DM(AddrIndex);
                
            else
                report "DataMemory:: READ ERR: Address out of range";
                ReadData <= (others => '0'); -- Default value for out of range
            end if;
        else
            ReadData <= (others => '0'); -- Default value when not reading
        end if;
    end process;
end Behavioral;
