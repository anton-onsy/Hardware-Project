library ieee;
use ieee.std_logic_1164.all;

 Entity SignExtender is 
	
 port(
    input_SE : in std_logic_vector(15 downto 0);
	output_SE: out std_logic_vector(31 downto 0) 	
	); 
  end SignExtender;
	
 Architecture Fun_SE of SignExtender is 
 
 begin 
	 
 output_SE <= x"0000" & input_SE when input_SE(15) ='0' else 
	          x"FFFF" & input_SE;
	
  end Fun_SE;