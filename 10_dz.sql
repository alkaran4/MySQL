-- 1


CREATE TABLE logs(
	table_name VARCHAR(255),
	first_id INT,
	name VARCHAR(255),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=ARCHIVE;

DELIMITER //
CREATE TRIGGER log_after_insert_users AFTER INSERT ON users
		FOR EACH ROW BEGIN
			INSERT INTO logs(table_name, first_id, name) VALUES('users', NEW.id, NEW.firstname);
		END //

CREATE TRIGGER log_after_insert_catalogs AFTER INSERT ON catalogs
		FOR EACH ROW BEGIN
			INSERT INTO logs(table_name, first_id, name) VALUES('catalogs', NEW.id, NEW.name);
		END //
		
CREATE TRIGGER log_after_insert_products AFTER INSERT ON products
		FOR EACH ROW BEGIN
			INSERT INTO logs(table_name, first_id, name) VALUES('products', NEW.id, NEW.name);
		END //
		
		
INSERT INTO shop.users
(firstname, birthday)
VALUES('Сергей', '1985-12-06');

INSERT INTO shop.catalogs
(name)
VALUES
('блок питания'),
('жесткий диск');

INSERT INTO shop.products
(name, desription, price, catalog_id)
VALUES('asus', 'USB 3, WI-FI', 15000, 1);


SELECT * FROM logs


-- 2

CREATE TABLE samples(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

INSERT INTO shop.samples
(name, birthday, created_at, updated_at)
VALUES
('Аркадий', '1990-12-24', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Михаил', '2000-04-15', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Мария', '1965-11-18', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Петр', '2004-06-29', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Арина', '1989-01-01', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Александра', '1978-09-19', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Валерий', '2001-03-24', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Егор', '1997-01-02', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Максим', '1987-09-07', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Артем', '1999-07-18', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
;

SELECT * FROM samples AS fst, samples AS snd, samples AS trd, samples AS fth, samples AS fif, samples AS sth;