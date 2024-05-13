library ieee;
use ieee.std_logic_1164.all;

 Entity fiveBitMux2to1 is 
	
	
 port(
    input0: in std_logic_vector(4 downto 0);
    input1: in std_logic_vector(4 downto 0); 
	output:out std_logic_vector(4 downto 0); 	
	sel:in std_logic
	); 
  end fiveBitMux2to1;
	
 Architecture Fun_mux of fiveBitMux2to1 is 
 
 begin 
	 
 output<= input0 when sel='0'else
	      input1;
	
  end Fun_mux;