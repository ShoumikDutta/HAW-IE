library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;
use ieee.numeric_std.all;

entity MODN_COUNTER is
generic(MAX:integer :=8);

port ( CLK,CLRN,ARESETN : in bit;
CNT : out bit_vector( natural(log2(real(MAX)))-1 downto 0));
end entity MODN_COUNTER;

architecture BEHAVIORAL of MODN_COUNTER is
	signal S : unsigned(natural(log2(real(MAX)))-1 downto 0);
	begin
	P_SYNC : process (CLK, CLRN)
	begin
		if ARESETN='0' then S<=to_unsigned(0,S'length);
		elsif CLK' event and CLK='1' then
			if CLRN='1' then S<=to_unsigned(0,S'length);
			elsif S=to_unsigned(MAX-1,S'length) then		
				S<=to_unsigned(0,S'length);
			else
				S<=S+1;
			end if;
		end if;
	end process P_SYNC;
	P_OUT : process (S)
	begin
	
	CNT <= to_bitvector(std_logic_vector(S));
	end process P_OUT;

end architecture BEHAVIORAL;