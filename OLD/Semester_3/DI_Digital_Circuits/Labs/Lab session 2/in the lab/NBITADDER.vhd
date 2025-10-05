entity NBITADDER is
   generic (N  : integer := 8);  -- N = length of addends
   port  (A    : in  bit_vector (N-1 downto 0); -- 1st addend
          B    : in  bit_vector (N-1 downto 0); -- 2nd addend
          C_IN : in  bit;                       -- 1-bit carry in
          S    : out bit_vector (N downto 0));  -- sum (length N+1)
end entity NBITADDER;

architecture DATAFLOW of NBITADDER is
-- signal vector for carries of the n columns
signal C_TMP : bit_vector (N downto 0);
begin     
    C_TMP(0) <= C_IN; -- first carry is the external carry in
    
    -- N 1-bit adders are generated and their signals connected
    NBIT : for I in 0 to N-1 generate
       -- carry of the i-th column
       S(I) <= (A(I) xor B(I)) xor C_TMP(I) after 5 ns;
       C_TMP(I+1) <= (C_TMP(I) and (A(I) or B(I))) or (A(I) and B(I)) after 5 ns;    
    end generate NBIT;
    -- the last carry after adding the MSBs is added to the output signal 
    -- (result of addition has an extra bit)
    S(N) <= C_TMP(N);
end architecture DATAFLOW;
