

library IEEE;
use IEEE.std_logic_1164.all;

entity Alu_Control is
	port(
		funct : in STD_LOGIC_VECTOR(5 downto 0);
		ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
		operation : out STD_LOGIC_VECTOR(3 downto 0)
	);
end Alu_Control;

--}} End of automatically maintained section

architecture Alu_Control of Alu_Control is
begin
	operation(3)<='0';
	operation(2)<= ALUOp(0) or (  ALUOp(1) and funct(1)); 
	
	operation(1)<=	not ALUOp(1) or not funct(2);
	
	operation(0)<= (funct(3) or funct(0)) and ALUOp(1);
	-- Enter your statements here --

end Alu_Control;
