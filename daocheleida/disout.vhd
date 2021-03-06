LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
ENTITY disout IS
    PORT(
        clk: in std_logic;
        dis: in integer range 0 to 1200;
        to38: out std_logic_vector(2 downto 0);
        to7: out std_logic_vector(3 downto 0)
        );
END ENTITY disout;
ARCHITECTURE disout_arch OF disout IS 
	signal dis0:  integer range 0 to 1200;
	signal p1: integer range 0 to 120;
	signal p2: integer range 0 to 12;
	signal p3: integer range 0 to 9;
	signal js: std_logic_vector(9 downto 0):="0000000000";
	signal sel: std_logic_vector(1 downto 0):="00";
	signal to71,to72,to73,to74: std_logic_vector(3 downto 0);
begin 
process (dis,clk)
begin
dis0<=dis;
p1<=dis0/10;
p2<=p1/10;
p3<=p2/10;
if (clk'event and clk='1') then 
	to74<=conv_std_logic_vector(p3 rem 10,4);
	to73<=conv_std_logic_vector(p2 rem 10,4);
	to72<=conv_std_logic_vector(p1 rem 10,4);
	to71<=conv_std_logic_vector(dis0 rem 10,4);
    js<=js+1;
	if(js="1111111111") then 
	   js<="0000000000";
	   if(sel="00") then to38<="111";to7<=to71;sel<=sel+1;
	   elsif(sel="01") then to38<="110";to7<=to72;sel<=sel+1;
	   elsif(sel="10") then to38<="101";to7<=to73;sel<=sel+1;
	   elsif(sel="11") then to38<="100";to7<=to74;sel<="00";
	   end if;
	 end if;
end if;
end process;
end disout_arch;