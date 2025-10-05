
drop table tab10;

create table tab10 (id integer CONSTRAINT pk_tab10 PRIMARY KEY, n integer);
INSERT INTO tab10 Values (1,1);
INSERT INTO tab10 Values (2,2); 
INSERT INTO tab10 Values (3,3);
UPDATE tab10 SET N=(N*2) WHERE id=1;


select * from tab10;
commit;
create table tab11 (id integer CONSTRAINT pk_tab11 PRIMARY KEY, n integer);
select * from tab11;

