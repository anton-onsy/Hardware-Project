library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity InstructionMemory is
    port(
        ReadAddress : in STD_LOGIC_VECTOR(31 downto 0);
        Instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

    type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);

    signal IM: RAM_16_x_32 := (
        x"01285020", -- add $t2, $t1, $t0
        x"01285022", -- sub $t2, $t1, $t0
        x"01285024", -- and $t2, $t1, $t0
        x"018b6825", -- or $t5, $t4, $t3
        x"8c090004", -- lw $t1, 4($zero) (load word)
        x"ac090004", -- sw $t1, 4($zero) (store word)
        x"08100000",  -- j 0x000000 (jump to address 0)
        x"018b6825", -- or $t5, $t4, $t3
        --x"1211fffb", -- beq $t1, $t0, -5
        x"0149402a", -- slt $t2, $t1, $t0
        x"2109000A", -- addi $t1, $t0, 10 (initialization)
        x"012a4820", -- add $t1, $t1, $t2 (perform addition)
        x"012a4822", -- sub $t1, $t1, $t2 (perform subtraction)
        x"012a4824", -- and $t1, $t1, $t2 (perform AND)
        x"012a4825", -- or $t1, $t1, $t2 (perform OR)
        x"0149502a", -- slt $t2, $t2, $t1 (perform set less than)
        x"0149502a" -- slt $t2, $t2, $t1 (perform set less than)
        --x"1009fffb", -- beq $zero, $t1, -5 (loop if $t1 == 0)
    );

begin 
    process(ReadAddress)
        variable index: integer;
    begin
        -- Assuming ReadAddress starts from 0x00400000 and increments by 4
        index := to_integer(unsigned(ReadAddress(31 downto 2))) - (4194304 / 4);

        if index >= 0 and index < IM'length then
            Instruction <= IM(index);
        else
            Instruction <= (others => '0'); -- Return 0 if address is out of range
        end if;
    end process;

end Behavioral;
