DROP TABLE order_item;
DROP TABLE article;
DROP TABLE orders;
DROP TABLE customer;


CREATE TABLE customer
(
  c_id int CONSTRAINT pk_customer PRIMARY KEY,
  name varchar(30) NOT NULL
);

CREATE TABLE orders
(
  o_nr int CONSTRAINT pk_orders PRIMARY KEY,
  ordered_at timestamp NOT NULL,
  c_id int CONSTRAINT ordered_by REFERENCES customer
);

CREATE TABLE article
(
  a_nr int CONSTRAINT pk_article PRIMARY KEY,
  name varchar(30) NOT NULL,
  price numeric(8,2) NOT NULL,
  description varchar(40)
);

CREATE TABLE order_item
(
  o_nr int CONSTRAINT fk_oi_orders REFERENCES orders,
  a_nr int CONSTRAINT fk_oi_article REFERENCES article,
  quantity int NOT NULL,
  CONSTRAINT check_qnt_pos CHECK (quantity > 0),
  CONSTRAINT pk_order_items PRIMARY KEY(o_nr, a_nr)
);

-------------------------------------------------------------

INSERT INTO customer VALUES (1, 'John');
INSERT INTO customer VALUES (2, 'Paul');
INSERT INTO customer VALUES (3, 'George');
INSERT INTO customer VALUES (4, 'Ringo');
------
INSERT INTO orders VALUES (1, to_timestamp('2010-11-11', 'YYYY-MM-DD'), 2);
INSERT INTO orders VALUES (2, to_timestamp('2011-01-27', 'YYYY-MM-DD'), 2);
INSERT INTO orders VALUES (3, to_timestamp('2011-01-25', 'YYYY-MM-DD'), 4);
INSERT INTO orders VALUES (4, to_timestamp('2011-02-04', 'YYYY-MM-DD'), 4);
INSERT INTO orders VALUES (5, to_timestamp('2011-04-01', 'YYYY-MM-DD'), 4);
------
INSERT INTO article VALUES (1, 'Apple', 0.99, 'An apple a day keeps the doctor away');
INSERT INTO article VALUES (2, 'Melon', 2.99, 'Water Melon');
INSERT INTO article VALUES (3, 'Tomato', 0.49, null);
INSERT INTO article VALUES (4, 'Chili', 1.49, 'Very hot');
INSERT INTO article VALUES (5, 'Pear', 0.99, null);
INSERT INTO article VALUES (6, 'Lemon', 1.03, 'Very healthy');
INSERT INTO article VALUES (7, 'Grapefruit', 1.99, null);
INSERT INTO article VALUES (8, 'Kiwi', 0.79, 'Also healthy');
INSERT INTO article VALUES (9, 'Banana', 0.49, null);
INSERT INTO article VALUES (10, 'Cabbage', 1.35, null);

------
INSERT INTO order_item VALUES (1,1, 5);
INSERT INTO order_item VALUES (1,2, 1);
INSERT INTO order_item VALUES (1,4, 10);

INSERT INTO order_item VALUES (2,4, 10);

INSERT INTO order_item VALUES (3,1, 10);

INSERT INTO order_item VALUES (4,1, 20);
INSERT INTO order_item VALUES (4,2, 2);

INSERT INTO order_item VALUES (5,1, 15);
INSERT INTO order_item VALUES (5,4, 100);
INSERT INTO order_item VALUES (5,6, 3);
INSERT INTO order_item VALUES (5,8, 5);
INSERT INTO order_item VALUES (5,9, 4);

COMMIT;   -- commit to all changes (inserts)

--8.1 display all articles
select *from article;   
--8.2
select * from article where price = 0.99;
--8.3
select price from article where name = 'Apple';
--8.4
select name, price from article where description is NULL;
--8.5
select name, price from article order by name ASC;
--8.6
select name, price from article order by price DESC;
--8.7
select avg(price) from article;
--8.8
select max(price) from article;
--8.9
select min(price) from article;
--8.10
--select o_nr from customer, orders where customer.name = 'Ringo' and customer.c_id = orders.c_id;
select orders.o_nr from customer inner join orders ON customer.name = 'Ringo' and customer.c_id = orders.c_id;
--8.11
select customer.name, orders.o_nr from customer inner join orders ON customer.c_id=orders.c_id;
--8.12
select customer.name, orders.o_nr from customer full outer join orders ON customer.c_id=orders.c_id;
--8.13
select distinct customer.name, article.name from customer, article, order_item, orders where customer.c_id = orders.c_id and orders.o_nr = order_item.o_nr and article.a_nr = order_item.a_nr order by customer.name, article.name asc;
--8.14
select distinct article.name, article.price, order_item.quantity , order_item.quantity * article.price FROM order_item, article WHERE order_item.o_nr=5 AND order_item.a_nr = article.a_nr ORDER BY article.name ASC;
--8.15
select sum(order_item.quantity*article.price) FROM order_item, article WHERE order_item.o_nr=5 AND order_item.a_nr = article.a_nr;
--8.16
select order_item.o_nr, sum(order_item.quantity*article.price) FROM order_item, article, orders WHERE order_item.o_nr = orders.o_nr and order_item.a_nr = article.a_nr group by order_item.o_nr; 
--8.17
select order_item.o_nr, customer.name, sum(order_item.quantity*article.price) FROM order_item, article, orders, customer WHERE order_item.o_nr = orders.o_nr and order_item.a_nr = article.a_nr and customer.c_id = orders.c_id group by order_item.o_nr, customer.name; 
