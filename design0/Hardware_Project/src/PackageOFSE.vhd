library IEEE;
use IEEE.std_logic_1164.all;

Package SE_Package is
	
	component SE is 					   
	   port(
          input_SE : in std_logic_vector(15 downto 0);
	      output_SE: out std_logic_vector(31 downto 0) 	
	       ); 
	end component;
	
end  SE_Package;