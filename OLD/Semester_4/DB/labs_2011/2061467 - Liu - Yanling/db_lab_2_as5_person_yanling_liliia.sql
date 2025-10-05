drop table person;
create table Person(P_name varchar(20) primary key,
                    birthday date not null,
                    dayOfDeath date,
            Father varchar(20) constraint father_2_person  references Person,
            Mother varchar(20) constraint mother_2_person references Person); --creates table Person

/*delete from Person;*/
insert into Person values('Walt', TO_DATE('10-apr-1930', 'DD-MON-YYYY'),
                                  TO_DATE('20-dez-2007', 'DD-MON-YYYY'),
                                  null,null); --insert values in table person

insert into Person values('Ellen', TO_DATE('9-sep-1930', 'DD-mon-YYYY'),
                                   null,null,null); --insert values in table person

insert into Person values('Rich', TO_DATE('19-apr-1935', 'DD-MON-YYYY'),
                                  null,null,null); --insert values in table person

insert into Person values('Sue', TO_DATE('13-mai-1940', 'DD-MON-YYYY'),
                                 TO_DATE('28-mai-2002', 'DD-MON-YYYY'),
                                 null,null); --insert values in table person

insert into Person values('Bob', TO_DATE('11-nov-1965', 'DD-MON-YYYY'),
                           null,'Walt','Ellen'); --insert values in table person

insert into Person values('Susan', TO_DATE('8-aug-1966', 'DD-MON-YYYY'),
                           null,'Rich','Sue'); --insert values in table person

insert into Person values('Jane', TO_DATE('1-jan-2006', 'DD-MON-YYYY'),
                           null,'Bob','Susan'); --insert values in table person

insert into Person values('Joe', TO_DATE('2-feb-2007', 'DD-MON-YYYY'),
                           null,'Bob','Susan'); --insert values in table person
                           
insert into Person	values('Alice',  TO_DATE( '2-feb-1955', 'DD-MON-YYYY' ), null, null, null);

insert into Person	values('Albert', TO_DATE( '3-mai-1956', 'DD-MON-YYYY' ), null, null, null);

insert into Person 	values('Trent', TO_DATE('4-jul-1986', 'DD-MON-YYYY' ), null, 'Alice', 'Albert');

update Person	set Father = 'Trent'  where P_name = 'Jane' or P_name =  'Joe' ;

delete from Person	where P_name = 'Walt' or  P_name = 'Ellen' or P_name = 'Bob';
                                                  
commit;