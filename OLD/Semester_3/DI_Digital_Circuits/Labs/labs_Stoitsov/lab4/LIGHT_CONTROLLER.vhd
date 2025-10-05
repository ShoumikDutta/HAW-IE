library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LIGHT_CONTROLLER is
port(DN,ARESET,CLK : in bit;
     SL,ML : out bit_vector(4 downto 0));
end entity;
architecture BEHAVIORAL of LIGHT_CONTROLLER is
signal S: unsigned (3 downto 0);
begin
	P_SYNC : process(ARESET,CLK)
		
	begin	
	 if ARESET = '0' then 
		S <= "0000" ;
	 elsif CLK'event and CLK='1' then
	   if DN='0' then
		if S="1000" then S<="0010";
		elsif S="1010" then S<="0000";
		else S <= S + 1 ;
		end if;
           else
	   	if S="1010" then S<="1001";
		elsif S="0001" then S<="1001";
		elsif S="1000" then S<="0001";
		else S <= S + 1 ;
		end if;
           end if;
	 end if;
	end process P_SYNC;	
	P_OUT:process(S)
	begin
		case S is
		when "0000"=>
			ML<="10010";
			SL<="10010";
		when "0001"=>
			ML<="10100";
			SL<="10100";
		when "0010"=>
			ML<="01110";
			SL<="10100";
		when "0011"=>
			ML<="01001";
			SL<="10100";
		when "0100"=>
			ML<="10010";
			SL<="10100";
		when "0101"=>
			ML<="10100";
			SL<="10100";
		when "0110"=>
			ML<="10100";
			SL<="01110";
		when "0111"=>
			ML<="10100";
			SL<="01001";
		when "1000"=>
			ML<="10100";
			SL<="10010";
		when "1001"=>
			ML<="00000";
			SL<="00010";
		when "1010"=>
			ML<="00000";
			SL<="00000";
		when others=>
			ML<="00000";
			SL<="00000";
		end case;
	
	end process P_OUT;
	
end architecture BEHAVIORAL;