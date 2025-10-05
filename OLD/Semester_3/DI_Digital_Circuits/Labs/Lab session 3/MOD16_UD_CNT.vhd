library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MOD16_UD_CNT is
   port ( ARESETN, CLK, DIR, CNTEN : in bit;
          CNT : out bit_vector (3 downto 0);
          TCUP, TCDN : out bit);
end entity MOD16_UD_CNT;

architecture BEHAVIORAL of MOD16_UD_CNT is
signal S_REG : unsigned(3 downto 0);

begin

P_SYNC : process (ARESETN, CLK)
begin
   if ARESETN = '0' then S_REG <= "0000" after 5 ns;
   elsif CLK'event and CLK='1' then
      if CNTEN='0' then
         if DIR = '0' then
            S_REG <= S_REG - 1 after 5 ns;
         else
            S_REG <= S_REG + 1 after 5 ns;
         end if;
      end if;  
   end if; 
end process P_SYNC;

P_OUT : process (S_REG,DIR)
begin
   TCUP <= '0'; TCDN <= '0' after 5 ns; 

   if DIR = '0' and S = 0 then 
      TCDN <= '1' after 5 ns;
   elsif DIR = '1' and S = 15 then 
      TCUP <= '1' after 5 ns;
   end if;
   
   CNT <= to_bitvector(std_logic_vector(S));
      
end process P_OUT;
    
end;
