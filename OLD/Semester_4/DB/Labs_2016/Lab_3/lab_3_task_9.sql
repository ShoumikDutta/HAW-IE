--DELETE FROM Person WHERE Name1 = 'Walt' OR Name1 = 'Ellen' OR Name1 = 'Bob';
--INSERT INTO Person VALUES('Alice', TO_DATE( '02-02-1955', 'DD-MM-YYYY' ), null, null, null);
--INSERT INTO Person VALUES('Albert', TO_DATE( '03-03-1956', 'DD-MM-YYYY' ), null, null, null);
--INSERT INTO Person VALUES('Trent', TO_DATE('04-07-1986', 'DD-MM-YYYY' ), null, 'Albert', 'Alice');
--UPDATE Person SET Father = 'Trent' WHERE Name1 = 'Jane' OR Name1 = 'Joe' ;

SET LINESIZE 2000;

--SELECT * FROM article;

--SELECT * FROM article WHERE price = 0.99;

--SELECT price FROM article WHERE name = 'Apple';

--SELECT name, price FROM article WHERE description IS NULL;

--SELECT name, price FROM article ORDER BY name ASC;

--SELECT name, price FROM article ORDER BY price DESC;

--SELECT AVG (price) FROM article;

--SELECT MAX (price) FROM article;

--SELECT MIN (price) FROM article;

--SELECT orders.o_nr FROM customer,orders WHERE customer.name = 'Ringo' AND customer.c_id = orders.c_id ORDER BY orders.o_nr ASC;

--SELECT customer.name, orders.o_nr FROM customer INNER JOIN orders ON customer.c_id = orders.c_id ORDER BY orders.o_nr ASC;

--SELECT customer.name, orders.o_nr FROM customer FULL OUTER JOIN orders ON customer.c_id = orders.c_id ORDER BY orders.o_nr ASC;

--correct 13
--SELECT DISTINCT customer.name, article.name FROM customer, article, order_item, orders
--WHERE customer.c_id = orders.c_id AND orders.o_nr = order_item.o_nr AND article.a_nr = order_item.a_nr ORDER BY customer.name, article.name ASC;

--not correct 13, trying to change columns (c_name and a_name) to (a_name and c_name)
--SELECT DISTINCT article.name, customer.name FROM customer, article, order_item, orders
--WHERE customer.c_id = orders.c_id AND orders.o_nr = order_item.o_nr AND article.a_nr = order_item.a_nr ORDER BY article.name, customer.name ASC;

--SELECT DISTINCT article.name, article.price, order_item.quantity, order_item.quantity * article.price FROM article, order_item
--WHERE order_item.o_nr = 5 AND article.a_nr = order_item.a_nr ORDER BY article.name ASC;

--SELECT SUM (article.price * order_item.quantity) FROM article, order_item WHERE order_item.o_nr = 5 AND article.a_nr = order_item.a_nr ORDER BY article.name ASC;

--SELECT order_item.o_nr, SUM (article.price * order_item.quantity) FROM article, order_item, orders WHERE orders.o_nr = order_item.o_nr AND article.a_nr = order_item.a_nr GROUP BY order_item.o_nr;

--SELECT order_item.o_nr, customer.name, SUM (article.price * order_item.quantity) FROM customer, article, order_item, orders
--WHERE orders.o_nr = order_item.o_nr AND article.a_nr = order_item.a_nr AND customer.c_id = orders.c_id GROUP BY order_item.o_nr, customer.name ORDER BY customer.name ASC;

--SELECT order_item.o_nr, SUM(order_item.quantity*article.price) FROM order_item, article, orders WHERE order_item.o_nr = orders.o_nr AND order_item.a_nr = article.a_nr GROUP BY order_item.o_nr;

--SELECT  distinct  article.name,  article.price,  order_item.quantity,  order_item.quantity  *  article.price  FROM 
--order_item,  article  WHERE  order_item.o_nr=5  AND  order_item.a_nr  =  article.a_nr  ORDER  BY 
--article.name ASC;

--ass. 17
SELECT order_item.o_nr, customer.name, SUM (article.price * order_item.quantity) FROM article, order_item, orders
WHERE orders.o_nr = order_item.o_nr AND article.a_nr = order_item.a_nr GROUP BY order_item.o_nr ORDER BY order_item.o_nr DESC;