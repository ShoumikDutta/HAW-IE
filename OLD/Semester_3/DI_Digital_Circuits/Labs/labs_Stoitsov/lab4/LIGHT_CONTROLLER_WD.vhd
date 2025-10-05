library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity LIGHT_CONTROLLER_WD is
generic(MAX_C:integer :=8);
port(DN,ARESET,CLK : in bit;
     
     SL,ML : out bit_vector(4 downto 0));
    
end entity;
architecture BEHAVIORAL of LIGHT_CONTROLLER_WD is
signal S: unsigned (3 downto 0);
signal CLR: bit;
signal CNT_C : bit_vector( natural(log2(real(MAX_C)))-1 downto 0);
component MODN_COUNTER is
generic(MAX:integer :=8);
port ( CLK,CLRN,ARESETN : in bit;
	CNT : out bit_vector( natural(log2(real(MAX)))-1 downto 0));
end component MODN_COUNTER;
begin
	COUNTER : MODN_COUNTER
		generic map (MAX=>MAX_C)
		port map(ARESETN=>ARESET,CLK=>CLK,CLRN=>CLR,CNT=>CNT_C);
	
	
	P_SYNC : process(ARESET,CLK)
	begin
			
	 if ARESET = '0' then 
		S <= "0000" ;
	 elsif CLK'event and CLK='1' then
		case S is
		when "0000"=>
			ML<="10010";
			SL<="10010";
			if CLR='1' then
				S<="0001";
			end if;
			
		when "0001"=>
			ML<="10100";
			SL<="10100";
			if CLR='1' and DN='0' then
				S<="0010";
			elsif CLR='1' and DN='1' then
				S<="1001";
			end if;
		when "0010"=>
			ML<="01110";
			SL<="10100";
			if CLR='1' then
				S<=S+1;
			end if;
		when "0011"=>
			ML<="01001";
			SL<="10100";
			if CLR='1' then
				S<="0100";
			end if;
		when "0100"=>
			ML<="10010";
			SL<="10100";
			if CLR='1' then			
				S<=S+1;
			end if;
		when "0101"=>
			ML<="10100";
			SL<="10100";
			if CLR='1' then
				S<="0110";
			end if;
		when "0110"=>
			ML<="10100";
			SL<="01110";
			if CLR='1' then			
				S<=S+1;
			end if;
		when "0111"=>
			ML<="10100";
			SL<="01001";
			if CLR='1' then
				S<="1000";
			end if;
		when "1000"=>
			ML<="10100";
			SL<="10010";
			if DN='0' then
				S<="0010";
			elsif DN='1' then
				S<="0000";
			end if;
		when "1001"=>
			ML<="00000";
			SL<="00010";
			if CLR='1' then			
				S<=S+1;
			end if;
		when "1010"=>
			ML<="00000";
			SL<="00000";
			if DN='0' then
				S<="0000";
			elsif DN='1' then
				S<="1001";
			end if;
		when others=>
			ML<="00000";
			SL<="00000";
		end case;
	   
	 end if;
	end process P_SYNC;	
	
	
	
	
	XXX :process(CNT_C,CLK)
	begin
	CLR<='0';
	case S is 
		when "0000" =>
			if CNT_C="001" then CLR<='1'; end if;
		when "0001" =>
			if CNT_C="001" then CLR<='1'; end if;
		when "0010" =>
			if CNT_C="000" then CLR<='1'; end if;
		when "0011" =>
			if CNT_C="111" then CLR<='1'; end if;
		when "0100" =>
			if CNT_C="000" then CLR<='1'; end if;
		when "0101" =>
			if CNT_C="001" then CLR<='1'; end if;
		when "0110" =>
			if CNT_C="000" then CLR<='1'; end if;
		when "0111" =>
			if CNT_C="011" then CLR<='1'; end if;
		when "1000" =>
			if CNT_C="000" then CLR<='1'; end if;
		when "1001" =>
			if CNT_C="000" then CLR<='1'; end if;
		when "1010" =>
			if CNT_C="000" then CLR<='1'; end if;
		
		when others=>CLR<='0';
		
	end case;
	end process XXX;
end architecture BEHAVIORAL;