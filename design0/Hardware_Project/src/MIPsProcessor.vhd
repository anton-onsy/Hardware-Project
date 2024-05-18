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
    -- Instruction Memory signals
    SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Controller signals
    SIGNAL reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write : STD_LOGIC;
    SIGNAL alu_op : STD_LOGIC_VECTOR(1 DOWNTO 0);
    -- MUX signals for Register Write Address
    SIGNAL write_register_addr : STD_LOGIC_VECTOR(4 DOWNTO 0);
    -- MUX signals for ALU input
    SIGNAL alu_mux_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- MUX signals for Data Memory and Registers
    SIGNAL mem_mux_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- MUX signals for ALU Adder
    SIGNAL alu_add_mux_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Sign Extend signals
    SIGNAL sign_ext_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- ALU Control signals
    SIGNAL alu_control_signal : STD_LOGIC_VECTOR(3 DOWNTO 0);
    -- Register File signals
    SIGNAL reg_read_data1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL reg_read_data2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- ALU signals
    SIGNAL alu_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL alu_zero_flag : STD_LOGIC;
    -- Data Memory signals
    SIGNAL mem_read_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Program Counter signals
    SIGNAL pc_read_addr : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Adder signals
    SIGNAL adder_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- ALU Adder signals
    SIGNAL alu_adder_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- AND gate signal
    SIGNAL branch_and_flag : STD_LOGIC;
    -- Shift Left Two signals
    SIGNAL shift_left_output : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Jump Address signal
    SIGNAL jump_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- PC Mux signal
    SIGNAL pc_mux_output : STD_LOGIC_VECTOR(31 DOWNTO 0);

    COMPONENT ShiftLeftTwo IS
        PORT (
            input : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    -- Instruction Memory
    instruction_memory_inst : InstructionMemory PORT MAP(
        pc_read_addr,
        instruction
    );

    -- Controller
    controller_inst : Controller PORT MAP(
        reg_dest,
        jump,
        branch,
        mem_read,
        mem_to_reg,
        mem_write,
        alu_src,
        reg_write,
        instruction(31 DOWNTO 26),
        alu_op
    );

    -- 5-bit MUX for Register Write Address
    write_reg_mux_inst : fiveBitMux2to1 PORT MAP(
        instruction(20 DOWNTO 16),
        instruction(15 DOWNTO 11),
        write_register_addr,
        reg_dest
    );

    -- Sign Extender
    sign_extend_inst : SignExtender PORT MAP(
        instruction(15 DOWNTO 0),
        sign_ext_output
    );

    -- Registers
    registers_inst : Registers PORT MAP(
        clk, -- Clock
        reg_write, -- Register Write Enable
        instruction(25 DOWNTO 21), -- Read Register 1
        instruction(20 DOWNTO 16), -- Read Register 2
        write_register_addr, -- Write Register
        mem_mux_output, -- Write Data
        reg_read_data1, -- Read Data 1
        reg_read_data2 -- Read Data 2
    );

    -- MUX for ALU input
    alu_input_mux_inst : ThirtyTwoBitMUX2to1 PORT MAP(
        reg_read_data2,
        sign_ext_output,
        alu_mux_output,
        alu_src
    );

    -- MUX for Data Memory and Register File Write Data
    mem_data_mux_inst : ThirtyTwoBitMUX2to1 PORT MAP(
        alu_result,
        mem_read_data,
        mem_mux_output,
        mem_to_reg
    );

    -- ALU Control
    alu_control_inst : ALU_Control PORT MAP(
        instruction(5 DOWNTO 0),
        alu_op,
        alu_control_signal
    );

    -- ALU
    alu_inst : ALU PORT MAP(
        alu_zero_flag, -- Zero Flag
        reg_read_data1, -- ALU Input 1
        alu_mux_output, -- ALU Input 2
        alu_control_signal, -- ALU Control
        alu_result -- ALU Output
    );

    -- Data Memory
    data_memory_inst : DataMemory PORT MAP(
        clk, -- Clock
        alu_result, -- Address
        reg_read_data2, -- Write Data
        mem_read, -- Memory Read
        mem_write, -- Memory Write
        mem_read_data -- Read Data
    );

    -- Program Counter
    pc_inst : PC PORT MAP(
        clk, -- Clock
        reset, -- Reset
        pc_mux_output, -- Address In
        pc_read_addr -- Address Out
    );

    -- Adder
    adder_inst : WordAdder PORT MAP(
        pc_read_addr, -- Adder Input
        adder_output -- Adder Output
    );

    -- Shift Left Two
    shift_left_two_inst : ShiftLeftTwo PORT MAP(
        sign_ext_output,
        shift_left_output
    );

    -- ALU Adder
    alu_adder_inst : ALU_Adder PORT MAP(
        adder_output, -- ALU Adder Input 1
        shift_left_output, -- ALU Adder Input 2
        alu_adder_result -- ALU Adder Output
    );

    branch_and_flag <= branch AND alu_zero_flag;

    -- MUX for ALU Adder and Program Counter Update
    alu_adder_mux_inst : ThirtyTwoBitMUX2to1 PORT MAP(
        adder_output,
        alu_adder_result,
        alu_add_mux_output,
        branch_and_flag
    );

    -- Jump Address Calculation
    jump_address <= pc_read_addr(31 DOWNTO 28) & instruction(25 DOWNTO 0) & "00";

    -- Program Counter MUX to handle Jump
    pc_mux_inst : ThirtyTwoBitMUX2to1 PORT MAP(
        alu_add_mux_output,
        jump_address,
        pc_mux_output,
        jump
    );
END MIPSProcessor;
