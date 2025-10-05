library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MOD16_UD_CNT_WLOAD is
   port ( TCEN, CNTEN, DIR, LOAD, ARESETN, CLK : in bit;
	  PRE : in  unsigned (3 downto 0);
	  DIG0 : out bit_vector(3 downto 0);
	  DIG1 : out bit_vector(3 downto 0);
      CNT : out bit_vector (3 downto 0);
      TC  : out bit);
end entity MOD16_UD_CNT_WLOAD;

architecture BEHAVIORAL of MOD16_UD_CNT_WLOAD is
signal S_REG : unsigned(3 downto 0);

begin

P_SYNC : process (ARESETN, CLK)
begin
	if ARESETN = '0' then S_REG <= "0000" after 5 ns;
	else 
		if CLK'event and CLK='1' then
			if LOAD='1' then S_REG <= PRE after 5 ns;
			else				if CNTEN='0' then
					if DIR = '0' then S_REG <= S_REG - 1 after 5 ns;
					else S_REG <= S_REG + 1 after 5 ns;
					end if;
				end if;  
			end if; 
		end if;
	end if;
end process P_SYNC;

P_OUT : process (S_REG, DIR, TCEN)
begin
	TC <= '0' after 5 ns;
	if TCEN='0' then
		if (DIR = '0' and S_REG = 0) or (DIR = '1' and S_REG = 15) then TC <= '1' after 5 ns;
   		end if;
	end if;
	
	CNT <= to_bitvector(std_logic_vector(S_REG));
	DIG0 <= to_bitvector(std_logic_vector(S_REG));
	DIG1 <= "0000";
	if S_REG > 9 then
		DIG0 <= to_bitvector(std_logic_vector(S_REG - "1010")); -- subtract 10, display the last digit
		DIG1 <= "0001";
	end if;
	
end process P_OUT;

end;
