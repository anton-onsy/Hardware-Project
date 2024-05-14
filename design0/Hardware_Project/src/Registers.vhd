library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

entity Registers is
	port(
		clk : in STD_LOGIC;
		RegWrite : in STD_LOGIC;--coming from control unit
		Read_reg1 : in STD_LOGIC_VECTOR(4 downto 0);
		Read_reg2 : in STD_LOGIC_VECTOR(4 downto 0);
		Write_reg : in STD_LOGIC_VECTOR(4 downto 0);
		WriteData : in STD_LOGIC_VECTOR(31 downto 0);
		Read_data1 : out STD_LOGIC_VECTOR(31 downto 0);
		Read_data2 : out STD_LOGIC_VECTOR(31 downto 0)
	);
end Registers;



architecture Registers of Registers is
type REG_type is array (0 to 31) of std_logic_vector(31 downto 0);
signal ArrayOfReg : REG_type :=(  
							x"00000000", --$zero
							x"11111111", --$at
							x"22222222", --$v0
							x"33333333", --$v1
							x"44444444", --$a0
							x"55555555", --$a1
							x"66666666", --$a2
							x"77777777", --$a3
							x"88888888", --$t0
							x"99999999", --$t1
							x"aaaaaaaa", --$t2
							x"bbbbbbbb", --$t3
							x"cccccccc", --$t4
							x"dddddddd", --$t5
							x"eeeeeeee", --$t6
							x"ffffffff", --$t7
							x"00000000", --$s0
							x"11111111", --$s1
							x"22222222", --$s2
							x"33333333", --$s3
							x"44444444", --$s4
							x"55555555", --$s5
							x"66666666", --$s6
							x"77777777", --$s7
							x"88888888", --$t8
							x"99999999", --$t9
							x"aaaaaaaa", --$k0
							x"bbbbbbbb", --$k1
							x"10008000", --$gp
							x"7FFFF1EC", --$sp
							x"eeeeeeee", --$fp
							x"ffffffff" --$ra

                                   );
begin
	process(clk)
	begin 
  	if (rising_edge(clk)) then 
	 	if(RegWrite = '1') then
		 	ArrayOfReg(to_integer(unsigned(Write_reg))) <= WriteData;
	 	end if;
  	end if;
  	end process;
	
	process(Read_reg1,Read_reg2)
	begin
		Read_data1<= ArrayOfReg(to_integer(unsigned(Read_reg1)));
  		Read_data2<= ArrayOfReg(to_integer(unsigned(Read_reg2)));
	end process;

end Registers;
