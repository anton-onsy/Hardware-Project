library ieee;
use ieee.std_logic_1164.all;
use work.mux2to1_Package.all;
use work.ALU_Package.all;
use work.SE_Package.all;

entity MIPsProcessor is
end MIPsProcessor;



architecture MIPsProcessor of MIPsProcessor is
begin
	u1:mux2to1
	generic map(n=5)
	port map(   
	--input0 =>,
    --	input1 =>,
    --	output=>,	
    --	sel=>
   );  
   u2:ALU port map(   
	  --  Zero_flag => , 
--		Alu_in1 => , 
--		Alu_in2 => ,  
--		Alu_control => ,
--		Alu_out => 
);
 u2:SE port map(   
	     -- input_SE =>,
--	      output_SE =>
);  	  


end MIPsProcessor;
