library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Traffic_light is
port(RESET, CLK, DN : in bit;
     MAIN, SEC : out bit_vector(4 downto 0));
end entity Traffic_light;

architecture CONTROLLER of Traffic_light is
signal Z : unsigned (3 downto 0);

begin
 P1: process(CLK, RESET)
	begin
	if RESET = '0' then Z <= "0000" after 5 ns;
	elsif CLK = '1' and CLK' event then 
		if DN = '0' then
			if Z = "1000" then Z <= "0001" after 5 ns;
			elsif Z = "0001" then Z <= "1110" after 5 ns;
			elsif Z = "1111" then Z <= "1110" after 5 ns;
			else  Z <= Z + 1 after 5 ns;
			end if;
		else
			if Z = "0001" then Z <= "0010" after 5 ns;
			elsif Z = "1000" then Z <= "0010" after 5 ns;
			elsif Z = "1111" then Z <= "0000" after 5 ns;
			else Z <= Z + 1 after 5 ns;
			end if;
		end if;
	end if;
end process P1;

P2: process(Z)
	begin
	
	case Z is
		when "0000" => MAIN <= "01010" after 5 ns; SEC <= "01010" after 5 ns;  

		when "0001" => MAIN <= "10010" after 5 ns; SEC <= "10010" after 5 ns; 

		when "0010" => MAIN <= "11001" after 5 ns; SEC <= "10010" after 5 ns; 

		when "0011" => MAIN <= "00101" after 5 ns; SEC <= "10010" after 5 ns; 

		when "0100" => MAIN <= "01010" after 5 ns; SEC <= "10010" after 5 ns; 

		when "0101" => MAIN <= "10010" after 5 ns; SEC <= "10010" after 5 ns; 

		when "0110" => MAIN <= "10010" after 5 ns; SEC <= "11001" after 5 ns; 

		when "0111" => MAIN <= "10010" after 5 ns; SEC <= "00101" after 5 ns; 

		when "1000" => MAIN <= "10010" after 5 ns; SEC <= "01010" after 5 ns; 

		when "1110" => MAIN <= "00000" after 5 ns; SEC <= "01000" after 5 ns; 

		when "1111" => MAIN <= "00000" after 5 ns; SEC <= "00000" after 5 ns; 

		when others => MAIN <= "00000" after 5 ns; SEC <= "00000" after 5 ns; 
	end case;
end process P2;
end CONTROLLER;
