-- 1 Найти в базе даных водителей, которые просрочили оплату штрафа (дата выписывания штрафа 70 дней назад и ранее)

SELECT man_id, fine_from FROM gibdd.fine WHERE (SELECT datediff(now(), fine_from)) > 70;

-- 2 Вывести водителей с наибольшим количеством штрафов

SELECT man_id, count(*) FROM gibdd.fine GROUP BY man_id ORDER BY count(*) DESC

-- 3 Найти людей, у которых есть автомобиль, но нет водительского удостоверения

SELECT m.id man, c.id car, c.brand, c.model FROM man m 
JOIN car c ON m.id=c.owner_id WHERE m.type_of_license = '' -- здесь проблема в инсерте у генератора, который вместо null всавляет ''. При заполнении вручную такой проблемы не будет

-- 4 Испекторам поставлена задача найти все автомобили, находящиеся в ориентировке. Необходимо вывести все данные об этих машинах и адреса их владельцев

SELECT c.brand, c.model, c.`number`, c.color, a.town, a.street, a.house FROM car c 
JOIN man m ON m.id = c.owner_id
JOIN address a ON m.address_id=a.id 
WHERE c.car_in_orientation = 'YES'

-- 5 создать представление, которое будет показывать штрафы и информацию о людях, которым их выписали, зафиксированные визульно испектором (отсутсвует фотофиксация нарушения)


CREATE VIEW police_eye AS 
SELECT f.id, m.firstname, m.lastname, m.birthday, m.type_of_license FROM fine f 
JOIN man m ON m.id=f.man_id WHERE ISNULL(f.photo_id) 

SELECT * FROM police_eye 

-- 6 создать предстваление, которое позволит проверить автомобиль на наличие актуальнго страхового полиса ОСАГО

DROP VIEW IF EXISTS osago_info;
CREATE VIEW osago_info AS 
SELECT c.brand, c.model, c.`number`, o.validity_period FROM car c LEFT JOIN osago o ON c.id=o.car_id 
WHERE (o.car_id IS NULL OR o.validity_period < CURRENT_DATE() ())

SELECT * FROM osago_info WHERE `number` = 'w740mn891' -- таким образом, если авто с введеным номером есть в представлении, значит у вато нет полиса осаго

-- 7 написать процедуру, которая сможет проверять авто по номеру и выписывать штрафы их владельцам, если полис осаго отсутствует или просрочен

delimiter //
DROP PROCEDURE IF EXISTS create_fine //
CREATE PROCEDURE create_fine(`num` VARCHAR(50))
BEGIN 
	SET @x= `num`;
	IF EXISTS (SELECT * FROM osago_info WHERE `number` = @x)
		THEN INSERT INTO gibdd.fine (man_id, fine_from, type_of_fine_id)
		SELECT c.owner_id, CURRENT_TIMESTAMP(), '15' FROM car c WHERE c.`number` = @x;
		SELECT 'штраф выписан' AS message;
	ELSEIF NOT EXISTS (SELECT c.`number` FROM car c WHERE c.`number` = @x) 
		THEN SELECT 'автомобиль с таким номером не сущетсвует' AS message;
	ELSE SELECT 'автомобиль застрахован' AS message;
	END IF;
END //

CALL create_fine('w740mn891')
CALL create_fine('c771sr893')
CALL create_fine('c771sr800')
