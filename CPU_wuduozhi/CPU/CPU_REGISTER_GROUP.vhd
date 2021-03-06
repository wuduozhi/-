library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU_REGISTER_GROUP is
port(
	RAddr,WAddr:in std_logic_vector(1 downto 0); 
	W_n,clk        :in std_logic;   --If Write
	Data_in    :in std_logic_vector(7 downto 0);
	A,B    :out std_logic_vector(7 downto 0);
	RESET:in std_logic;
	RA,RB,RC:out std_logic_vector(7 downto 0)
);
end CPU_REGISTER_GROUP;

architecture arch of CPU_REGISTER_GROUP is

signal R_A:std_logic_vector(7 downto 0):="00000001";
signal R_B:std_logic_vector(7 downto 0):="00000010";
signal R_C:std_logic_vector(7 downto 0):="00000001";
signal Chip_Select_Write:std_logic_vector(3 downto 0);

begin
	process(RAddr)
	begin
		case RAddr is
			when "00"=>
				A<=R_A;--A register
			when "01"=>
				A<=R_B;--B register
			when "10"=>
				A<=R_C;--C register
			when "11"=>
				A<=R_C;--C register
		end case;
	end process;
	
	process(WAddr)
	begin
		case WAddr is
			when "00"=>
				B<=R_A;--A register
			when "01"=>
				B<=R_B;--B register
			when "10"=>
				B<=R_C;--C register
			when "11"=>
				B<=R_C;--C register
		end case;
	end process;	
	
	process(clk,W_n,WAddr,RESET)
	begin
		if(RESET='1') then
			R_A<="00000001";
			R_B<="00000011";
			R_C<="00000111";
		else
			if(clk 'event and clk='1' and W_n='0') then
				case WAddr is
					when "00"=>
						R_A<=Data_in;--A register
					when "01"=>
						R_B<=Data_in;--B register
					when "10"=>
						R_C<=Data_in;--C register
					when "11"=>
						R_C<=Data_in;
				end case;
			end if;
		end if;
	end process;
	
	RA<=R_A;
	RB<=R_B;
	RC<=R_C;
	
end arch;