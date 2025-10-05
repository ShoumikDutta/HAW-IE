entity TrafficLight is
        generic (N : integer :=8);
        port(RESETN, CLK_S: in bit;
             D_N  :       in bit;
             MR_A : out bit_vector (2 downto 0);
             MR_P : out bit_vector (1 downto 0); 
             SR_A : out bit_vector (2 downto 0);
             SR_P : out bit_vector (1 downto 0)        
             );
end TrafficLight;

architecture MOORE of TrafficLight is
        type STATES is (R, P_1, P_D2, P_D3, P_D4, P_D5, P_D6, P_D7, P_D8, P_N2, P_N3);
        signal Z, ZPLUS : STATES;
        signal CNT_S : bit_vector (3 downto 0);
		  signal CLRN :  bit;

        --component declaration
 component MOD16_UD_CNT
   port (ARESETN, CLK, CLR : in bit;
         CNT : out bit_vector (3 downto 0)
         );
end component MOD16_UD_CNT;
        
begin


--instantiation of component
INST : MOD16_UD_CNT
port map (RESETN, CLK_S, CLRN, CNT_S);



ZREG: process (CLK_S, RESETN)
begin
        --asynchronous active-low reset
        if RESETN='0'then
                Z<=R;	-- after 5 ns;
        elsif CLK_S='1'and CLK_S'event then
                --create register to keep current state vector
                Z<=ZPLUS after 5 ns;
        end if;
end process ZREG;

COMBIN: process (D_N, CNT_S, CLRN, Z)
begin
        
        --default values for outputs and next statues ZPLUS
        MR_A<="000"; MR_P<="00"; 
        SR_A<="000"; SR_P<="00";
		  CLRN<='1';
        ZPLUS<=Z;
        
       	case Z is
                
                when R=>MR_A<="010"; MR_P<="01"; SR_A<="010"; SR_P<="01";
					 if CNT_S<="0010" then
						ZPLUS<=P_1;
					 else CLRN<='0';
					 end if;
					 
					 
                when P_1=>MR_A<="001"; MR_P<="01"; SR_A<="001"; SR_P<="01";
                if D_N='1' then
						if CNT_S<="0010" then
							ZPLUS<=P_D2;
						else 
							CLRN<='0';
						end if;
                else ZPLUS<=P_N2;
                end if;
                
                --day time
                when P_D2=>MR_A<="011"; MR_P<="10"; SR_A<="001"; SR_P<="01";
                if CNT_S<="0001" then
						ZPLUS<=P_D3;
					 else CLRN<='0';
					 end if;
                
                when P_D3=>MR_A<="100"; MR_P<="10"; SR_A<="001"; SR_P<="01";
                if CNT_S<="1000" then
						ZPLUS<=P_D4;
					 else CLRN<='0';
					 end if;
                
                when P_D4=>MR_A<="010"; MR_P<="01"; SR_A<="001"; SR_P<="01";
                if CNT_S<="0001" then
						ZPLUS<=P_D5;
					 else CLRN<='0';
					 end if;
                
                when P_D5=>MR_A<="001"; MR_P<="01"; SR_A<="001"; SR_P<="01";
                if CNT_S<="0010" then
						ZPLUS<=P_D6;
					 else CLRN<='0';
					 end if;
                
                when P_D6=>MR_A<="001"; MR_P<="01"; SR_A<="011"; SR_P<="10";
                if CNT_S<="0001" then
						ZPLUS<=P_D7;
					 else CLRN<='0';
					 end if;
                
                when P_D7=>MR_A<="001"; MR_P<="01"; SR_A<="100"; SR_P<="10";
                if CNT_S<="0100" then
						ZPLUS<=P_D8;
					 else CLRN<='0';
					 end if;
                
                when P_D8=>MR_A<="001"; MR_P<="01"; SR_A<="010"; SR_P<="01";
                if CNT_S<="0001" then
						ZPLUS<=P_1;
					 else CLRN<='0';
					 end if;
                
                
                --night time
                when P_N2=>MR_A<="000"; MR_P<="00"; SR_A<="010"; SR_P<="00";
                if CNT_S<="0001" then
						ZPLUS<=P_N3;
					 else CLRN<='0';
					 end if;
                
                when P_N3=>MR_A<="000"; MR_P<="00"; SR_A<="000"; SR_P<="00";
					 if D_N='1' then
						if CNT_S<="0001" then
							ZPLUS<=R;	
						else CLRN<='0';
						end if;
					 else ZPLUS<=P_1;
                end if;
					 
	
                
                
        end case;
end process COMBIN;
end;

