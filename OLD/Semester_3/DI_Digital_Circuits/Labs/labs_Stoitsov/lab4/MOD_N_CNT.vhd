library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MOD_N_CNT is
   generic(N : integer := 8);
   port ( ARESETN, CLK, CLRN : in bit;
          CNT : out bit_vector (3 downto 0));
end entity MOD_N_CNT;

architecture BEHAVIORAL of MOD_N_CNT is
signal S : unsigned(3 downto 0);

begin

P_SYNC : process (ARESETN, CLK)
begin
   if ARESETN = '0' then S <= to_unsigned(0,S'length) after 5 ns;
   elsif CLK'event and CLK='1' then 
   		if CLRN = '1' then S <= to_unsigned(0,S'length) after 5 ns;
		elsif S=to_unsigned(N-1,S'length) then S<=to_unsigned(0,S'length) after 5 ns;
   		else S <= S + 1 after 5 ns;  
  		end if;
   end if; 
end process P_SYNC;

P_OUT : process (S)
begin
    CNT <= to_bitvector(std_logic_vector(S));
      
end process P_OUT;
    
end architecture BEHAVIORAL;