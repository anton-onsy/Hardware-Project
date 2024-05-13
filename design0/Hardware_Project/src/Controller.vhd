

library IEEE;
use IEEE.std_logic_1164.all;

entity Controller is
	port(
		RegDst : out STD_LOGIC;
		Jump : out STD_LOGIC;
		Branch : out STD_LOGIC;
		MemRead : out STD_LOGIC;
		MemToReg : out STD_LOGIC;
		MemWrite : out STD_LOGIC;
		ALUSrc : out STD_LOGIC;
		RegWrite : out STD_LOGIC;
		OpCode : in STD_LOGIC_VECTOR(5 downto 0);
		ALUOp : out STD_LOGIC_VECTOR(1 downto 0)
	);
end Controller;

--}} End of automatically maintained section

architecture Controller of Controller is
begin
	process(OpCode)
	begin
		RegWrite<= '0'; --Deassert for next command
			
			case OpCode is
				
				when "000000" => --and ,or ,add ,sub ,slt, : 0x00
				RegDst<='1';
				Jump<='0';
				Branch<='0';
				MemRead<='0';
				MemToReg<='0'; 
				ALUOp<="10";
				MemWrite<='0';
				AluSrc<='0';
				RegWrite<='1' after 10 ns;	 
				
				when "100011" => --load word (lw) : 0x23
				RegDst<='0';
				Jump<='0';
				Branch<='0';
				MemRead<='1';
				MemToReg<='1'; 
				ALUOp<="00";
				MemWrite<='0';
				AluSrc<='1';
				RegWrite<='1' after 10 ns;
				
				when "101011" => --store word (sw) : 0x2B
				RegDst<= 'X';
				Jump<='0';
				Branch<='0';
				MemRead<='0';
				MemToReg<='X'; 
				ALUOp<="00";
				MemWrite<='1';
				AluSrc<='1';
				RegWrite<='0';	
				
				when "000100" => --Branch Equal (beq) : 0x04
				RegDst<='X';
				Jump<='0';
				Branch<='1' after 2 ns;
				MemRead<='0';
				MemToReg<='X'; 
				ALUOp<="01";
				MemWrite<='0';
				AluSrc<='0';
				RegWrite<='0'; 
				
				when "000010" => --Jump (j) : 0x02
				RegDst<='X';
				Jump<='1';
				Branch<='0' ;
				MemRead<='0';
				MemToReg<='X'; 
				ALUOp<="00";
				MemWrite<='0';
				AluSrc<='0';
				RegWrite<='0';
				
				when others=> null; --Implement other commands down here 
				RegDst<='0';
				Jump<='0';
				Branch<='0' ;
				MemRead<='0';
				MemToReg<='0'; 
				ALUOp<="00";
				MemWrite<='0';
				AluSrc<='0';
				RegWrite<='0';
				
		end case;
	

     end process;
 
	end Controller;
