drop table tab10;
CREATE TABLE tab10(id integer CONSTRAINT pk_tab10 PRIMARY KEY,n integer);

INSERT INTO TAB10 Values (1,1);
INSERT INTO TAB10 Values (2,2); 
INSERT INTO TAB10 Values (3,3);
select * from tab10;
UPDATE TAB10 SET N=33 WHERE id=3;
rollback;

--rollback;
UPDATE TAB10 SET N=(N*2) WHERE id=1;
--select * from tab10;
--rollback;
--select * from tab10;
--rollback;