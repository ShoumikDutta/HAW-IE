library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TRAFFIC_LIGHT_W_CNT is
generic(L : integer := 8);
port(RESET, CLK, DN : in bit;
     MAIN, SEC : out bit_vector(4 downto 0));
end entity TRAFFIC_LIGHT_W_CNT;

architecture CONTROLLER of TRAFFIC_LIGHT_W_CNT is
signal Z : unsigned (3 downto 0);
signal CLEAR : bit;
signal COUNTER : bit_vector(3 downto 0);

component MOD_N_CNT is
   generic(N : integer := 8);
   port ( ARESETN, CLK, CLRN : in bit;
          CNT : out bit_vector (3 downto 0));
end component MOD_N_CNT;

begin

INST: MOD_N_CNT
	generic map(L)
	port map(RESET, CLK, CLEAR, COUNTER);

 P1: process(CLK, RESET)
	begin
	if RESET = '0' then Z <= "0000" after 5 ns;
	elsif CLK = '1' and CLK' event then 
		case Z is
		when "0000" => MAIN <= "01010" after 5 ns; SEC <= "01010" after 5 ns;
			if CLEAR = '1' then Z <= "0001" after 5 ns;
			end if;
		when "0001" => MAIN <= "10010" after 5 ns; SEC <= "10010" after 5 ns;
			if CLEAR = '1' then
				if DN = '0' then Z <= "1110" after 5 ns;
				else Z <= "0010" after 5 ns;
				end if;
			end if;
		when "0010" => MAIN <= "11001" after 5 ns; SEC <= "10010" after 5 ns;
			if CLEAR = '1' then Z <= "0011" after 5 ns;
			end if;
		when "0011" => MAIN <= "00101" after 5 ns; SEC <= "10010" after 5 ns;
			if CLEAR = '1' then Z <= "0100" after 5 ns;
			end if;
		when "0100" => MAIN <= "01010" after 5 ns; SEC <= "10010" after 5 ns;
			if CLEAR = '1' then Z <= "0101" after 5 ns;
			end if;
		when "0101" => MAIN <= "10010" after 5 ns; SEC <= "10010" after 5 ns;
			if CLEAR = '1' then Z <= "0110" after 5 ns;
			end if;
		when "0110" => MAIN <= "10010" after 5 ns; SEC <= "11001" after 5 ns;
			if CLEAR = '1' then Z <= "0111" after 5 ns;
			end if;
		when "0111" => MAIN <= "10010" after 5 ns; SEC <= "00101" after 5 ns;
			if CLEAR = '1' then Z <= "1000" after 5 ns;
			end if;
		when "1000" => MAIN <= "10010" after 5 ns; SEC <= "01010" after 5 ns;
			if CLEAR = '1' then 
				if DN = '0' then Z <= "0001" after 5 ns;
				else Z <= "0010" after 5 ns;
				end if;
			end if;
		when "1110" => MAIN <= "00000" after 5 ns; SEC <= "01000" after 5 ns;
			if CLEAR = '1' then Z <= "1111" after 5 ns;
			end if;
		when "1111" => MAIN <= "00000" after 5 ns; SEC <= "00000" after 5 ns;
			if CLEAR = '1' then 
				if DN = '0' then Z <= "1110" after 5 ns;
				else Z <= "0000" after 5 ns;
				end if;
			end if;
		when others => MAIN <= "00000" after 5 ns; SEC <= "00000" after 5 ns;
		end case;
	end if;
end process P1;

P2: process(COUNTER, CLK)
	begin
	CLEAR <= '0' after 5 ns;
	
	case Z is
		when "0000" => if COUNTER = "0001" then CLEAR <= '1' after 5 ns; end if;

		when "0001" => if COUNTER = "0001" then CLEAR <= '1' after 5 ns; end if;

		when "0010" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if; 

		when "0011" => if COUNTER = "0111" then CLEAR <= '1' after 5 ns; end if; 

		when "0100" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if; 

		when "0101" => if COUNTER = "0001" then CLEAR <= '1' after 5 ns; end if;

		when "0110" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if; 

		when "0111" => if COUNTER = "0011" then CLEAR <= '1' after 5 ns; end if;

		when "1000" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if;

		when "1110" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if;

		when "1111" => if COUNTER = "0000" then CLEAR <= '1' after 5 ns; end if;
	
		when others => CLEAR <= '0' after 5 ns;

	end case;
end process P2;
end CONTROLLER;
