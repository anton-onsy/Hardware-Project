LIBRARY ieee;
USE ieee.std_logic_1164.ALL;   
USE work.MAIN_ALU_Package.ALL;
USE work.fiveBitMux2to1_Package.ALL;
USE work.ALU_Control_Package.ALL;
USE work.SE_Package.ALL;
USE work.IM_Package.ALL;
USE work.DM_Package.ALL;
USE work.Controller_Package.ALL;
USE work.Regisrers_Package.ALL;
USE work.ThirtyTwoBitMUX2to1_Package.ALL;
USE work.PC_Package.ALL;
USE work.WordAdder_Package.ALL;
USE work.ALU_Add_Package.ALL;	  


ENTITY MIPSProcessor IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC
    );
END MIPSProcessor;

ARCHITECTURE MIPSProcessor OF MIPSProcessor IS

    -- MIPSIntructionMemory signals
    SIGNAL Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************

    -- MIPSController signals
    SIGNAL RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite : STD_LOGIC;
    SIGNAL ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    --*************************************************

    -- MIPSMUX_IM_REGS signals
    SIGNAL WriteRegister : STD_LOGIC_VECTOR(4 DOWNTO 0);
    --*************************************************	 

    -- MIPSMUX_REGS_ALU signals
    SIGNAL MUX32_Out_ALU : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************	

    -- MIPSMUX_Dmem_Regs signals
    SIGNAL MUX32_Out_Dmem : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************	  

    -- MIPSMUX_ALUADD_PC signals
    SIGNAL MUX32_Out_ALUADD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************

    -- MIPSSignExtend signals
    SIGNAL ToShiftLeftTwo : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************

    -- MIPSALUControl signals
    SIGNAL ALUControl : STD_LOGIC_VECTOR(3 DOWNTO 0);
    --*************************************************	

    --MIPSRegesters signals
    SIGNAL Read_data1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Read_data2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************	

    --MIPSALU signals
    SIGNAL ALUResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ALUZeroFlag : STD_LOGIC;
    --*************************************************

    --MIPSDataMemory signals
    SIGNAL ReadData : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************
    --MIPSPC signals
    SIGNAL ReadAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************	 

    --MIPSAdder signals
    SIGNAL Adder_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************

    --MIPSALUAdder signals
    SIGNAL ALU_Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --*************************************************

    --MIPSAND signal
    SIGNAL AND_out : STD_LOGIC;
    --*************************************************
    --MIPSShiftLeftTwo 
    signal FromShiftLeftTwo : STD_LOGIC_VECTOR(31 DOWNTO 0);
    component ShiftLeftTwo is
        Port (
            input : in STD_LOGIC_VECTOR (31 downto 0);
            output : out STD_LOGIC_VECTOR (31 downto 0)
        );
    end component;
    --*************************************************
BEGIN
    -- Code Names are specified to avoid confusion, they can be
    -- matched with the names in Scheme.pdf

    -- IM
    MIPSIntructionMemory : InstructionMemory PORT MAP(
        ReadAddress,
        Instruction
    );

    -- CTRL
    MIPSController : Controller PORT MAP(
        RegDst,
        Jump,
        Branch,
        MemRead,
        MemtoReg,
        MemWrite,
        ALUSrc,
        RegWrite,
        Instruction(31 DOWNTO 26),
        ALUOp
    );

    -- 5MUX
    MIPSMUX_IM_REGS : fiveBitMux2to1 PORT MAP(
        Instruction(20 DOWNTO 16),
        Instruction(15 DOWNTO 11),
        WriteRegister,
        RegDst
    );

    -- SGN-EXT
    MIPSSignExtend : SignExtender PORT MAP(
        Instruction(15 DOWNTO 0),
        ToShiftLeftTwo
    );

    -- REGS
    MIPSREGS : Registers PORT MAP(
        clk, --clk
        RegWrite, --RegWrite 
        Instruction(25 DOWNTO 21), --Read_reg1 
        Instruction(20 DOWNTO 16), --Read_reg2 
        WriteRegister, --Write_reg
        MUX32_Out_Dmem, --WriteData 
        Read_data1, --Read_data1 
        Read_data2 --Read_data2 
    );

    -- REGS-ALU-MUX
    MIPSMUX_REGS_ALU : ThirtyTwoBitMUX2to1 PORT MAP(
        Read_data2,
        ToShiftLeftTwo,
        MUX32_Out_ALU,
        ALUSrc
    );

    -- WRT-DATA-MUX
    MIPSMUX_DMem_Regs : ThirtyTwoBitMUX2to1 PORT MAP(
        AluResult,
        ReadData,
        MUX32_Out_Dmem,
        MemtoReg
    );

    -- ALU-CTRL
    MIPSALUControl : ALU_Control PORT MAP(
        Instruction(5 DOWNTO 0),
        ALUOp,
        ALUControl
    );

    -- ALU
    MIPSALU : ALU PORT MAP(
        ALUZeroFlag, --Zero_flag 
        Read_data1, --Alu_in1 
        MUX32_Out_ALU, --Alu_in2 	 
        ALUControl, --Alu_control
        AluResult --Alu_out
    );

    -- DM
    MIPSDataMemory : DataMemory PORT MAP(
        clk, --clk
        AluResult, --Address 
        Read_data2, --WriteData  
        MemRead, --MemRead 
        MemWrite, --MemWrite 
        ReadData --ReadData
    );

    -- PC
    MIPSPC : PC PORT MAP(
        clk, --clk
        reset, --reset
        MUX32_Out_ALUADD, --Address_in 
        ReadAddress --Address_out  

    );

    -- WORD-ADD
    MIPSWordAdder : WordAdder PORT MAP(

        ReadAddress, --Adder_in 
        Adder_out --Adder_out   

    );

    -- SLL2
    MIPSShiftLeftTwo : ShiftLeftTwo PORT MAP(
        ToShiftLeftTwo,
        FromShiftLeftTwo
    );

    -- SLL2-ADD
    MIPSALUAdder : ALU_Adder PORT MAP(

        Adder_out, --ALU_ADD_IN1 
        ToShiftLeftTwo, --ALU_ADD_IN2 
        ALU_Result --ALU_ADD_OUT

    );

    AND_out <= Branch AND ALUZeroFlag;

    -- BEQ-MUX
    MIPSMUX_ALUADD_PC : ThirtyTwoBitMUX2to1 PORT MAP(
        Adder_out,
        ALU_Result,
        MUX32_Out_ALUADD,
        AND_out
    );

    

END MIPSProcessor;