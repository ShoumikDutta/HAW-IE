entity FULL_ADDER is

   port( A,B,CIN : in bit;
         S,COUT  : out bit);

end entity FULL_ADDER;

architecture DATAFLOW of FULL_ADDER is

begin

   S <= (A xor B) xor CIN after 5 ns;
   COUT <= (CIN and (A or B)) or (A and B) after 5 ns;    

end architecture DATAFLOW;
