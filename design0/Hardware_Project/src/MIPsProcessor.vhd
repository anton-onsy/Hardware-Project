library ieee;
use ieee.std_logic_1164.all;
use work.fiveBitMux2to1_Package.all;
use work.ALU_Package.all;
use work.ALU_Control_Package.all;
use work.SE_Package.all;
use work.IM_Package.all;
use work.DM_Package.all;
use work.Controller_Package.all;


entity MIPsProcessor is
end MIPsProcessor;



architecture MIPsProcessor of MIPsProcessor is	  

   	-- MIPSConstructionMemory signals
    signal ReadAddress: std_logic_vector(31 downto 0);
    signal Instruction: std_logic_vector(31 downto 0);
    --*************************************************
    
    -- MIPSController signals
    signal RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: std_logic;
    signal ALUOp: std_logic_vector(1 downto 0);				
    --*************************************************

    -- MIPSMUX_IM_REGS signals
    signal WriteRegister: std_logic_vector(4 downto 0);
    --*************************************************

    -- MIPSSignExtend signals
    signal ToShiftLeftTwo: std_logic_vector(31 downto 0);
    --*************************************************

    -- MIPSALUControl signals
    signal ALUControl: std_logic_vector(3 downto 0);
    --*************************************************
    
	
begin


MIPSConstructionMemory: InstructionMemory port map (
   ReadAddress, 
    Instruction 
    );

MIPSController: Controller port map (
        RegDst,
        Jump,
        Branch,
        MemRead,
        MemtoReg,
        MemWrite,
        ALUSrc,
        RegWrite,
        Instruction(31 downto 26),
        ALUOp
    );

MIPSMUX_IM_REGS:  fiveBitMux2to1 port map (
        Instruction(20 downto 16),
        Instruction(15 downto 11),
        WriteRegister,
        RegDst
    );
  



MIPSSignExtend: SignExtender port map (
        Instruction(15 downto 0),
        ToShiftLeftTwo
    );
	

MIPSALUControl: ALU_Control port map (
        Instruction(5 downto 0),
        ALUOp,
        ALUControl
    );

    



end MIPsProcessor;
