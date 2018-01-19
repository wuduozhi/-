-- decoder_comm
library ieee;
use ieee.std_logic_1164.all;

entity decoder_comm is
port(
	IR : in std_logic_vector(7 downto 0);
	C, Z: in std_logic;
	MOV, ADD, SUB, AND0, NOT0, SHR, SHL, JMP, JZ, JC, IN0, OUT0, NOP, HALT: out std_logic;
	addr1, addr2: out std_logic_vector(1 downto 0));
end decoder_comm;

architecture decoder_comm_arch of decoder_comm is
signal comm : std_logic_vector(3 downto 0);
begin
	addr1 <= IR(3 downto 2);
	addr2 <= IR(1 downto 0);
	comm <= IR(7 downto 4);
	process(comm, IR, C, Z)
	begin
		if comm = "0011" then --mov
			MOV <= '1';
		else
			MOV <= '0';
		end if;
		if comm = "1001" then --add
			ADD <= '1';
		else
			ADD <= '0';
		end if;
		if comm = "0110" then --sub
			SUB <= '1';
		else
			SUB <= '0';
		end if;
		if comm = "1110" then --and
			AND0 <= '1';
		else
			AND0 <= '0';
		end if;
		if comm = "0101" then --not
			NOT0 <= '1';
		else
			NOT0 <= '0';
		end if;
		if comm = "1010" then  
			if IR(1 downto 0) = "00" then	--shr
				SHR <= '1';
				SHL <= '0';
			elsif IR(1 downto 0) = "11" then	--shl
				SHR <= '0';
				SHL <= '1';
			else
				SHR <= '0';
				SHL <= '0';
			end if;
		else
			SHR <= '0';
			SHL <= '0';
		end if;
		if IR = "00010000" then --jmp
			JMP <= '1';
		else
			JMP <= '0';
		end if;
		if (IR = "00010001" and Z = '1') then --jz
			JZ <= '1';
		else
			JZ <= '0';
		end if;
		if (IR = "00010010" and C = '1') then --jc
			JC <= '1';
		else
			JC <= '0';
		end if;
		if comm = "0010" then --in
			IN0 <= '1';
		else
			IN0 <= '0';
		end if;
		if comm = "0100" then --out
			OUT0 <= '1';
		else
			OUT0 <= '0';
		end if;
		if IR = "01110000" then --nop
			NOP <= '1';
		else
			NOP <= '0';
		end if;
		if IR = "10000000" then --halt
			HALT <= '1';
		else
			HALT <= '0';
		end if;
	end process;
end decoder_comm_arch;