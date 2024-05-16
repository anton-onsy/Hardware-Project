library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Control is
    port(
        funct : in STD_LOGIC_VECTOR(5 downto 0);
        ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
        operation : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ALU_Control;

architecture Behavioral of ALU_Control is
begin
    process(ALUOp, funct)
    begin
        case ALUOp is
            when "00" => -- LW or SW
                operation <= "0010"; -- ADD operation (for address calculation)
            when "01" => -- BEQ
                operation <= "0110"; -- SUBTRACT operation (for comparison)
            when "10" => -- R-type instructions
                case funct is
                    when "100000" => -- ADD
                        operation <= "0010";
                    when "100010" => -- SUB
                        operation <= "0110";
                    when "100100" => -- AND
                        operation <= "0000";
                    when "100101" => -- OR
                        operation <= "0001";
                    when "101010" => -- SLT
                        operation <= "0111";
                    when others =>
                        operation <= "XXXX"; -- Invalid funct field
                end case;
            when others =>
                operation <= "XXXX"; -- Invalid ALUOp
        end case;
    end process;
end Behavioral;
