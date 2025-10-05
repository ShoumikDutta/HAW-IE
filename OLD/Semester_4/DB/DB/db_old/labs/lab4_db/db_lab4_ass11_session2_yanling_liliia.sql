UPDATE tab10 SET N=(N*3) WHERE id=1;
select * from tab10;
commit;
select * from tab11;
