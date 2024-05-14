library ieee;
use ieee.std_logic_1164.all; 
use work.fiveBitMux2to1_Package.all;
use work.ALU_Package.all;
use work.ALU_Control_Package.all;
use work.SE_Package.all;
use work.IM_Package.all;
use work.DM_Package.all;
use work.Controller_Package.all;
use work.Regisrers_Package.all;
use work.ThirtyTwoBitMUX2to1_Package.all;
use work.PC_Package.all;   
use work.Adder_Package.all;  
use work.ALU_Add_Package.all;  


entity MIPSProcessor is	
	port(
	    clk:in std_logic;
	    reset: in std_logic
	);
end MIPSProcessor;



architecture MIPSProcessor of MIPSProcessor is	  

   	-- MIPSIntructionMemory signals
    signal Instruction: std_logic_vector(31 downto 0);
    --*************************************************
    
    -- MIPSController signals
    signal RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite: std_logic;
    signal ALUOp: std_logic_vector(1 downto 0);				
    --*************************************************

    -- MIPSMUX_IM_REGS signals
    signal WriteRegister: std_logic_vector(4 downto 0);
    --*************************************************	 
	
	 -- MIPSMUX_REGS_ALU signals
    signal MUX32_Out_ALU : std_logic_vector(31 downto 0);
    --*************************************************	
	
	-- MIPSMUX_Dmem_Regs signals
    signal MUX32_Out_Dmem : std_logic_vector(31 downto 0);
    --*************************************************	  
	
	-- MIPSMUX_ALUADD_PC signals
    signal MUX32_Out_ALUADD : std_logic_vector(31 downto 0);
    --*************************************************

    -- MIPSSignExtend signals
    signal ToShiftLeftTwo: std_logic_vector(31 downto 0);
    --*************************************************

    -- MIPSALUControl signals
    signal ALUControl: std_logic_vector(3 downto 0);
    --*************************************************	
	
	--MIPSRegesters signals
	signal Read_data1:std_logic_vector(31 downto 0);
    signal Read_data2:std_logic_vector(31 downto 0);
	--*************************************************	
	
	--MIPSALU signals
	signal ALUResult:STD_LOGIC_VECTOR(31 downto 0);	
	signal ALUZeroFlag: STD_LOGIC;
	--*************************************************
	
	--MIPSDataMemory signals
	signal ReadData:STD_LOGIC_VECTOR(31 downto 0);	
	--*************************************************
	
	
	--MIPSPC signals
	signal ReadAddress: std_logic_vector(31 downto 0);	
	--*************************************************	 
	
	--MIPSAdder signals
	signal Adder_out: std_logic_vector(31 downto 0);	
	--*************************************************
	
	--MIPSALUAdder signals
	signal ALU_Result: std_logic_vector(31 downto 0);	
	--*************************************************
	
	--MIPSAND signal
	signal AND_out: std_logic;	
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
	

MIPSREGS: Registers port map (
        clk,										--clk
		RegWrite,							        --RegWrite 
		Instruction(25 downto 21),					--Read_reg1 
		Instruction(20 downto 16),					--Read_reg2 
		WriteRegister,								--Write_reg
		MUX32_Out_Dmem,								--WriteData 
		Read_data1,									--Read_data1 
		Read_data2									--Read_data2 
    );	
	
MIPSMUX_REGS_ALU:  ThirtyTwoBitMUX2to1 port map (
       Read_data2,
       ToShiftLeftTwo,
       MUX32_Out_ALU,
       ALUSrc
    );
	
MIPSMUX_DMem_Regs:  ThirtyTwoBitMUX2to1 port map (
       AluResult,
       ReadData,
       MUX32_Out_Dmem,
       MemtoReg
    );
	

MIPSALUControl: ALU_Control port map (
        Instruction(5 downto 0),
        ALUOp,
        ALUControl
    );
	
MIPSALU: ALU port map (
        ALUZeroFlag,                    --Zero_flag 
		Read_data1,                     --Alu_in1 
		MUX32_Out_ALU,                  --Alu_in2 	 
		ALUControl,                     --Alu_control
		AluResult                       --Alu_out
    ); 	
	
MIPSDataMemory: DataMemory port map (
    clk,							        --clk
	AluResult,					        --Address 
	Read_data2,							--WriteData  
	MemRead,							--MemRead 
	MemWrite,							--MemWrite 
	ReadData						    --ReadData
    ); 		

MIPSPC: PC port map (
	clk,							    --clk
	reset,							    --reset
    MUX32_Out_ALUADD,                   --Address_in 
	ReadAddress						    --Address_out  
	
    ); 		       
	
MIPSAdder: Adder port map (
	
     ReadAddress,                       --Adder_in 
	 Adder_out	                        --Adder_out   
	
    );
	
MIPSALUAdder: ALU_Adder port map (
	
     Adder_out,                          --ALU_ADD_IN1 
	 ToShiftLeftTwo,                     --ALU_ADD_IN2 
	 ALU_Result                         --ALU_ADD_OUT
	
    ); 
	
AND_out<=Branch and ALUZeroFlag;
MIPSMUX_ALUADD_PC:  ThirtyTwoBitMUX2to1 port map (
       Adder_out,
       ALU_Result,
       MUX32_Out_ALUADD,
	   AND_out
    );



end MIPSProcessor;
