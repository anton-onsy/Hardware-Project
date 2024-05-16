library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
    port(
        Zero_flag : out STD_LOGIC;
        Alu_in1 : in STD_LOGIC_VECTOR(31 downto 0);
        Alu_in2 : in STD_LOGIC_VECTOR(31 downto 0);     
        Alu_control : in STD_LOGIC_VECTOR(3 downto 0);
        Alu_out : out STD_LOGIC_VECTOR(31 downto 0)
    );
end ALU;

architecture Behavioral of ALU is 
    signal Alu_IntSig: STD_LOGIC_VECTOR(31 downto 0); 
begin
    process(Alu_in1, Alu_in2, Alu_control)
    begin
        case Alu_control is
            when "0010" => Alu_IntSig <= std_logic_vector(signed(Alu_in1) + signed(Alu_in2)); -- addition 
            when "0110" => Alu_IntSig <= std_logic_vector(signed(Alu_in1) - signed(Alu_in2)); -- subtraction
            when "0000" => Alu_IntSig <= Alu_in1 and Alu_in2; -- and
            when "0001" => Alu_IntSig <= Alu_in1 or Alu_in2; -- or
            when "1100" => Alu_IntSig <= not (Alu_in1 or Alu_in2); -- nor
            when others => Alu_IntSig <= (others => '0');
        end case;
    end process;

    Alu_out <= Alu_IntSig;
    Zero_flag <= '1' when Alu_IntSig = x"00000000" else '0';
end Behavioral;
