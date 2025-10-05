library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ARITH_ADDER is
   generic (N  : integer := 8);  -- N = length of addends
   port  (A    : in  unsigned(N-1 downto 0) ; -- 1st addend
          B    : in  unsigned(N-1 downto 0);  -- 2nd addend
          C_IN : in  unsigned(0 downto 0);    -- 1-bit carry in
          S    : out unsigned(N downto 0));   -- sum (length N+1)
end entity ARITH_ADDER;

architecture ARITHMETIC of ARITH_ADDER is
begin     
    S <= '0'&A + B + C_IN after 5 ns;
end architecture ARITHMETIC;
