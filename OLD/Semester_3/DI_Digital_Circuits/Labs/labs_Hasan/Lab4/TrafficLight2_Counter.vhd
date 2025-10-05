library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MOD16_UD_CNT is
   port (ARESETN, CLK, CLR : in bit;
         CNT : out bit_vector (3 downto 0)
         );
end entity MOD16_UD_CNT;

architecture BEHAVIORAL of MOD16_UD_CNT is
signal S : unsigned(3 downto 0);

begin

P_SYNC : process (ARESETN, CLK)
begin
   if ARESETN = '0' then S <= "0000" after 5 ns;
   elsif CLK'event and CLK='1' then 
       	if CLR='1' then
				S <= "0000";
			else
				if S<8 then
               S <= S + 1 after 5 ns;
				else
				   S<="0000";
				end if;
         end if;
      end if; 
end process P_SYNC;


  CNT <= to_bitvector(std_logic_vector(S));

    
end architecture BEHAVIORAL;
