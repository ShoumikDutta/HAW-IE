--DELETE FROM person WHERE name1 = 'Trent' AND father = 'Albert' AND mother = 'Jane' AND father = 'Trent';
--INSERT INTO Person VALUES('Bob', TO_DATE('04-07-1986', 'DD-MM-YYYY' ), null, 'Albert', 'Alice');
--UPDATE person SET father = 'Bob' WHERE name1 = 'Jane' OR name1 = 'Joe';

UPDATE person SET father = null WHERE name1 = 'Bob';