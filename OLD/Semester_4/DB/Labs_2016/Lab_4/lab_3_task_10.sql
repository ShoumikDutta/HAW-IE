SET LINESIZE 2000;
SELECT * FROM article WHERE price = (SELECT MAX (price) FROM article) OR price IN (SELECT MIN (price) FROM article);