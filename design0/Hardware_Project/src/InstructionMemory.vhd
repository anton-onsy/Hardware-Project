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

    signal IM: RAM_16_x_32 := (
        x"01285024", -- 0x0040 0000: and $t2, $t1, $t0
        x"018b6825", -- 0x0040 0004: or $t5, $t4, $t3
        x"01285020", -- Additional instructions...
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
    process(ReadAddress)
        variable index: integer;
    begin
        -- Assuming ReadAddress starts from 0x00400000 and increments by 4
        if unsigned(ReadAddress) >= 4194304 then
            index := (to_integer(unsigned(ReadAddress) - 4194304) / 4);
            if index >= 0 and index < IM'length then
                Instruction <= IM(index);
            else
                Instruction <= (others => '0'); -- Return 0 if address is out of range
            end if;
        else
            Instruction <= (others => '0'); -- Return 0 for addresses below 0x00400000
        end if;
    end process;

end InstructionMemory;
