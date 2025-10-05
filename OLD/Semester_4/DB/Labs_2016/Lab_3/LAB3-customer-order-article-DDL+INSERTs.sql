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

