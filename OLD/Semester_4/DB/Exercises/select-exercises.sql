Possible queries you would want to ask:
a) Get all persons that have a height between 160 and 180
b) Get the average height of persons that have Susan as mother
c) Get the amount of people that have a job
d) Get all grandmothers and their children
e) Get the average height of persons that belong tho the same father
f) Get the average income of employees for the different companies. Only show companies that have an average income that is higher then 800.
g) Get the name and height of the smallest person.
h) Get for every company_id the person with the smallest income.













Possible SOLUTIONS to given queries
a)
SELECT * FROM person WHERE height >= 160 AND height <= 180;
-- OR
SELECT * FROM person WHERE height BETWEEN 160 AND 180;
b)
SELECT AVG(height) FROM person WHERE mother = 'Susan';
c)
SELECT COUNT(*) FROM person WHERE company_id IS NOT NULL; 
d)
SELECT parent.mother AS granny, child.name AS child FROM person child, person parent WHERE ( child.mother = parent.name OR child.father = parent.name ) AND parent.mother IS NOT NULL;

e)
SELECT AVG(height), father FROM person p GROUP BY father;

f)
SELECT AVG(income), c.name FROM person p, company c WHERE company_id = c.id GROUP BY c.name HAVING AVG(income) > 800;

g)
SELECT name, height FROM person p WHERE height = (SELECT MIN(height) FROM person);

h)
SELECT company_id, name, MIN(income) FROM person p1 WHERE income = (SELECT MIN(income) FROM person p2 WHERE p1.company_id = p2.company_id)  GROUP BY company_id ;
-- OR
SELECT c.name, p.name, p.income FROM company c, person p WHERE company_id = c.id AND p.income IN (
SELECT MIN(income) FROM PERSON p1 WHERE company_id IS NOT NULL GROUP BY company_id);



