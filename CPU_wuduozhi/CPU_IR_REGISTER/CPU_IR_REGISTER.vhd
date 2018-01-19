library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU_IR_REGISTER is
port(
	CLK,LD_IR : in std_logic;
	Data_in : in std_logic_vector(7 downto 0);
	Data_out : out std_logic_vector(7 downto 0)
);
end CPU_IR_REGISTER;

architecture ip of CPU_IR_REGISTER is
	signal R_IR : std_logic_vector(7 downto 0);
begin

	process(CLK,LD_IR)
	begin 	
		if (CLK'EVENT and CLK = '1' and LD_IR='1') then
			R_IR<=Data_in;
		end if;
	end process;
	
	Data_out <= R_IR;

end ip;