DROP DATABASE IF EXISTS GIBDD;
CREATE DATABASE GIBDD;

USE GIBDD;


DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`(
	id SERIAL PRIMARY KEY,
	region varchar(50),
	town varchar(50),
	district varchar(50),
	street varchar(50),
	house varchar(50),
	flat int unsigned
);	

DROP TABLE IF EXISTS `photo`;
CREATE TABLE `photo`(
	id SERIAL PRIMARY KEY,
	type_of_photo ENUM('fine', 'man'), -- тип фото: фиксация нарушения или фото водителя'
	filename VARCHAR(255), -- имя фото в файловой системе
    `size` INT, -- размер фото
    created_at DATETIME -- дата фото
);


DROP TABLE IF EXISTS `man`;
CREATE TABLE `man`(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthday DATE,
    gender CHAR(1),
    license_from DATE,
    type_of_license SET('A', 'B', 'C', 'D', 'E', 'Отсутствуют'), -- категория прав
    photo_id BIGINT UNSIGNED, -- фото водителя
    address_id BIGINT UNSIGNED, -- адрес водителя/владельца автомобиля
	FOREIGN KEY (photo_id) REFERENCES photo(id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (address_id) REFERENCES address(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `type_of_fine`;
CREATE TABLE `type_of_fine`(
	id SERIAL PRIMARY KEY,
	type_fine VARCHAR(255), -- вид нарушения
	punishment VARCHAR(255) -- наказание за нарушение
);

DROP TABLE IF EXISTS `fine`;
CREATE TABLE `fine`(
	id SERIAL PRIMARY KEY,
	man_id BIGINT UNSIGNED NOT NULL, -- ссылка на водителя, которому выписали штраф
	photo_id BIGINT UNSIGNED, -- фото штрафа
	fine_from DATE, -- дата штрафа
	address_id BIGINT UNSIGNED, -- место, где зафиксировано нарушение
	type_of_fine_id BIGINT UNSIGNED null, -- какой вид нарушения: непристегнутый ремень, проезд на красный и тд.
	FOREIGN KEY (man_id) REFERENCES man(id) ON UPDATE CASCADE ON DELETE CASCADE, 
	FOREIGN KEY (photo_id) REFERENCES photo(id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (address_id) REFERENCES address(id) ON UPDATE CASCADE ON DELETE SET NULL,
	FOREIGN KEY (type_of_fine_id) REFERENCES type_of_fine(id) ON UPDATE CASCADE ON DELETE CASCADE
);



DROP TABLE IF EXISTS `car`;
CREATE TABLE `car`(
	id SERIAL PRIMARY KEY,
	brand VARCHAR(50), -- производитель автомобиля
	model VARCHAR(50), -- модель автомобиля
	`number` CHAR(10) unique, -- номер автомобиля
	color VARCHAR(50), -- цвет автомобиля
	owner_id BIGINT UNSIGNED NOT null, -- владелец автомобиля 
	car_in_orientation ENUM('YES', 'NO'), -- является ли автомобиль в розыске, угоне и тд.
	FOREIGN KEY (owner_id) REFERENCES man(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS osago;
CREATE TABLE osago(
	id serial PRIMARY KEY,
	car_id BIGINT UNSIGNED NOT NULL,
	created_at DATE,
	validity_period DATE,
	insurance_agent varchar(50),
	FOREIGN KEY (car_id) REFERENCES car(id) ON UPDATE CASCADE ON DELETE CASCADE
);



INSERT INTO gibdd.type_of_fine
(type_fine, punishment)
VALUES
-- Данные могут не соответствовать действительности, взяты приблезительно для примера работы базы данных.
-- Предложены основные типы нарушений.
('Проезд на красный свет', '500 - 1000 руб'),
('Повтороный проезд на красный свет','Лишение прав от 6 до 12 месяцев'),
('Езда с непристегнутым ремнем безопасности','1000 рублей'),
('Езда с непристегнутым ремнем безопасности пассажира','1000 рублей'), 
('Отсутствие детского удерживающего кресла','3000'),
('Несоответсвие светопропускаемости пердних стекол автомобиля','1000 рублей'),
('Превышение допустимой скорсоти на 20-40 км/ч','500 рублей'),
('Превышение допустимой скорости на 40-60 км/ч','1000 рублей'),
('Превышение допцустимой скорости на 60-80 км/ч','5000 рублей или лишение прав на 6 месяцев'),
('Езда в наркотическом или алкогольном опьянении','Лишение прав на 1-2 года и штраф 30000 рублей'),
('Повтороная езда в наркотическом или алкогольном опьянении','Лишениена на 4 года'),
('Непредоставление преимущества пешеходу на нерегулируемом пешеходном переходе','3000 рублей'),
('Обгон в зоне дейстивия знака "Обгон запрещен"','лишение прав на срок 6-12 месяцев'),
('Пересечение двойной сплошной линии разметки','лишение прав на срок 6-12 месяцев'),
('Езда без полиса ОСАГА','500 рублей');


INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('1', 'man', 'ratione', 6, '2020-01-15 04:18:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('2', 'man', 'adipisci', 77558502, '1972-03-16 22:13:53');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('3', 'fine', 'sunt', 51268032, '1993-12-14 17:58:28');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('4', 'fine', 'dolor', 143, '1989-05-01 20:04:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('5', 'fine', 'iusto', 0, '1976-12-08 15:31:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('6', 'fine', 'ab', 99764416, '2021-02-25 16:27:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('7', 'man', 'minus', 1535201, '1985-10-04 22:07:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('8', 'fine', 'itaque', 20, '2004-04-04 03:00:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('9', 'fine', 'ut', 816, '1980-03-15 17:21:32');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('10', 'fine', 'recusandae', 83, '1978-01-19 22:03:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('11', 'fine', 'quae', 3797461, '1974-02-02 02:16:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('12', 'fine', 'ut', 746438221, '2000-09-03 03:02:38');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('13', 'man', 'occaecati', 585085, '1971-02-15 00:52:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('14', 'fine', 'ad', 98774952, '1994-05-12 16:29:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('15', 'fine', 'id', 0, '1982-09-13 02:06:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('16', 'fine', 'voluptatem', 496924, '1993-11-18 05:29:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('17', 'man', 'beatae', 2711, '2010-09-22 09:39:09');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('18', 'fine', 'architecto', 0, '2014-11-22 02:42:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('19', 'fine', 'ea', 71423681, '2016-12-31 01:04:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('20', 'man', 'odit', 545457, '1981-03-06 01:07:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('21', 'man', 'neque', 450, '1980-06-20 01:38:20');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('22', 'man', 'dignissimos', 637329581, '1972-02-10 23:28:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('23', 'man', 'dicta', 617531, '1978-04-24 22:44:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('24', 'fine', 'qui', 1537558, '1991-08-07 07:29:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('25', 'fine', 'sed', 56543, '2007-09-11 17:14:38');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('26', 'man', 'qui', 4, '1973-08-20 01:34:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('27', 'man', 'quia', 25083, '1970-09-28 18:54:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('28', 'man', 'deserunt', 845376, '1975-05-28 01:37:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('29', 'man', 'ut', 2665, '1985-10-06 07:08:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('30', 'man', 'quae', 45461, '1970-08-14 18:52:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('31', 'fine', 'et', 357802, '1988-11-20 13:28:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('32', 'fine', 'laborum', 4195, '1976-09-22 23:15:20');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('33', 'fine', 'libero', 5010548, '1997-03-05 03:32:16');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('34', 'fine', 'autem', 68, '1996-09-25 19:37:38');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('35', 'fine', 'optio', 59, '2008-10-07 15:09:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('36', 'man', 'enim', 190295882, '2004-11-16 21:14:20');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('37', 'fine', 'incidunt', 56793, '2018-04-07 23:47:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('38', 'man', 'enim', 537149104, '1974-12-29 04:28:52');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('39', 'fine', 'dignissimos', 18737451, '1983-05-30 19:32:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('40', 'fine', 'et', 0, '2010-12-16 19:33:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('41', 'man', 'fugit', 9115734, '2021-01-12 05:08:25');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('42', 'man', 'magnam', 264, '1983-01-07 13:02:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('43', 'fine', 'quo', 5859071, '1977-04-03 21:57:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('44', 'man', 'aut', 28, '1988-05-05 01:05:13');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('45', 'fine', 'ut', 999, '1973-01-23 15:40:17');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('46', 'man', 'occaecati', 11, '1992-09-17 03:33:34');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('47', 'fine', 'esse', 0, '2010-09-16 17:04:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('48', 'fine', 'officia', 289911085, '2008-11-16 17:50:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('49', 'fine', 'omnis', 4971, '1990-07-31 08:32:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('50', 'fine', 'beatae', 717555, '2005-09-06 01:24:59');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('51', 'fine', 'nam', 26318111, '2003-09-08 00:26:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('52', 'man', 'pariatur', 65637, '1991-04-18 07:57:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('53', 'man', 'unde', 19033138, '1991-03-08 18:18:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('54', 'man', 'autem', 59, '2010-03-27 15:25:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('55', 'fine', 'quia', 7295, '1977-11-24 01:20:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('56', 'man', 'similique', 33757426, '2020-11-23 07:48:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('57', 'fine', 'vitae', 77222, '1974-07-24 22:17:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('58', 'fine', 'modi', 0, '2003-03-13 21:19:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('59', 'man', 'odit', 67, '1999-07-04 17:48:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('60', 'man', 'accusamus', 7, '1997-12-28 05:12:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('61', 'fine', 'occaecati', 422781737, '1983-06-23 18:38:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('62', 'fine', 'deleniti', 0, '1992-11-01 23:25:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('63', 'man', 'enim', 85636, '1987-06-15 10:29:13');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('64', 'man', 'est', 90923, '2006-02-27 16:44:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('65', 'fine', 'quidem', 953, '1970-08-23 21:06:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('66', 'fine', 'odio', 649812549, '1998-07-06 14:59:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('67', 'fine', 'non', 0, '2016-08-20 07:09:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('68', 'fine', 'excepturi', 1, '1976-01-03 15:15:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('69', 'fine', 'itaque', 4852080, '1978-12-26 00:20:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('70', 'man', 'quia', 65177706, '1982-01-30 22:29:34');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('71', 'man', 'dignissimos', 176667230, '1987-03-04 02:25:52');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('72', 'fine', 'quo', 94, '2008-12-14 12:01:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('73', 'man', 'incidunt', 0, '2019-01-15 06:10:16');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('74', 'man', 'voluptas', 2, '2020-09-19 05:32:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('75', 'fine', 'aut', 6344887, '1972-07-20 09:51:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('76', 'man', 'consequatur', 982, '2009-04-27 17:53:27');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('77', 'fine', 'voluptatem', 34842, '2014-11-24 22:04:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('78', 'man', 'corporis', 6252980, '1971-11-07 12:03:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('79', 'fine', 'sunt', 83, '2004-09-18 10:54:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('80', 'man', 'et', 97354674, '1972-08-20 16:02:05');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('81', 'man', 'veniam', 9167, '2016-08-20 05:51:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('82', 'man', 'fugit', 59390988, '1999-05-26 13:50:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('83', 'fine', 'architecto', 930919314, '1972-11-28 02:58:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('84', 'fine', 'hic', 36218, '2003-04-12 01:22:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('85', 'man', 'molestiae', 803325861, '2019-03-03 16:27:19');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('86', 'fine', 'non', 8084857, '2005-09-16 21:41:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('87', 'fine', 'quasi', 767, '2019-03-18 13:40:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('88', 'man', 'deleniti', 2796940, '2007-03-30 05:19:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('89', 'man', 'cum', 0, '2004-03-09 10:09:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('90', 'man', 'vel', 3418143, '1992-09-11 02:58:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('91', 'man', 'fugiat', 5, '2010-05-27 07:52:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('92', 'fine', 'quia', 46, '1975-07-28 06:56:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('93', 'fine', 'saepe', 51950695, '1994-05-07 16:31:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('94', 'man', 'modi', 67, '1977-04-09 22:19:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('95', 'man', 'perspiciatis', 60, '1974-02-24 12:56:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('96', 'man', 'rem', 9, '1975-06-15 02:08:20');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('97', 'man', 'vitae', 7467, '1989-11-27 04:17:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('98', 'man', 'libero', 9025, '1984-12-16 10:40:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('99', 'man', 'voluptatibus', 5157553, '2009-07-26 04:16:13');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('100', 'man', 'pariatur', 120056, '1974-05-28 06:13:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('101', 'man', 'aut', 1919551, '2021-04-26 19:13:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('102', 'fine', 'deserunt', 5237, '1982-04-02 22:54:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('103', 'man', 'autem', 21965, '1978-06-01 13:11:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('104', 'fine', 'veniam', 99, '1999-06-03 10:23:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('105', 'man', 'totam', 81927473, '1980-02-27 04:31:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('106', 'fine', 'tempora', 8, '1995-09-07 03:09:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('107', 'fine', 'qui', 4702359, '2002-08-23 17:17:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('108', 'fine', 'consequatur', 8, '1988-03-04 22:33:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('109', 'fine', 'earum', 1538, '1978-06-24 03:26:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('110', 'fine', 'nisi', 6, '1981-04-26 13:14:53');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('111', 'fine', 'vitae', 18382, '1993-07-11 01:20:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('112', 'man', 'enim', 92901665, '1974-02-19 10:28:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('113', 'fine', 'quia', 2588, '1998-05-11 01:20:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('114', 'man', 'consequatur', 63, '2008-09-16 07:24:11');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('115', 'man', 'porro', 0, '2014-10-21 05:48:50');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('116', 'fine', 'temporibus', 254327, '1991-12-07 06:22:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('117', 'fine', 'architecto', 464442802, '2018-05-31 01:05:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('118', 'man', 'voluptatem', 254678, '2008-03-20 20:09:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('119', 'fine', 'dolorem', 8, '1985-02-03 08:10:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('120', 'fine', 'quasi', 424, '1978-02-21 00:19:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('121', 'fine', 'non', 79742, '1987-09-22 17:51:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('122', 'man', 'voluptas', 72, '1981-06-06 00:59:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('123', 'fine', 'amet', 26, '1981-01-12 19:08:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('124', 'man', 'placeat', 691847, '2012-03-13 02:46:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('125', 'fine', 'quae', 32034, '2020-10-05 23:09:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('126', 'man', 'nam', 55, '2005-10-21 06:59:53');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('127', 'fine', 'voluptatem', 913, '2008-05-11 05:21:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('128', 'man', 'sint', 18, '2019-06-24 00:20:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('129', 'man', 'dignissimos', 761335, '2010-05-11 00:29:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('130', 'fine', 'accusamus', 2927680, '1972-04-21 07:35:28');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('131', 'man', 'vero', 959457, '1978-02-05 18:33:25');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('132', 'man', 'velit', 45, '1985-03-13 15:57:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('133', 'fine', 'atque', 0, '2000-10-01 05:39:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('134', 'man', 'sunt', 477199838, '2002-10-05 17:20:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('135', 'fine', 'enim', 704, '1973-01-15 06:45:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('136', 'man', 'autem', 61, '2008-11-12 04:34:02');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('137', 'fine', 'maiores', 26, '2006-08-13 22:08:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('138', 'man', 'maiores', 9770079, '2015-02-22 15:35:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('139', 'man', 'qui', 19463244, '1981-07-28 23:44:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('140', 'fine', 'ea', 707481876, '1996-07-07 08:58:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('141', 'man', 'sint', 345585270, '2000-04-26 17:22:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('142', 'fine', 'et', 58, '1980-08-17 08:37:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('143', 'fine', 'exercitationem', 98, '2007-06-05 23:20:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('144', 'man', 'voluptatem', 0, '2015-07-22 20:44:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('145', 'man', 'ut', 855677, '1971-10-30 10:45:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('146', 'fine', 'sunt', 605783, '2003-11-07 04:17:52');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('147', 'fine', 'maxime', 930950667, '2002-05-04 21:00:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('148', 'fine', 'ipsum', 0, '2013-12-26 00:21:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('149', 'fine', 'et', 859, '2012-04-13 19:14:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('150', 'fine', 'quia', 73, '1987-01-21 12:11:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('151', 'man', 'et', 73, '1987-07-20 00:04:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('152', 'fine', 'est', 713188, '2013-01-05 16:44:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('153', 'man', 'nisi', 8784, '1994-04-21 12:20:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('154', 'man', 'distinctio', 720984, '1975-03-18 00:22:27');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('155', 'man', 'quia', 17, '2003-08-09 06:28:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('156', 'man', 'ratione', 653, '2010-08-19 10:25:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('157', 'man', 'molestiae', 9700609, '1982-05-14 15:48:13');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('158', 'man', 'rem', 6, '1971-06-26 03:20:16');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('159', 'man', 'quis', 27, '2002-12-20 20:19:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('160', 'man', 'et', 608104, '1972-04-06 08:43:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('161', 'fine', 'culpa', 28260497, '1990-02-16 03:08:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('162', 'man', 'dolores', 510648, '1981-12-11 12:28:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('163', 'fine', 'asperiores', 379744, '2010-09-05 00:41:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('164', 'fine', 'ut', 5436, '2005-05-23 07:03:53');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('165', 'man', 'aut', 384951, '2000-04-11 04:59:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('166', 'man', 'ut', 42247713, '2009-01-26 02:36:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('167', 'fine', 'voluptas', 145, '2013-01-09 12:09:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('168', 'fine', 'eaque', 751679882, '1973-03-03 15:38:25');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('169', 'fine', 'nisi', 86162, '1988-06-12 17:34:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('170', 'fine', 'eveniet', 6, '1978-04-12 18:02:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('171', 'fine', 'numquam', 569467558, '2009-05-11 21:30:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('172', 'fine', 'dolor', 9737635, '1989-06-18 11:34:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('173', 'fine', 'molestiae', 469021496, '1989-05-28 06:17:19');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('174', 'fine', 'a', 40908555, '2017-10-16 07:36:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('175', 'man', 'aut', 54683697, '1979-06-09 16:34:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('176', 'man', 'veniam', 66961898, '1981-05-02 22:12:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('177', 'man', 'aut', 7060851, '2008-08-02 21:42:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('178', 'man', 'perferendis', 0, '2017-11-13 08:07:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('179', 'fine', 'maiores', 43973, '1986-05-16 04:24:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('180', 'man', 'sed', 45142747, '1986-06-02 02:06:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('181', 'fine', 'odit', 926168, '1993-08-28 06:44:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('182', 'fine', 'consequatur', 7, '2014-07-11 19:10:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('183', 'man', 'vel', 78000931, '1992-02-27 19:15:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('184', 'man', 'aliquid', 63634, '1998-12-17 22:43:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('185', 'man', 'ex', 250254855, '1989-10-22 20:38:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('186', 'man', 'explicabo', 88, '1987-08-27 17:30:19');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('187', 'fine', 'perspiciatis', 51641101, '2006-05-18 22:10:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('188', 'fine', 'expedita', 288072569, '1970-12-01 11:19:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('189', 'man', 'error', 622167, '1975-06-07 17:47:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('190', 'fine', 'vel', 455753680, '1997-11-22 22:12:20');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('191', 'man', 'quod', 0, '1971-05-25 18:48:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('192', 'fine', 'praesentium', 9570, '1997-07-17 03:41:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('193', 'fine', 'qui', 0, '2015-12-23 20:58:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('194', 'man', 'eum', 0, '1999-05-18 08:40:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('195', 'man', 'sunt', 43, '2007-02-11 22:25:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('196', 'man', 'et', 79945507, '2008-04-02 13:26:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('197', 'fine', 'totam', 52, '2004-09-05 22:37:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('198', 'man', 'ipsam', 2, '2014-03-08 00:39:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('199', 'man', 'temporibus', 27, '2020-12-31 20:11:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('200', 'fine', 'modi', 0, '2011-12-15 20:44:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('201', 'man', 'quibusdam', 41861, '1991-03-05 10:56:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('202', 'man', 'quo', 76, '1983-05-16 23:22:11');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('203', 'fine', 'repellat', 9, '1995-04-13 18:10:32');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('204', 'fine', 'ut', 4, '2007-04-24 00:45:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('205', 'man', 'consequatur', 6, '1997-02-17 02:33:26');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('206', 'fine', 'animi', 2448, '2005-05-01 05:00:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('207', 'fine', 'enim', 475768, '2021-11-01 14:55:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('208', 'man', 'accusamus', 29731, '2002-06-09 01:08:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('209', 'fine', 'et', 3101, '2014-06-24 20:33:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('210', 'man', 'iusto', 767757713, '1992-05-16 10:57:22');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('211', 'fine', 'aut', 77187, '2006-03-02 13:00:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('212', 'fine', 'quod', 3646782, '1972-07-24 22:48:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('213', 'man', 'id', 8744, '1992-04-21 00:22:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('214', 'fine', 'exercitationem', 68783, '1986-10-04 13:41:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('215', 'man', 'veritatis', 30056229, '2004-02-13 22:11:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('216', 'man', 'in', 172, '1991-10-10 03:18:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('217', 'fine', 'ad', 139, '1987-05-27 09:11:09');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('218', 'man', 'eligendi', 2188, '1970-03-29 09:17:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('219', 'fine', 'omnis', 32, '2008-04-05 09:54:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('220', 'fine', 'aut', 82499323, '2014-05-07 12:10:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('221', 'fine', 'in', 470, '1983-04-06 04:50:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('222', 'fine', 'asperiores', 407424444, '2009-05-04 07:56:58');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('223', 'man', 'aut', 2, '1971-03-14 02:48:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('224', 'man', 'molestiae', 338925, '1979-04-28 04:04:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('225', 'fine', 'quis', 832, '2000-06-10 13:30:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('226', 'man', 'reiciendis', 298972056, '2002-12-26 11:48:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('227', 'fine', 'sit', 2, '1996-05-31 20:33:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('228', 'man', 'eos', 284974381, '1984-06-01 09:55:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('229', 'man', 'placeat', 913524408, '2013-09-14 18:01:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('230', 'man', 'et', 147, '1999-08-23 13:06:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('231', 'man', 'accusantium', 484652, '1999-07-09 19:06:59');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('232', 'fine', 'dolores', 686, '1974-08-06 13:30:34');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('233', 'man', 'pariatur', 0, '1983-09-13 15:57:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('234', 'man', 'qui', 54872, '2019-12-13 18:00:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('235', 'man', 'vitae', 8968, '1978-06-24 18:38:19');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('236', 'man', 'sit', 0, '2009-04-17 05:56:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('237', 'man', 'officiis', 74064, '2002-10-21 20:34:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('238', 'man', 'in', 10877, '1979-12-09 19:12:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('239', 'man', 'architecto', 59, '2019-11-30 19:52:16');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('240', 'man', 'ipsum', 327815, '1980-06-16 03:55:22');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('241', 'fine', 'praesentium', 980124122, '2006-05-01 11:42:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('242', 'man', 'iste', 32960032, '1970-01-10 23:52:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('243', 'man', 'voluptatem', 48935, '2006-01-06 13:18:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('244', 'fine', 'dignissimos', 6, '1997-11-18 04:01:32');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('245', 'fine', 'eligendi', 943, '1975-12-18 12:22:30');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('246', 'man', 'fuga', 93, '1989-05-22 23:55:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('247', 'man', 'nesciunt', 63, '1990-02-20 13:48:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('248', 'man', 'at', 9422601, '2001-07-18 22:56:16');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('249', 'fine', 'earum', 798332511, '1974-11-05 16:54:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('250', 'man', 'qui', 82294, '1971-02-21 11:34:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('251', 'fine', 'libero', 31, '2011-05-23 02:47:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('252', 'fine', 'quia', 92, '1994-05-14 21:00:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('253', 'man', 'vero', 8, '2013-01-14 11:29:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('254', 'man', 'et', 52748, '1979-12-31 10:00:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('255', 'man', 'ex', 0, '1981-12-26 22:15:13');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('256', 'fine', 'odit', 8, '2001-12-16 20:43:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('257', 'fine', 'voluptatibus', 38, '2003-04-27 15:34:25');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('258', 'man', 'sequi', 8, '1970-11-15 07:57:32');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('259', 'fine', 'rerum', 74, '2002-01-06 06:13:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('260', 'fine', 'culpa', 984491, '1976-06-04 02:51:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('261', 'fine', 'cum', 830, '1991-05-13 18:17:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('262', 'fine', 'odio', 0, '1974-04-17 21:52:30');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('263', 'man', 'molestiae', 66937191, '2011-11-07 03:57:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('264', 'man', 'et', 106234321, '2015-06-28 00:34:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('265', 'fine', 'ut', 4, '2000-03-24 12:54:05');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('266', 'man', 'ex', 18135718, '1998-07-30 11:29:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('267', 'fine', 'quasi', 85, '2012-04-26 16:09:02');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('268', 'man', 'et', 600091, '1982-05-27 17:13:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('269', 'fine', 'ut', 562890580, '2017-09-27 11:48:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('270', 'fine', 'aperiam', 573121746, '1997-06-29 15:14:49');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('271', 'fine', 'ex', 132, '1979-07-19 14:29:48');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('272', 'fine', 'officiis', 188466207, '1979-12-13 16:07:31');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('273', 'fine', 'officiis', 0, '2017-12-30 02:43:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('274', 'man', 'quibusdam', 6026, '1995-08-12 13:47:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('275', 'fine', 'quod', 60470, '1991-02-03 21:22:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('276', 'fine', 'ea', 526, '1979-03-02 23:32:28');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('277', 'fine', 'maiores', 52, '1983-07-10 17:03:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('278', 'fine', 'nostrum', 33090738, '2004-11-02 21:44:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('279', 'man', 'quo', 71955563, '2006-09-06 17:24:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('280', 'man', 'occaecati', 933, '1995-06-06 12:52:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('281', 'fine', 'ut', 88867, '1987-06-11 05:45:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('282', 'fine', 'sed', 2, '1987-04-02 07:21:59');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('283', 'man', 'unde', 349601, '1977-08-22 04:52:45');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('284', 'fine', 'error', 887715257, '2015-01-17 15:15:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('285', 'fine', 'nemo', 7231444, '1986-05-06 10:21:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('286', 'fine', 'deleniti', 510138, '1999-06-02 21:57:02');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('287', 'man', 'sit', 738, '2015-02-02 02:58:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('288', 'man', 'architecto', 3, '1986-01-12 16:47:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('289', 'fine', 'consequatur', 5, '1987-08-06 00:59:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('290', 'fine', 'repellat', 79562983, '2021-10-18 17:53:17');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('291', 'man', 'quasi', 20851562, '1972-08-24 23:06:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('292', 'fine', 'consequatur', 84516330, '2018-09-12 22:27:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('293', 'fine', 'et', 0, '2016-05-20 14:54:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('294', 'man', 'autem', 4702979, '2003-12-02 22:06:52');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('295', 'fine', 'harum', 274938586, '2008-01-17 01:33:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('296', 'man', 'molestiae', 7, '1973-07-16 10:33:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('297', 'man', 'et', 0, '1983-01-14 10:28:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('298', 'fine', 'temporibus', 116280, '2003-05-27 09:35:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('299', 'fine', 'facilis', 35636, '1977-11-28 00:03:23');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('300', 'fine', 'ipsa', 7942050, '1974-06-19 03:17:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('301', 'fine', 'culpa', 0, '2012-05-22 09:12:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('302', 'fine', 'qui', 538245, '1985-05-30 01:47:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('303', 'man', 'quam', 97322, '1982-11-13 16:50:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('304', 'fine', 'sit', 141586763, '2018-06-23 23:58:35');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('305', 'man', 'eos', 629725855, '2017-05-24 03:47:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('306', 'fine', 'vel', 49408029, '1983-12-02 09:55:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('307', 'fine', 'dolorem', 71299142, '1970-02-11 07:44:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('308', 'fine', 'quo', 8534229, '2015-03-30 22:03:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('309', 'fine', 'odio', 94792, '1999-02-26 15:19:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('310', 'fine', 'est', 76, '2020-04-27 04:53:34');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('311', 'man', 'corporis', 74, '2005-02-20 09:05:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('312', 'man', 'deleniti', 5, '1975-11-28 10:29:58');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('313', 'man', 'veniam', 642221, '2000-03-28 00:36:47');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('314', 'man', 'magni', 199, '1997-08-17 19:46:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('315', 'man', 'et', 685, '1979-06-30 01:39:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('316', 'fine', 'consequuntur', 8915, '1970-07-01 03:42:28');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('317', 'man', 'distinctio', 24324395, '1979-01-14 04:41:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('318', 'man', 'eum', 321246, '1999-04-12 04:10:50');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('319', 'man', 'quod', 9150, '2018-08-09 21:43:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('320', 'fine', 'impedit', 0, '1990-01-04 17:47:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('321', 'man', 'omnis', 28726, '1978-01-05 22:19:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('322', 'man', 'accusamus', 308, '1984-05-18 05:54:59');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('323', 'man', 'inventore', 70, '1987-11-15 15:53:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('324', 'fine', 'ex', 444, '1970-07-03 04:45:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('325', 'fine', 'excepturi', 84050, '1980-12-24 03:50:06');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('326', 'fine', 'optio', 994214, '2015-12-07 03:39:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('327', 'fine', 'aliquam', 40700, '1995-01-13 07:07:17');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('328', 'fine', 'dolor', 2, '1970-06-08 18:10:50');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('329', 'man', 'ut', 10337, '1987-06-19 06:51:37');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('330', 'fine', 'saepe', 0, '1994-07-09 20:10:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('331', 'fine', 'officiis', 80545936, '1979-03-25 03:52:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('332', 'fine', 'sit', 2549579, '2008-02-16 07:25:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('333', 'fine', 'voluptatem', 728454980, '2021-03-16 09:49:41');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('334', 'fine', 'voluptatem', 4579, '2015-11-22 12:21:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('335', 'fine', 'dolorem', 95, '2010-08-14 03:31:43');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('336', 'fine', 'quae', 486, '1981-08-29 11:21:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('337', 'fine', 'dolores', 11246, '1975-11-24 08:31:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('338', 'man', 'sunt', 94, '1977-06-05 06:24:02');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('339', 'fine', 'ipsum', 0, '2002-02-07 18:23:22');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('340', 'fine', 'et', 43583985, '1985-09-29 03:53:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('341', 'fine', 'commodi', 84, '2006-11-11 00:39:36');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('342', 'fine', 'et', 70749739, '1997-10-12 03:58:40');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('343', 'man', 'et', 9861461, '1982-04-29 03:13:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('344', 'fine', 'possimus', 26468, '1978-02-12 15:25:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('345', 'man', 'voluptatibus', 42433, '2013-11-20 19:42:44');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('346', 'man', 'dolor', 6815, '1981-02-11 02:32:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('347', 'man', 'voluptas', 0, '2005-04-16 13:07:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('348', 'man', 'non', 8804212, '1973-04-15 18:19:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('349', 'man', 'enim', 15, '2010-05-05 23:35:08');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('350', 'man', 'autem', 82513, '1993-06-03 08:07:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('351', 'fine', 'architecto', 2288, '1989-06-18 06:59:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('352', 'man', 'qui', 829815, '1970-06-25 02:03:30');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('353', 'fine', 'sunt', 586344, '2007-10-10 12:42:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('354', 'man', 'qui', 3246577, '1992-08-18 22:42:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('355', 'man', 'iusto', 70143, '1981-09-10 17:35:34');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('356', 'fine', 'voluptatum', 163, '1979-09-22 09:35:27');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('357', 'fine', 'id', 6338011, '1992-07-31 06:19:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('358', 'fine', 'cumque', 4980134, '1979-04-11 21:52:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('359', 'fine', 'ipsam', 770, '1973-12-18 04:38:58');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('360', 'man', 'qui', 763, '1980-04-23 19:45:11');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('361', 'man', 'impedit', 84931, '2002-12-01 10:06:19');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('362', 'fine', 'dolore', 36853633, '2009-12-10 19:22:18');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('363', 'man', 'et', 9, '1972-07-14 03:28:17');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('364', 'man', 'non', 960308287, '2001-10-02 04:13:07');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('365', 'man', 'sit', 1193, '1971-05-27 16:57:42');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('366', 'fine', 'numquam', 337166, '2011-10-12 08:09:21');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('367', 'fine', 'repellendus', 8388795, '1995-09-16 13:26:29');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('368', 'man', 'non', 61, '1971-03-20 09:58:54');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('369', 'fine', 'aliquam', 187065, '1989-07-12 05:04:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('370', 'fine', 'tempora', 37217571, '1989-06-25 11:49:32');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('371', 'fine', 'non', 1, '1988-12-04 22:21:57');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('372', 'fine', 'dolorem', 0, '2013-02-14 18:38:14');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('373', 'man', 'repellendus', 35, '1970-01-23 03:38:05');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('374', 'fine', 'id', 346954, '1975-03-12 03:37:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('375', 'man', 'quia', 4266, '1978-01-26 13:24:24');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('376', 'man', 'nemo', 8686022, '1975-07-05 22:29:56');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('377', 'man', 'sit', 423, '1983-09-20 01:52:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('378', 'fine', 'ipsa', 8086941, '1990-06-07 21:43:33');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('379', 'fine', 'vitae', 58, '1982-07-04 08:24:15');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('380', 'man', 'corporis', 0, '1984-06-11 14:31:01');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('381', 'man', 'similique', 6, '1999-10-14 20:03:00');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('382', 'man', 'rerum', 2738592, '1984-05-03 09:40:53');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('383', 'man', 'aliquam', 408, '2016-12-25 18:49:27');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('384', 'man', 'excepturi', 122262123, '1985-09-16 19:39:11');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('385', 'fine', 'consectetur', 781, '2000-08-10 05:43:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('386', 'man', 'quo', 0, '2020-12-08 06:49:10');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('387', 'fine', 'dolor', 0, '1970-10-11 13:32:12');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('388', 'man', 'accusamus', 455534705, '2007-10-16 16:57:27');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('389', 'fine', 'aut', 0, '1995-12-13 11:05:04');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('390', 'man', 'aut', 2691116, '2011-03-23 16:53:55');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('391', 'man', 'dolores', 14132, '1984-02-21 22:27:51');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('392', 'man', 'quo', 4468, '1982-05-18 09:34:02');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('393', 'man', 'eos', 2, '1988-06-21 18:30:39');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('394', 'man', 'odio', 61, '2011-11-07 04:50:50');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('395', 'fine', 'voluptatibus', 620, '1996-06-05 01:35:46');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('396', 'fine', 'molestias', 6794, '1972-11-12 22:01:22');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('397', 'man', 'saepe', 16794, '1980-01-07 13:16:38');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('398', 'man', 'voluptate', 0, '2006-07-30 22:16:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('399', 'fine', 'veritatis', 49311417, '1982-07-30 17:04:03');
INSERT INTO `photo` (`id`, `type_of_photo`, `filename`, `size`, `created_at`) VALUES ('400', 'fine', 'a', 30961226, '2005-07-03 02:18:22');

INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('1', 'Massachusetts', 'Port Maximo', NULL, 'Foster Club', '221', 37648911);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('2', 'Utah', 'Westfort', NULL, 'Lemke Neck', '112', 600546);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('3', 'Oklahoma', 'Lake Katharinafort', NULL, 'Greenholt Trafficway', '131', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('4', 'Virginia', 'Manuelhaven', NULL, 'Cora Summit', '218', 2);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('5', 'NewYork', 'Wunschbury', NULL, 'Bauch Haven', '196', 3);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('6', 'Oregon', 'East Herminiatown', NULL, 'Ritchie Estate', '55', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('7', 'NewMexico', 'Kamrenport', NULL, 'Christop Squares', '225', 737047);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('8', 'SouthCarolina', 'Port Dillan', NULL, 'Littel Lane', '85', 1200);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('9', 'Hawaii', 'Port Waldo', NULL, 'Myrtie Plaza', '168', 36);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('10', 'Michigan', 'Port Augustineburgh', NULL, 'Hamill Brook', '154', 41527);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('11', 'Iowa', 'New Hassie', NULL, 'Bradtke Rest', '176', 2408246);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('12', 'Connecticut', 'Trantowport', NULL, 'Morissette Mountains', '256', 442545);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('13', 'NorthDakota', 'Torpview', NULL, 'Wisoky Lodge', '55', 4);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('14', 'Kansas', 'Goyettemouth', NULL, 'Crist Stream', '214', 25);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('15', 'Utah', 'Pacochafurt', NULL, 'Wuckert Centers', '168', 6);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('16', 'Missouri', 'Carloton', NULL, 'Mohr Falls', '279', 260797462);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('17', 'Delaware', 'Catharinefurt', NULL, 'Alysha Manors', '176', 1275663);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('18', 'Montana', 'West Maye', NULL, 'Tillman Mill', '180', 368217);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('19', 'Nebraska', 'New Helena', NULL, 'Lindsay Turnpike', '235', 109955004);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('20', 'Indiana', 'Elwynside', NULL, 'Mertie Manor', '270', 334201860);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('21', 'Florida', 'Port Terrance', NULL, 'Rhett Path', '167', 3);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('22', 'Alaska', 'Feliciaborough', NULL, 'Cale Place', '292', 3599);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('23', 'Massachusetts', 'Wilmamouth', NULL, 'Jeramy Avenue', '214', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('24', 'Wyoming', 'Lake Wellington', NULL, 'Walker Plain', '57', 351673);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('25', 'California', 'North Tavareshaven', NULL, 'Brandon Harbors', '67', 189593);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('26', 'Vermont', 'Casperton', NULL, 'Durgan Mission', '108', 8997);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('27', 'Delaware', 'Uriahburgh', NULL, 'Carter Bypass', '177', 703623);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('28', 'Alabama', 'East Whitneyton', NULL, 'Esta Street', '224', 4642);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('29', 'Utah', 'Rhodaville', NULL, 'Rutherford Plaza', '225', 344);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('30', 'NorthCarolina', 'New Bradford', NULL, 'Medhurst Estate', '6', 3661710);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('31', 'Delaware', 'Mosciskitown', NULL, 'Kshlerin Lights', '165', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('32', 'NorthDakota', 'Chayaberg', NULL, 'Bernhard Junction', '132', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('33', 'Massachusetts', 'West Jaylen', NULL, 'Pouros Dale', '10', 1934569);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('34', 'NorthDakota', 'North Jazmyn', NULL, 'Elinore Roads', '182', 3284);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('35', 'Utah', 'East Maymie', NULL, 'Yazmin Knoll', '178', 8);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('36', 'NewHampshire', 'Rozellashire', NULL, 'Pascale Wall', '166', 91210);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('37', 'Illinois', 'East Arne', NULL, 'Katelin Hills', '11', 73);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('38', 'Wyoming', 'West Ceciliamouth', NULL, 'Keebler Causeway', '258', 2);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('39', 'Massachusetts', 'Lonieland', NULL, 'Jerde Underpass', '275', 12);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('40', 'Tennessee', 'Glovermouth', NULL, 'McGlynn Trail', '121', 828055);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('41', 'NewHampshire', 'Tristinchester', NULL, 'Treutel Forest', '192', 105);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('42', 'Arizona', 'New Angus', NULL, 'Violet Way', '276', 1706499);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('43', 'Delaware', 'South Ruben', NULL, 'Brian Green', '189', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('44', 'Oklahoma', 'West Camryn', NULL, 'Pollich Tunnel', '40', 6);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('45', 'Massachusetts', 'Cassandrafurt', NULL, 'Lilly Ports', '262', 109660);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('46', 'Wisconsin', 'North Aliciafort', NULL, 'Bartholome Inlet', '254', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('47', 'NewMexico', 'Jeffreyside', NULL, 'Hane Courts', '120', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('48', 'RhodeIsland', 'New Pearl', NULL, 'Stevie Shoals', '129', 2527);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('49', 'Florida', 'Okunevamouth', NULL, 'Yost Burgs', '38', 1709);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('50', 'Louisiana', 'Port Guiseppefort', NULL, 'Crona Hills', '23', 17515);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('51', 'NewYork', 'South Todton', NULL, 'Pedro Bypass', '152', 25964);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('52', 'Vermont', 'West Garland', NULL, 'Borer Mission', '228', 22763073);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('53', 'Vermont', 'Walkerfurt', NULL, 'Stehr Key', '240', 26);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('54', 'Nevada', 'Lake Shanelle', NULL, 'Rebeka Road', '232', 4038);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('55', 'SouthCarolina', 'West Eryn', NULL, 'Murphy Coves', '117', 12);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('56', 'Kansas', 'Heidenreichchester', NULL, 'Turner Forge', '173', 47);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('57', 'RhodeIsland', 'Port Cody', NULL, 'Mayra Mountain', '293', 407895);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('58', 'Ohio', 'East Susie', NULL, 'Beatrice Islands', '190', 10239534);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('59', 'Utah', 'Antoinettemouth', NULL, 'Brianne Burg', '86', 33972872);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('60', 'Massachusetts', 'Kohlerside', NULL, 'Cristian Flat', '73', 12);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('61', 'Washington', 'Christopberg', NULL, 'Tara Squares', '80', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('62', 'NewHampshire', 'McDermottborough', NULL, 'Vandervort Mews', '72', 6);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('63', 'Alabama', 'Lake Bart', NULL, 'Terrance Freeway', '290', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('64', 'Tennessee', 'South Jennifer', NULL, 'Walker Divide', '235', 339447157);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('65', 'Indiana', 'Gutmannside', NULL, 'Sherman Vista', '120', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('66', 'RhodeIsland', 'Rosenbaumbury', NULL, 'Filomena Corners', '174', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('67', 'SouthDakota', 'North Mackenzieville', NULL, 'Suzanne Extension', '233', 8);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('68', 'WestVirginia', 'East Rosalindaborough', NULL, 'Green Ports', '72', 2);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('69', 'Alabama', 'Reichelhaven', NULL, 'Fisher Parkways', '162', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('70', 'Georgia', 'Karineburgh', NULL, 'Kassandra Crescent', '77', 2182041);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('71', 'Montana', 'Noemymouth', NULL, 'Yadira Forks', '258', 2081);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('72', 'Arkansas', 'Halieport', NULL, 'Natasha Junctions', '219', 65309);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('73', 'Virginia', 'Port Madie', NULL, 'Deborah Plains', '261', 981);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('74', 'Delaware', 'Emersonton', NULL, 'Wiza Causeway', '5', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('75', 'Montana', 'New Autumnberg', NULL, 'Godfrey Lodge', '292', 57);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('76', 'NewJersey', 'Eleazarberg', NULL, 'Orlo Orchard', '236', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('77', 'Michigan', 'Lake Doug', NULL, 'Faustino Stream', '60', 23405);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('78', 'Pennsylvania', 'West Jeanie', NULL, 'Carmen Meadows', '72', 2);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('79', 'Maine', 'South Fae', NULL, 'Murray Fields', '177', 1);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('80', 'California', 'New Adrianfort', NULL, 'Elbert Highway', '214', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('81', 'Virginia', 'South Ignacio', NULL, 'Quitzon Grove', '127', 394);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('82', 'Alabama', 'Myriambury', NULL, 'Alda Squares', '81', 67488);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('83', 'SouthDakota', 'West Hudson', NULL, 'Timmothy Spring', '296', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('84', 'Vermont', 'North Jalyn', NULL, 'Velva Corner', '198', 2);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('85', 'Maryland', 'Schummberg', NULL, 'Ferry Rapids', '92', 39);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('86', 'Louisiana', 'Harberville', NULL, 'Gorczany Center', '118', 3891376);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('87', 'Texas', 'Yundtchester', NULL, 'Vivienne Keys', '31', 52209);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('88', 'RhodeIsland', 'Amiebury', NULL, 'Sylvan Village', '155', 94873);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('89', 'Delaware', 'West Alvinabury', NULL, 'Madaline Squares', '230', 327343);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('90', 'Nevada', 'Port Kadenburgh', NULL, 'Pacocha Junction', '239', 177);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('91', 'Nevada', 'Erikatown', NULL, 'Abraham Road', '33', 47889650);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('92', 'Connecticut', 'Waltermouth', NULL, 'Koch Locks', '169', 8);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('93', 'Wisconsin', 'East Marcville', NULL, 'Ruby Ford', '173', 160);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('94', 'Maryland', 'Marshallbury', NULL, 'Ledner Bridge', '20', 6);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('95', 'Texas', 'South Kiannaside', NULL, 'Emma Run', '218', 11665550);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('96', 'Arizona', 'East Kenya', NULL, 'Bauch Well', '64', 749);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('97', 'Alabama', 'Earnestineland', NULL, 'Ima Gateway', '189', 0);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('98', 'Ohio', 'Einoberg', NULL, 'Jannie Flat', '221', 1174281);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('99', 'Missouri', 'Paigeton', NULL, 'Tyrique Creek', '176', 6158);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('100', 'Maine', 'Daronhaven', NULL, 'Kyler Common', '216', 14279710);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('101', 'Idaho', 'Kyraside', NULL, 'Langworth Field', '004', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('102', 'Utah', 'South Trent', NULL, 'Tremblay Grove', '4699', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('103', 'NewHampshire', 'North Gayle', NULL, 'Abelardo Island', '13229', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('104', 'RhodeIsland', 'O\'Reillyfurt', NULL, 'Mohamed Summit', '223', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('105', 'Texas', 'North Stefanhaven', NULL, 'Lillian Ranch', '0444', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('106', 'Washington', 'Haleytown', NULL, 'Rhiannon Road', '61650', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('107', 'Pennsylvania', 'Amiyabury', NULL, 'Norene Estates', '6372', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('108', 'Georgia', 'Langoshbury', NULL, 'Hilll Garden', '433', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('109', 'Washington', 'Port Dannie', NULL, 'Bailey Grove', '7678', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('110', 'Mississippi', 'Schneidershire', NULL, 'Stokes Branch', '157', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('111', 'Maine', 'South Andre', NULL, 'Greenholt Drive', '12388', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('112', 'Arizona', 'O\'Keefeview', NULL, 'Kuhlman Pines', '7101', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('113', 'Minnesota', 'East Antonialand', NULL, 'Feest Stream', '9791', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('114', 'Iowa', 'Port Feliciaport', NULL, 'Turcotte Greens', '79244', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('115', 'Georgia', 'Predovicview', NULL, 'Boehm Route', '753', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('116', 'Wyoming', 'Mosciskiborough', NULL, 'Aleen Ford', '49362', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('117', 'Pennsylvania', 'Nolamouth', NULL, 'Kellie Common', '872', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('118', 'Mississippi', 'New Carolina', NULL, 'Rigoberto Stravenue', '302', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('119', 'Alaska', 'Lake Luciennemouth', NULL, 'Morar Bridge', '8383', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('120', 'NewHampshire', 'New Glenshire', NULL, 'Green Rapid', '530', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('121', 'Maine', 'Alyciaborough', NULL, 'Halvorson Glens', '3537', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('122', 'Hawaii', 'South Tia', NULL, 'Otho Corners', '1330', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('123', 'Wisconsin', 'West Ramonamouth', NULL, 'Bonnie Alley', '779', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('124', 'Wyoming', 'Albertaville', NULL, 'O\'Hara Terrace', '6908', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('125', 'Florida', 'Theresiaport', NULL, 'Felipe Mountain', '68732', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('126', 'Hawaii', 'Shirleyfort', NULL, 'Wolff Lodge', '135', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('127', 'Hawaii', 'Violettehaven', NULL, 'Alva Mountain', '623', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('128', 'Delaware', 'East Damien', NULL, 'Lloyd Manor', '830', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('129', 'District of Columbia', 'Murrayville', NULL, 'Greenholt Ferry', '48508', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('130', 'Utah', 'New Eraborough', NULL, 'Rippin Overpass', '675', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('131', 'Massachusetts', 'Pacochatown', NULL, 'Porter Isle', '62097', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('132', 'Oregon', 'Nadiafort', NULL, 'Hand Wall', '1112', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('133', 'Maryland', 'Celestinefurt', NULL, 'Myrtis Inlet', '24015', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('134', 'NorthDakota', 'Steubershire', NULL, 'Hills Camp', '666', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('135', 'Minnesota', 'Goyettefurt', NULL, 'Reymundo Island', '627', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('136', 'Florida', 'Jacynthehaven', NULL, 'Powlowski Loop', '9272', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('137', 'Kansas', 'New Marguerite', NULL, 'Powlowski Stravenue', '8816', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('138', 'Oklahoma', 'Ashtynshire', NULL, 'Cremin Well', '1407', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('139', 'Alabama', 'New Elijah', NULL, 'Bobby Motorway', '46664', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('140', 'Arizona', 'North Ernestina', NULL, 'Hailee Street', '43615', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('141', 'Nevada', 'Boehmhaven', NULL, 'Armstrong Walks', '21665', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('142', 'Kentucky', 'Maybellstad', NULL, 'Greg Isle', '18456', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('143', 'Iowa', 'Port Erik', NULL, 'Alisha Circle', '55618', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('144', 'Mississippi', 'Garretfort', NULL, 'Casimir Lake', '060', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('145', 'Wisconsin', 'Lake Vern', NULL, 'Prohaska Glen', '41407', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('146', 'Florida', 'McGlynnshire', NULL, 'Reilly Fort', '6141', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('147', 'Alabama', 'North Blaiseshire', NULL, 'Lockman Road', '584', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('148', 'WestVirginia', 'Lynnburgh', NULL, 'Patience Heights', '5217', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('149', 'Nevada', 'South Dana', NULL, 'Jeanie Glen', '8413', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('150', 'Nevada', 'East Garry', NULL, 'Cruickshank Mountains', '6503', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('151', 'Colorado', 'North Camdenside', NULL, 'Alena Way', '38345', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('152', 'Massachusetts', 'South Theresa', NULL, 'Kiehn Light', '59482', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('153', 'NewHampshire', 'Luettgenhaven', NULL, 'O\'Conner Stream', '1705', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('154', 'Louisiana', 'Jackieport', NULL, 'Baumbach Green', '921', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('155', 'Alabama', 'Lornaberg', NULL, 'Laron Ports', '23583', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('156', 'NorthCarolina', 'Harrisfurt', NULL, 'Georgianna Junction', '76469', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('157', 'NorthDakota', 'Howeport', NULL, 'Hand Stravenue', '63191', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('158', 'Alabama', 'East Zechariah', NULL, 'Kassulke Underpass', '62452', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('159', 'Arizona', 'Parkerfort', NULL, 'Bauch Wall', '788', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('160', 'Florida', 'North Heidi', NULL, 'Ben Keys', '66903', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('161', 'Mississippi', 'Kreigerfort', NULL, 'Enid Street', '645', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('162', 'Nevada', 'Lake Lonfurt', NULL, 'Garret Port', '006', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('163', 'Louisiana', 'North Vivianneview', NULL, 'Hammes Cliff', '82852', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('164', 'Vermont', 'Kunzemouth', NULL, 'Kilback Light', '5385', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('165', 'SouthCarolina', 'East Mollyborough', NULL, 'Enoch Highway', '965', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('166', 'RhodeIsland', 'North Tom', NULL, 'Jefferey Lake', '92312', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('167', 'Vermont', 'Reichertfort', NULL, 'Ashleigh Causeway', '13812', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('168', 'NewMexico', 'Spinkaside', NULL, 'Shane Radial', '349', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('169', 'Illinois', 'Roobstad', NULL, 'Borer Islands', '116', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('170', 'Oklahoma', 'Deanmouth', NULL, 'Herman Court', '2380', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('171', 'Connecticut', 'South Tanya', NULL, 'Boyer Junction', '250', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('172', 'Louisiana', 'New Robyntown', NULL, 'Hyatt Groves', '616', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('173', 'NewJersey', 'Kirstenton', NULL, 'Adrian Estates', '34931', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('174', 'Utah', 'South Rachellestad', NULL, 'Glover Extensions', '62239', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('175', 'Tennessee', 'Jeanneton', NULL, 'Edmund Inlet', '59109', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('176', 'Connecticut', 'New Palma', NULL, 'Jaime Club', '5885', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('177', 'Georgia', 'Stammton', NULL, 'Lebsack Mews', '7240', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('178', 'NewMexico', 'Lake Darrin', NULL, 'Skye Trace', '712', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('179', 'NewHampshire', 'Pacochafort', NULL, 'Schmeler Lake', '652', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('180', 'Iowa', 'North Royal', NULL, 'McGlynn Fields', '34652', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('181', 'Maryland', 'Schuppeside', NULL, 'Altenwerth Harbor', '522', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('182', 'Maine', 'Corkeryborough', NULL, 'Jairo Rue', '0974', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('183', 'NewMexico', 'East Reinaland', NULL, 'Kautzer Lock', '6936', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('184', 'SouthCarolina', 'West Jonathon', NULL, 'Roob Vista', '9976', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('185', 'Ohio', 'Mrazfurt', NULL, 'Reuben Burgs', '52870', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('186', 'Oregon', 'South Eulah', NULL, 'Julia Expressway', '26791', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('187', 'Wisconsin', 'Aufderharburgh', NULL, 'Ansley Shoals', '321', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('188', 'Nebraska', 'West Turnerstad', NULL, 'Dessie Harbor', '82092', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('189', 'Nevada', 'Javierburgh', NULL, 'Adella Plains', '10948', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('190', 'Arkansas', 'Leslieview', NULL, 'Rippin Curve', '73037', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('191', 'Delaware', 'West Randi', NULL, 'Kautzer Prairie', '6687', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('192', 'Arizona', 'Danielleton', NULL, 'Roy Summit', '068', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('193', 'Pennsylvania', 'North Jenningstown', NULL, 'Fadel Mews', '6619', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('194', 'Arkansas', 'Daughertystad', NULL, 'Kenyatta Tunnel', '59811', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('195', 'Nevada', 'Grantchester', NULL, 'Delphia Glens', '95467', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('196', 'Iowa', 'Pourosview', NULL, 'Terry Landing', '28662', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('197', 'Iowa', 'Port Gwendolynchester', NULL, 'Crona Loaf', '5952', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('198', 'NorthDakota', 'West Raquelview', NULL, 'Shanon Loaf', '7743', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('199', 'NorthCarolina', 'Lake Goldaport', NULL, 'Gutmann Courts', '10639', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('200', 'Michigan', 'Port Lessieport', NULL, 'Bogisich Plains', '248', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('201', 'SouthDakota', 'Saraiport', NULL, 'Hermann Street', '968', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('202', 'Texas', 'South Josefa', NULL, 'Rachael Mission', '571', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('203', 'Montana', 'Hegmannberg', NULL, 'August Ville', '21417', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('204', 'Pennsylvania', 'Kayleystad', NULL, 'Clifford Valley', '78074', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('205', 'Oregon', 'Diegoburgh', NULL, 'Katelynn Rapid', '123', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('206', 'Maryland', 'Port Addiebury', NULL, 'Judge Stravenue', '9404', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('207', 'District of Columbia', 'Judeburgh', NULL, 'Monahan Key', '97986', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('208', 'Georgia', 'South Dee', NULL, 'Eichmann Summit', '04261', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('209', 'NorthDakota', 'South Gregory', NULL, 'Amara Road', '04355', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('210', 'NewYork', 'New Maddisonside', NULL, 'Flossie Cape', '692', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('211', 'NewJersey', 'Kossfurt', NULL, 'Edwin Throughway', '06751', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('212', 'Maine', 'Mercedesside', NULL, 'Spinka Coves', '20318', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('213', 'RhodeIsland', 'Port Mckennafurt', NULL, 'Bradtke Walk', '07152', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('214', 'Massachusetts', 'Ethanberg', NULL, 'Rickie Isle', '69963', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('215', 'Georgia', 'Keelingfort', NULL, 'Nolan Fields', '951', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('216', 'Kansas', 'Port Stephonton', NULL, 'Evangeline Canyon', '6166', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('217', 'Delaware', 'Ratkemouth', NULL, 'Emard Well', '19089', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('218', 'Nevada', 'Schroedermouth', NULL, 'Hirthe Turnpike', '64116', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('219', 'Missouri', 'Pacochaberg', NULL, 'Predovic Squares', '16786', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('220', 'Massachusetts', 'Hermannside', NULL, 'Bergnaum Lock', '294', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('221', 'Tennessee', 'North Ronhaven', NULL, 'Wyman Via', '99115', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('222', 'RhodeIsland', 'South Viola', NULL, 'Germaine Circles', '7870', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('223', 'Idaho', 'Wileyburgh', NULL, 'Langworth Inlet', '8725', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('224', 'Oklahoma', 'East Estaport', NULL, 'Franecki Hill', '5961', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('225', 'NewYork', 'Annettachester', NULL, 'Quentin Mission', '9575', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('226', 'Idaho', 'Lake Madelynn', NULL, 'Ola Manor', '809', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('227', 'Florida', 'Lake Heavenberg', NULL, 'Leuschke Knoll', '022', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('228', 'Arizona', 'Jacobsonview', NULL, 'Prohaska River', '354', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('229', 'Colorado', 'New Jadaton', NULL, 'Connor Freeway', '5138', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('230', 'Nevada', 'Nyasialand', NULL, 'Jermain Station', '0037', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('231', 'Delaware', 'Wildermanmouth', NULL, 'Johnny Flat', '8653', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('232', 'Pennsylvania', 'Lake Paula', NULL, 'Quitzon Flats', '286', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('233', 'Montana', 'South Jovanyfort', NULL, 'Tiffany Estates', '07876', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('234', 'Louisiana', 'Betteport', NULL, 'Durgan Station', '431', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('235', 'Tennessee', 'North Bofort', NULL, 'Boris Place', '4036', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('236', 'Louisiana', 'Tanyaburgh', NULL, 'Maggio Flats', '337', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('237', 'Wisconsin', 'Port Samfort', NULL, 'Emilia Tunnel', '36264', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('238', 'Vermont', 'Jenkinston', NULL, 'Hilll Square', '895', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('239', 'Arizona', 'Beckerburgh', NULL, 'Cristobal Passage', '1125', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('240', 'NorthDakota', 'Jastton', NULL, 'Wolf Burg', '27201', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('241', 'Oregon', 'Greenfurt', NULL, 'Harrison Cape', '984', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('242', 'RhodeIsland', 'Binsport', NULL, 'Bernie Squares', '3218', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('243', 'Texas', 'Hudsonburgh', NULL, 'Steuber Street', '20750', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('244', 'SouthDakota', 'Leoraside', NULL, 'Pouros Locks', '436', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('245', 'Arkansas', 'East Stevieland', NULL, 'Lavon Trail', '921', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('246', 'Ohio', 'Adalineview', NULL, 'Kole Cliff', '1388', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('247', 'Illinois', 'North Neldaport', NULL, 'Derrick Estate', '332', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('248', 'RhodeIsland', 'East Rashad', NULL, 'Ardith Overpass', '25359', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('249', 'Arizona', 'New Garrett', NULL, 'McKenzie Villages', '79932', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('250', 'Arkansas', 'East Randallmouth', NULL, 'Halvorson Drive', '6243', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('251', 'Ohio', 'Bufordview', NULL, 'Jada Heights', '9923', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('252', 'Oklahoma', 'New Darien', NULL, 'Kristofer Centers', '9595', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('253', 'Tennessee', 'New Brian', NULL, 'Gutkowski Street', '0411', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('254', 'Minnesota', 'West Trevafort', NULL, 'Ferry Vista', '910', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('255', 'Utah', 'Rubyview', NULL, 'Satterfield Lodge', '79254', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('256', 'NewMexico', 'Adamview', NULL, 'Liam Knolls', '98766', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('257', 'Montana', 'East Craig', NULL, 'Skiles Loop', '845', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('258', 'Montana', 'Port Vernaberg', NULL, 'Twila Path', '27579', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('259', 'Pennsylvania', 'Weberland', NULL, 'Jett Course', '254', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('260', 'Pennsylvania', 'Keshaunborough', NULL, 'Douglas Ramp', '8065', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('261', 'SouthDakota', 'New Brentmouth', NULL, 'Rempel Junction', '7181', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('262', 'SouthDakota', 'Rippinmouth', NULL, 'Bayer Plain', '4866', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('263', 'WestVirginia', 'Lake Dessieton', NULL, 'Shawn Path', '2809', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('264', 'NewMexico', 'West Davinland', NULL, 'Abernathy Forges', '04323', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('265', 'Oklahoma', 'Lake Brittany', NULL, 'Ray Oval', '113', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('266', 'Georgia', 'Lake Eddieside', NULL, 'Gibson Corners', '61616', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('267', 'Minnesota', 'Lynchmouth', NULL, 'Ferry Plaza', '9845', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('268', 'Kentucky', 'Wunschside', NULL, 'Lue Route', '63008', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('269', 'NewYork', 'Rolfsonfort', NULL, 'Sanford Branch', '535', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('270', 'Hawaii', 'Lake Dangeloview', NULL, 'Prosacco Fork', '576', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('271', 'NorthCarolina', 'McDermottshire', NULL, 'Elda Neck', '8296', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('272', 'Wisconsin', 'Lake Bruceville', NULL, 'Janae Brook', '02610', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('273', 'NewMexico', 'Caliborough', NULL, 'Boehm Point', '35391', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('274', 'Connecticut', 'Lake Addisonview', NULL, 'Lydia Motorway', '9546', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('275', 'Florida', 'Kuphalshire', NULL, 'Flossie Mount', '1947', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('276', 'Indiana', 'Buckmouth', NULL, 'Orpha Summit', '99670', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('277', 'NewYork', 'East Lemuelland', NULL, 'Brendan Loaf', '5782', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('278', 'Texas', 'Lindgrenfort', NULL, 'Lynch Flat', '4121', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('279', 'Alaska', 'Christiansenton', NULL, 'Ricardo Dam', '2568', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('280', 'Idaho', 'DuBuquefurt', NULL, 'Delbert Orchard', '609', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('281', 'Idaho', 'New Reynastad', NULL, 'Marks Crossing', '7175', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('282', 'Hawaii', 'North Americabury', NULL, 'Smith Harbors', '4507', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('283', 'Alabama', 'Lockmanville', NULL, 'Koepp Walk', '160', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('284', 'WestVirginia', 'Jacobsonhaven', NULL, 'Andy Trail', '2007', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('285', 'Ohio', 'New Krystelfurt', NULL, 'Senger Spring', '26037', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('286', 'WestVirginia', 'Caesarshire', NULL, 'Oran Causeway', '9293', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('287', 'Utah', 'Howellmouth', NULL, 'Franco Plain', '2438', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('288', 'SouthDakota', 'West Keonmouth', NULL, 'Charity Gardens', '545', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('289', 'Kansas', 'Blockberg', NULL, 'Geovany Center', '11547', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('290', 'Indiana', 'South Eunicebury', NULL, 'Terrence Skyway', '0241', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('291', 'Wisconsin', 'Kulasview', NULL, 'Norma Light', '5177', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('292', 'Massachusetts', 'Amiraland', NULL, 'Herminio Keys', '5356', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('293', 'NorthDakota', 'Ratketown', NULL, 'Kihn Cliffs', '68233', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('294', 'Kentucky', 'New Marlentown', NULL, 'Hartmann Vista', '61108', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('295', 'Kentucky', 'East Elva', NULL, 'Chelsie Hills', '45858', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('296', 'NewJersey', 'South Lavonne', NULL, 'Ondricka Keys', '77836', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('297', 'Nevada', 'East Hardy', NULL, 'Jacobson Ridges', '5419', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('298', 'Indiana', 'East Rahul', NULL, 'Wolf Street', '649', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('299', 'Iowa', 'Amirshire', NULL, 'Kozey Gateway', '854', NULL);
INSERT INTO `address` (`id`, `region`, `town`, `district`, `street`, `house`, `flat`) VALUES ('300', 'Wisconsin', 'East Tobin', NULL, 'Orin Wells', '833', NULL);




INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('1', 'Turner', 'McGlynn', '1977-10-20', 'm', '1984-12-15', 'C', '1', '1');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('2', 'Clement', 'Kreiger', '1972-02-29', 'm', '1995-12-09', 'E', '2', '2');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('3', 'Peter', 'Rolfson', '1995-06-06', 'f', '2014-04-25', '', '3', '3');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('4', 'Gardner', 'Kemmer', '2014-12-16', 'm', '1988-07-09', 'B', '4', '4');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('5', 'Darrel', 'Pagac', '1989-06-14', 'm', '2013-06-16', 'B', '5', '5');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('6', 'Jonatan', 'Batz', '1989-12-09', 'm', '2010-05-02', 'B', '6', '6');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('7', 'Amparo', 'Lebsack', '2021-05-16', 'm', '1982-03-04', '', '7', '7');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('8', 'Keaton', 'Watsica', '1996-09-14', 'f', '1975-04-08', 'B', '8', '8');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('9', 'Fritz', 'Goldner', '1970-02-01', 'f', '1979-06-30', '', '9', '9');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('10', 'Halle', 'Skiles', '2017-09-24', 'm', '2009-12-08', 'C', '10', '10');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('11', 'Raymond', 'Hoeger', '2006-06-13', 'f', '1994-05-26', 'A', '11', '11');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('12', 'Franz', 'Harvey', '2006-08-24', 'm', '1991-12-07', 'E', '12', '12');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('13', 'Aylin', 'Windler', '2016-07-31', 'm', '2005-11-01', 'D', '13', '13');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('14', 'Colby', 'Collier', '1974-10-09', 'f', '2001-09-20', '', '14', '14');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('15', 'Dakota', 'Gulgowski', '1993-02-25', 'f', '2010-09-21', 'B', '15', '15');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('16', 'Garnet', 'Doyle', '1989-06-03', 'm', '2019-09-02', 'C', '16', '16');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('17', 'Gaetano', 'Daniel', '1980-10-21', 'f', '1995-07-19', 'E', '17', '17');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('18', 'Laila', 'Volkman', '1987-03-24', 'f', '1973-09-04', 'A', '18', '18');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('19', 'Bria', 'Auer', '2006-09-17', 'f', '1994-07-11', 'B', '19', '19');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('20', 'Luna', 'Hessel', '1997-01-14', 'f', '2007-12-16', 'E', '20', '20');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('21', 'Vincenza', 'Stokes', '1973-08-08', 'f', '2018-04-27', 'B', '21', '21');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('22', 'Leonardo', 'Jacobi', '2019-10-19', 'f', '2017-01-10', '', '22', '22');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('23', 'Idell', 'Cole', '1981-05-06', 'm', '2004-09-12', 'C', '23', '23');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('24', 'Toy', 'Kutch', '1999-02-18', 'f', '1996-01-19', 'A', '24', '24');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('25', 'Dee', 'Ryan', '2007-01-23', 'f', '2014-03-17', 'D', '25', '25');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('26', 'Gerhard', 'Russel', '2003-10-10', 'f', '1998-11-23', '', '26', '26');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('27', 'Julius', 'Bosco', '1979-04-05', 'm', '1994-08-28', 'C', '27', '27');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('28', 'Karley', 'Funk', '1981-11-23', 'm', '1991-02-16', 'B', '28', '28');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('29', 'Eladio', 'O\'Hara', '1996-06-06', 'f', '1998-10-27', '', '29', '29');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('30', 'Leora', 'Daugherty', '1992-08-17', 'f', '1972-08-11', 'C', '30', '30');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('31', 'Aurelie', 'Stracke', '1976-05-19', 'm', '2017-12-27', 'A', '31', '31');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('32', 'Ludwig', 'Morar', '1990-09-03', 'm', '1995-03-04', 'C', '32', '32');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('33', 'Leonard', 'Adams', '2011-09-14', 'm', '2019-09-15', '', '33', '33');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('34', 'Ethel', 'Russel', '2010-02-13', 'm', '2004-12-05', 'D', '34', '34');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('35', 'Eliane', 'Leffler', '1984-12-26', 'f', '2004-05-18', 'D', '35', '35');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('36', 'Guy', 'Hamill', '1988-02-13', 'm', '2007-03-25', 'E', '36', '36');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('37', 'Isom', 'Walter', '2019-09-08', 'm', '1999-12-05', 'B', '37', '37');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('38', 'Christy', 'Stroman', '1971-03-29', 'f', '1982-07-12', '', '38', '38');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('39', 'Cleora', 'Streich', '1994-04-06', 'f', '2006-07-07', 'D', '39', '39');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('40', 'Shannon', 'Rolfson', '1980-11-11', 'f', '1997-10-19', 'C', '40', '40');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('41', 'Claudia', 'Mueller', '2009-06-15', 'm', '2010-06-01', 'A', '41', '41');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('42', 'Thora', 'Buckridge', '2020-02-23', 'm', '1983-06-03', 'C', '42', '42');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('43', 'Maximilian', 'Mills', '2020-01-25', 'm', '1977-08-13', 'A', '43', '43');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('44', 'Arielle', 'Hickle', '1971-09-29', 'm', '2014-05-08', '', '44', '44');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('45', 'Elvera', 'Effertz', '2021-01-06', 'm', '2015-08-18', 'D', '45', '45');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('46', 'Murl', 'Grady', '2019-08-24', 'f', '2001-07-23', 'B', '46', '46');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('47', 'Joe', 'Torphy', '1996-05-16', 'f', '1994-12-06', 'B', '47', '47');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('48', 'Gwen', 'Klocko', '1973-03-01', 'm', '1984-09-27', 'E', '48', '48');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('49', 'Domenica', 'Eichmann', '1998-02-25', 'f', '2011-01-16', 'D', '49', '49');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('50', 'Adele', 'Mills', '1988-01-08', 'm', '2010-09-10', '', '50', '50');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('51', 'Coy', 'Herzog', '1987-03-23', 'm', '1979-01-11', 'B', '51', '51');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('52', 'Wanda', 'Zulauf', '1999-07-13', 'f', '2003-11-10', 'B', '52', '52');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('53', 'Aileen', 'Brown', '1983-01-11', 'f', '2019-01-30', 'A', '53', '53');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('54', 'Janae', 'Altenwerth', '1983-02-07', 'm', '1988-04-29', '', '54', '54');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('55', 'Nash', 'Huels', '1988-04-02', 'f', '2010-07-12', 'A', '55', '55');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('56', 'Pietro', 'Schoen', '1976-06-07', 'f', '2016-09-27', '', '56', '56');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('57', 'Oma', 'Rosenbaum', '2005-11-24', 'm', '1999-12-26', 'D', '57', '57');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('58', 'Jarred', 'Bergnaum', '1996-05-29', 'f', '2013-09-17', 'B', '58', '58');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('59', 'Tania', 'Moen', '1995-11-28', 'f', '1973-06-08', 'C', '59', '59');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('60', 'Alanis', 'Halvorson', '2011-11-14', 'f', '2004-07-30', 'B', '60', '60');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('61', 'Breana', 'Pfannerstill', '1983-10-01', 'f', '1987-02-08', 'B', '61', '61');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('62', 'Yesenia', 'Greenholt', '2008-03-31', 'm', '2017-02-17', 'D', '62', '62');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('63', 'Rashad', 'Pfeffer', '2013-08-31', 'f', '1992-08-30', 'D', '63', '63');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('64', 'Madelyn', 'Lowe', '1996-08-13', 'f', '1993-09-09', 'B', '64', '64');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('65', 'Daniela', 'Ledner', '1985-07-31', 'f', '1982-01-28', 'D', '65', '65');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('66', 'Brendan', 'Hackett', '1996-07-17', 'm', '2019-04-04', 'C', '66', '66');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('67', 'Liza', 'Collier', '1980-06-05', 'm', '1990-07-19', 'D', '67', '67');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('68', 'Alana', 'Monahan', '1984-04-13', 'm', '1984-01-16', 'A', '68', '68');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('69', 'Alexandrea', 'O\'Keefe', '1976-06-20', 'f', '1975-09-22', 'E', '69', '69');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('70', 'Kylie', 'Rutherford', '2010-02-03', 'f', '2002-12-08', '', '70', '70');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('71', 'Franz', 'Brown', '2008-09-09', 'f', '1988-11-30', 'C', '71', '71');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('72', 'Mattie', 'Walker', '1982-09-01', 'f', '2019-02-10', '', '72', '72');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('73', 'Else', 'Schmidt', '2002-12-14', 'm', '2004-02-24', 'D', '73', '73');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('74', 'Santino', 'Lehner', '1987-07-25', 'm', '2020-09-28', 'E', '74', '74');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('75', 'Hugh', 'Grant', '1995-05-15', 'm', '2011-02-06', 'A', '75', '75');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('76', 'Westley', 'Bruen', '2011-07-11', 'm', '1979-04-29', 'C', '76', '76');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('77', 'Lizzie', 'McDermott', '2009-06-05', 'f', '1972-07-21', 'D', '77', '77');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('78', 'Dorian', 'Kunze', '1982-04-08', 'm', '2020-02-14', 'D', '78', '78');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('79', 'Brandy', 'Goldner', '1983-11-20', 'f', '2006-04-28', 'A', '79', '79');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('80', 'Allen', 'Corwin', '1977-08-18', 'm', '2007-04-06', 'A', '80', '80');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('81', 'Emmet', 'Turner', '2017-02-23', 'm', '1978-01-19', 'D', '81', '81');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('82', 'Morris', 'Smitham', '2012-08-19', 'm', '1979-06-10', '', '82', '82');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('83', 'Abel', 'Pagac', '1988-07-06', 'f', '2000-12-27', 'B', '83', '83');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('84', 'Arvilla', 'Crooks', '1989-07-28', 'm', '1984-06-15', 'E', '84', '84');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('85', 'Aliza', 'Hackett', '2003-09-09', 'm', '2018-04-11', 'D', '85', '85');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('86', 'Felipe', 'Conroy', '1970-03-12', 'm', '1996-10-28', 'B', '86', '86');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('87', 'Oliver', 'Huels', '1992-10-30', 'f', '1988-12-01', 'B', '87', '87');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('88', 'Amy', 'Stanton', '2017-10-23', 'm', '2016-11-11', 'B', '88', '88');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('89', 'Jeanette', 'Carter', '2016-02-08', 'f', '2020-12-24', 'A', '89', '89');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('90', 'Anjali', 'Brakus', '2005-07-24', 'm', '2021-03-18', 'D', '90', '90');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('91', 'Kiara', 'Hand', '1986-09-20', 'f', '1990-07-18', 'A', '91', '91');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('92', 'Claudia', 'Mann', '1988-01-12', 'm', '1976-10-09', 'C', '92', '92');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('93', 'Lue', 'Quigley', '2002-05-17', 'm', '1995-08-15', '', '93', '93');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('94', 'Renee', 'Murphy', '2007-03-23', 'f', '1989-08-20', 'B', '94', '94');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('95', 'Leila', 'Paucek', '2007-04-10', 'm', '1986-12-22', '', '95', '95');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('96', 'Antwan', 'O\'Conner', '1982-03-02', 'f', '1987-08-01', 'C', '96', '96');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('97', 'Evelyn', 'Collier', '1973-07-21', 'm', '2018-05-12', 'A', '97', '97');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('98', 'Icie', 'Kiehn', '2003-03-18', 'm', '1988-01-06', 'E', '98', '98');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('99', 'Therese', 'Gutkowski', '2013-04-12', 'm', '2004-07-29', 'A', '99', '99');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('100', 'Bailey', 'Shields', '2019-02-05', 'm', '1981-10-14', 'D', '100', '100');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('101', 'Darrel', 'Walker', '1975-04-15', 'f', '1997-10-04', 'A', '101', '101');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('102', 'Gust', 'Hills', '2007-12-26', 'f', '1989-05-12', 'C', '102', '102');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('103', 'Drew', 'Schamberger', '1972-07-22', 'm', '1988-02-20', 'A', '103', '103');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('104', 'Layla', 'Dach', '2011-02-26', 'm', '1972-06-25', 'C', '104', '104');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('105', 'Mortimer', 'Towne', '2008-07-17', 'f', '2015-11-30', 'C', '105', '105');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('106', 'Hester', 'Kassulke', '1990-08-20', 'f', '1995-10-06', 'A', '106', '106');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('107', 'Teresa', 'Sporer', '1991-07-02', 'f', '2012-11-03', '', '107', '107');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('108', 'Mossie', 'Price', '2006-08-01', 'f', '1978-05-07', 'A', '108', '108');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('109', 'Theo', 'Hilll', '2012-09-20', 'm', '1972-11-01', 'B', '109', '109');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('110', 'Aiden', 'Klocko', '1988-12-03', 'm', '1979-12-05', 'B', '110', '110');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('111', 'Adeline', 'Kunze', '2001-04-10', 'm', '2008-05-03', 'A', '111', '111');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('112', 'Ronaldo', 'Breitenberg', '1990-05-19', 'f', '1999-11-20', 'B', '112', '112');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('113', 'Fredrick', 'Kohler', '1994-06-02', 'm', '2003-08-23', 'E', '113', '113');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('114', 'Kasey', 'Carter', '1996-10-23', 'm', '2019-03-31', 'C', '114', '114');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('115', 'Germaine', 'Effertz', '1988-08-18', 'm', '2006-03-01', 'A', '115', '115');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('116', 'Grace', 'Schowalter', '1987-02-02', 'f', '1992-01-18', 'C', '116', '116');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('117', 'Elisabeth', 'Wolff', '2016-10-17', 'f', '1995-06-27', '', '117', '117');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('118', 'Ken', 'Schumm', '1997-06-13', 'f', '1990-08-26', 'C', '118', '118');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('119', 'Rick', 'Miller', '1986-07-11', 'm', '2017-05-11', 'A', '119', '119');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('120', 'Laila', 'Koepp', '1975-12-22', 'f', '1997-03-20', 'D', '120', '120');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('121', 'Marcelo', 'Nicolas', '2006-10-04', 'm', '2018-12-12', 'E', '121', '121');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('122', 'Alfonso', 'Rippin', '1983-10-03', 'f', '1986-05-15', 'E', '122', '122');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('123', 'Stephania', 'Rempel', '2000-11-26', 'm', '2019-06-25', 'D', '123', '123');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('124', 'Christop', 'Franecki', '1983-05-16', 'f', '1980-06-20', 'A', '124', '124');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('125', 'Dylan', 'Kreiger', '1995-09-08', 'm', '1984-11-11', '', '125', '125');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('126', 'Horacio', 'Kunze', '2021-06-07', 'm', '1982-07-12', 'C', '126', '126');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('127', 'Heber', 'Cummings', '2004-01-22', 'm', '2018-05-31', '', '127', '127');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('128', 'Llewellyn', 'Stanton', '1972-12-24', 'm', '2012-09-25', 'B', '128', '128');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('129', 'Micaela', 'Abbott', '1986-09-30', 'f', '1990-05-06', 'A', '129', '129');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('130', 'Keegan', 'Terry', '1990-01-14', 'm', '1984-06-21', 'B', '130', '130');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('131', 'Kellie', 'Schultz', '2014-11-20', 'f', '1986-06-30', 'B', '131', '131');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('132', 'Paxton', 'Hermann', '1973-12-04', 'f', '1996-03-27', 'C', '132', '132');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('133', 'Aglae', 'Legros', '2010-07-10', 'm', '1973-03-10', 'C', '133', '133');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('134', 'Joshuah', 'Runolfsdottir', '1979-11-11', 'm', '2006-03-09', 'A', '134', '134');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('135', 'Euna', 'Daniel', '2011-07-26', 'm', '1992-05-11', '', '135', '135');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('136', 'Katrina', 'Zboncak', '1990-06-13', 'm', '1992-06-15', 'B', '136', '136');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('137', 'Otho', 'Bashirian', '2015-02-04', 'm', '1980-12-27', 'B', '137', '137');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('138', 'Eudora', 'Smitham', '1984-07-01', 'f', '1976-10-29', '', '138', '138');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('139', 'Jayme', 'Wolf', '1971-08-15', 'm', '1986-11-18', 'B', '139', '139');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('140', 'Camryn', 'Abbott', '1988-03-27', 'f', '1981-03-16', 'A', '140', '140');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('141', 'Betsy', 'Zulauf', '1984-12-19', 'f', '1999-05-26', 'B', '141', '141');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('142', 'Yasmin', 'Kutch', '1979-02-19', 'f', '1983-11-08', 'A', '142', '142');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('143', 'Brenna', 'Lemke', '2005-01-18', 'f', '1990-03-25', 'B', '143', '143');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('144', 'Fermin', 'Mann', '1994-04-13', 'f', '1998-03-15', '', '144', '144');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('145', 'Arianna', 'Cormier', '2018-02-15', 'f', '2005-05-25', 'E', '145', '145');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('146', 'Quinten', 'Hartmann', '1988-02-05', 'm', '1996-12-25', 'A', '146', '146');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('147', 'Lura', 'Gutmann', '1985-10-06', 'f', '1971-08-01', 'E', '147', '147');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('148', 'Kendra', 'Lindgren', '2009-04-07', 'f', '1984-09-02', 'D', '148', '148');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('149', 'Ana', 'Larkin', '1975-04-22', 'f', '2008-11-12', 'B', '149', '149');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('150', 'Lavon', 'O\'Reilly', '1972-03-07', 'f', '1975-04-04', '', '150', '150');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('151', 'Kristofer', 'Ruecker', '2013-05-24', 'm', '1983-10-31', 'D', '151', '151');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('152', 'Karlie', 'West', '1976-02-05', 'm', '1985-03-18', 'B', '152', '152');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('153', 'Ward', 'Nikolaus', '2016-09-09', 'f', '1978-12-05', 'D', '153', '153');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('154', 'Randy', 'Beahan', '1991-01-18', 'f', '2012-10-22', 'E', '154', '154');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('155', 'Trystan', 'Prohaska', '1971-08-27', 'm', '1979-08-20', '', '155', '155');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('156', 'Evan', 'Murphy', '2007-03-08', 'f', '2015-12-11', 'A', '156', '156');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('157', 'Carey', 'Braun', '1997-05-03', 'm', '2013-06-03', 'B', '157', '157');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('158', 'Pattie', 'Gleichner', '2020-04-02', 'm', '1985-03-17', 'E', '158', '158');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('159', 'Eve', 'Braun', '1990-12-18', 'm', '2014-05-07', 'D', '159', '159');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('160', 'Adalberto', 'McKenzie', '2019-10-07', 'f', '2003-02-18', 'A', '160', '160');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('161', 'Alysa', 'Glover', '1981-12-24', 'f', '1987-07-30', 'E', '161', '161');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('162', 'Ruth', 'Larkin', '1987-12-05', 'm', '1998-05-04', 'D', '162', '162');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('163', 'Freeman', 'Wunsch', '1987-12-10', 'f', '1976-04-07', '', '163', '163');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('164', 'Angela', 'Larkin', '1977-10-01', 'f', '2008-05-06', 'B', '164', '164');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('165', 'Lloyd', 'Dach', '2018-01-31', 'm', '2009-12-22', 'A', '165', '165');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('166', 'Eli', 'Jenkins', '2004-07-13', 'm', '1980-10-15', '', '166', '166');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('167', 'Rodrigo', 'Harris', '2001-02-21', 'm', '2004-04-12', 'B', '167', '167');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('168', 'Abigale', 'Larkin', '1993-04-19', 'f', '1978-05-03', 'B', '168', '168');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('169', 'Kayleigh', 'Gorczany', '1982-05-18', 'm', '1994-05-22', 'C', '169', '169');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('170', 'Trey', 'Walsh', '1992-11-11', 'm', '2019-02-04', 'B', '170', '170');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('171', 'Ottilie', 'Kshlerin', '1984-05-20', 'm', '2009-02-16', 'D', '171', '171');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('172', 'Lonie', 'Shields', '1970-01-07', 'f', '2008-03-31', 'E', '172', '172');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('173', 'Richmond', 'Roberts', '1985-08-31', 'm', '2003-02-01', 'B', '173', '173');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('174', 'Dianna', 'Swift', '1992-08-21', 'f', '1989-07-25', 'B', '174', '174');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('175', 'Agustina', 'Halvorson', '1988-04-19', 'f', '1986-09-08', 'B', '175', '175');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('176', 'Julianne', 'Becker', '1982-03-23', 'm', '1987-05-01', 'C', '176', '176');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('177', 'Dylan', 'Kris', '1990-01-13', 'f', '2012-01-18', 'C', '177', '177');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('178', 'Jett', 'Moore', '1981-06-17', 'm', '1996-04-08', 'A', '178', '178');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('179', 'Gladys', 'Batz', '1988-02-01', 'm', '2000-08-12', 'A', '179', '179');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('180', 'Hallie', 'Toy', '2000-06-29', 'f', '1970-09-11', 'A', '180', '180');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('181', 'Deondre', 'Collins', '1976-11-14', 'f', '1971-01-21', 'E', '181', '181');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('182', 'Mathilde', 'Stokes', '1972-07-28', 'm', '2013-10-30', '', '182', '182');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('183', 'Rocio', 'Schiller', '2016-05-07', 'm', '2017-01-14', 'D', '183', '183');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('184', 'Garnett', 'Ryan', '1993-02-01', 'm', '2009-01-28', 'D', '184', '184');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('185', 'Penelope', 'Funk', '1993-11-21', 'f', '1984-02-08', 'D', '185', '185');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('186', 'Theresia', 'Ryan', '1999-02-21', 'f', '1972-07-01', 'A', '186', '186');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('187', 'Eriberto', 'Haag', '2018-03-29', 'm', '1986-06-17', 'B', '187', '187');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('188', 'Hannah', 'Hirthe', '1974-06-01', 'm', '1982-05-11', '', '188', '188');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('189', 'Merritt', 'Stroman', '1980-02-08', 'f', '2016-07-16', 'A', '189', '189');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('190', 'Jeramie', 'Lang', '1975-06-23', 'f', '2002-06-24', 'B', '190', '190');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('191', 'Shyanne', 'Green', '2000-02-22', 'm', '1981-03-05', 'A', '191', '191');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('192', 'Hazle', 'Kub', '1998-07-18', 'm', '1982-05-03', 'E', '192', '192');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('193', 'Alvis', 'Hahn', '1970-01-01', 'm', '2013-09-16', 'E', '193', '193');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('194', 'Eino', 'Graham', '2015-09-03', 'm', '1987-08-11', 'C', '194', '194');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('195', 'Danial', 'Dibbert', '1975-05-14', 'm', '2000-06-12', 'B', '195', '195');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('196', 'Eldridge', 'Erdman', '2006-10-06', 'f', '1974-05-19', 'B', '196', '196');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('197', 'Jennifer', 'Runolfsdottir', '1972-07-08', 'f', '2012-06-13', '', '197', '197');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('198', 'Gabriel', 'Little', '1990-12-26', 'm', '2017-11-26', 'A', '198', '198');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('199', 'Torrance', 'Braun', '2000-10-26', 'f', '2014-08-13', 'B', '199', '199');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('200', 'Curt', 'DuBuque', '1982-06-12', 'f', '2020-12-04', 'C', '200', '200');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('201', 'Wava', 'Senger', '1982-02-05', 'f', '2010-05-03', 'B', '1', '201');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('202', 'Mariela', 'Abshire', '2006-03-28', 'f', '2000-09-24', 'B', '2', '202');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('203', 'Damien', 'Cartwright', '1975-03-22', 'f', '2011-05-22', 'E', '3', '203');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('204', 'Lambert', 'Hermiston', '2011-03-03', 'm', '1975-02-18', 'A', '4', '204');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('205', 'Makayla', 'Zboncak', '1980-05-03', 'f', '1995-09-26', '', '5', '205');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('206', 'Kyra', 'Casper', '1990-04-07', 'f', '1991-01-26', 'E', '6', '206');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('207', 'Tremaine', 'Gorczany', '1994-03-13', 'm', '1998-11-26', '', '7', '207');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('208', 'Blanche', 'Volkman', '1999-11-04', 'f', '1989-01-14', 'D', '8', '208');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('209', 'Erich', 'Monahan', '2017-07-28', 'f', '1986-12-19', '', '9', '209');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('210', 'Aditya', 'Reichel', '1990-03-27', 'm', '2003-12-09', 'B', '10', '210');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('211', 'Josue', 'Stoltenberg', '2004-06-09', 'm', '1995-03-30', 'C', '11', '211');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('212', 'Josiah', 'Emard', '1988-01-29', 'f', '1973-03-21', 'D', '12', '212');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('213', 'Anthony', 'Raynor', '2021-04-27', 'f', '1991-04-29', '', '13', '213');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('214', 'Melyssa', 'Littel', '2006-12-27', 'f', '2014-03-24', 'C', '14', '214');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('215', 'Ronaldo', 'Hilll', '1983-03-03', 'f', '2018-06-29', 'B', '15', '215');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('216', 'Mitchel', 'Klocko', '2011-10-17', 'f', '2006-11-24', 'D', '16', '216');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('217', 'Tyson', 'Gislason', '1984-09-09', 'f', '1972-04-15', '', '17', '217');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('218', 'Angelita', 'Bahringer', '1977-11-28', 'f', '2018-07-11', 'C', '18', '218');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('219', 'Marilie', 'Lindgren', '2012-01-03', 'f', '2019-08-29', 'A', '19', '219');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('220', 'Estrella', 'Graham', '1988-02-13', 'm', '1984-04-17', 'C', '20', '220');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('221', 'Terrell', 'Gleichner', '2008-09-13', 'f', '1982-10-03', 'D', '21', '221');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('222', 'Mya', 'Flatley', '2016-05-23', 'm', '2007-09-24', 'C', '22', '222');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('223', 'Victoria', 'Tromp', '1972-01-17', 'f', '2015-05-31', 'E', '23', '223');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('224', 'Garret', 'Cummerata', '2002-07-16', 'm', '1993-07-18', '', '24', '224');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('225', 'Cooper', 'Lind', '2002-09-06', 'm', '2011-10-23', 'C', '25', '225');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('226', 'Sanford', 'Haley', '1980-05-03', 'm', '1976-02-24', 'E', '26', '226');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('227', 'Delphine', 'Bruen', '1993-07-27', 'f', '1993-04-01', 'C', '27', '227');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('228', 'Ellie', 'Bernier', '1972-04-21', 'm', '1999-05-14', 'B', '28', '228');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('229', 'Warren', 'Jenkins', '2008-03-28', 'f', '1982-08-13', 'D', '29', '229');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('230', 'Al', 'Hessel', '2008-12-01', 'm', '2015-12-27', 'D', '30', '230');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('231', 'Brian', 'Kerluke', '1977-03-06', 'f', '2008-02-20', '', '31', '231');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('232', 'Ally', 'Harvey', '1985-05-23', 'm', '1997-04-08', '', '32', '232');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('233', 'Braxton', 'Mitchell', '1992-06-16', 'm', '2008-05-23', 'D', '33', '233');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('234', 'Gregoria', 'Simonis', '1975-02-21', 'f', '1980-03-27', 'D', '34', '234');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('235', 'Ben', 'West', '1982-10-27', 'f', '1989-09-08', 'D', '35', '235');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('236', 'Chet', 'Veum', '1975-08-29', 'm', '2010-03-09', 'A', '36', '236');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('237', 'Adelbert', 'Wisozk', '1984-02-05', 'm', '2001-06-14', 'E', '37', '237');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('238', 'Linnea', 'Bailey', '1988-06-23', 'm', '2004-10-25', '', '38', '238');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('239', 'Tomasa', 'Baumbach', '1994-02-14', 'm', '1981-03-18', '', '39', '239');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('240', 'Felix', 'Heller', '1986-08-06', 'm', '2017-10-30', 'C', '40', '240');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('241', 'Kurt', 'Reilly', '1998-07-20', 'm', '1995-11-12', 'E', '41', '241');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('242', 'Meta', 'Bogan', '1979-04-17', 'm', '1978-11-18', 'A', '42', '242');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('243', 'Zita', 'Turner', '1982-07-22', 'm', '2018-02-01', 'D', '43', '243');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('244', 'Agustina', 'Berge', '2015-11-24', 'f', '2008-10-09', '', '44', '244');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('245', 'Treva', 'Krajcik', '1974-03-06', 'f', '1997-11-21', '', '45', '245');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('246', 'Therese', 'Kirlin', '1991-06-19', 'f', '1980-01-29', 'E', '46', '246');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('247', 'Madaline', 'Gibson', '1992-06-23', 'f', '2014-06-17', 'C', '47', '247');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('248', 'Marcellus', 'Raynor', '2018-07-04', 'm', '1980-12-15', 'C', '48', '248');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('249', 'Vern', 'Kreiger', '2003-07-13', 'f', '2011-09-24', 'B', '49', '249');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('250', 'Angela', 'Gislason', '1976-08-18', 'm', '1999-03-09', 'E', '50', '250');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('251', 'Verda', 'Huels', '1975-08-13', 'm', '1975-09-20', 'A', '51', '251');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('252', 'Abbey', 'Barton', '1972-08-30', 'm', '2003-05-22', 'B', '52', '252');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('253', 'Brennan', 'Will', '1996-08-07', 'm', '1983-01-07', 'B', '53', '253');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('254', 'Moriah', 'Osinski', '2005-10-31', 'm', '2009-06-16', 'A', '54', '254');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('255', 'Reyna', 'Fay', '1984-03-03', 'm', '1971-04-01', 'D', '55', '255');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('256', 'Keanu', 'DuBuque', '2012-10-11', 'm', '1984-11-23', 'C', '56', '256');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('257', 'Kaya', 'Nolan', '2004-07-31', 'f', '1970-04-27', 'B', '57', '257');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('258', 'Brenden', 'Schiller', '2005-02-14', 'm', '1986-09-17', 'A', '58', '258');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('259', 'Maxime', 'Friesen', '1983-06-20', 'm', '1997-04-27', 'C', '59', '259');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('260', 'Ladarius', 'Paucek', '2007-08-23', 'f', '1997-01-10', 'A', '60', '260');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('261', 'Carter', 'Labadie', '2014-06-29', 'f', '1978-01-27', 'A', '61', '261');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('262', 'Jorge', 'Graham', '2008-05-08', 'm', '1977-01-23', 'A', '62', '262');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('263', 'Levi', 'Larson', '2018-06-09', 'm', '1994-03-29', 'E', '63', '263');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('264', 'Luigi', 'Konopelski', '2014-04-12', 'f', '1973-03-13', 'E', '64', '264');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('265', 'Zelda', 'Green', '1998-04-22', 'm', '1994-11-19', 'C', '65', '265');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('266', 'Ida', 'Heaney', '1995-01-21', 'f', '2000-12-28', 'D', '66', '266');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('267', 'Russel', 'Crona', '2003-12-27', 'm', '1978-03-19', '', '67', '267');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('268', 'Brendon', 'Zulauf', '2016-06-23', 'm', '2021-01-30', '', '68', '268');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('269', 'Christy', 'Bode', '1994-08-14', 'f', '1998-07-07', '', '69', '269');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('270', 'Hardy', 'Mitchell', '1999-12-10', 'f', '1970-03-28', 'B', '70', '270');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('271', 'Kellen', 'Gottlieb', '2009-10-08', 'm', '2008-01-16', 'A', '71', '271');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('272', 'Mia', 'Lubowitz', '1995-12-12', 'f', '1985-01-16', 'A', '72', '272');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('273', 'Breanne', 'Will', '1998-03-07', 'f', '1996-12-19', 'C', '73', '273');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('274', 'Cathy', 'Botsford', '1970-04-16', 'f', '1985-10-23', 'E', '74', '274');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('275', 'Lorena', 'Cole', '2009-10-16', 'f', '2010-02-10', 'E', '75', '275');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('276', 'Maureen', 'Strosin', '1991-12-22', 'f', '2000-02-25', 'E', '76', '276');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('277', 'Rudolph', 'Cremin', '1996-06-21', 'm', '2017-03-21', 'C', '77', '277');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('278', 'Rolando', 'Goyette', '1982-12-09', 'm', '1982-05-23', 'A', '78', '278');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('279', 'Kendra', 'Heathcote', '1970-09-09', 'f', '1977-07-19', 'A', '79', '279');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('280', 'Ned', 'Stark', '1993-08-30', 'm', '2013-04-22', 'B', '80', '280');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('281', 'Bettie', 'Weber', '2011-04-21', 'm', '1992-08-21', 'E', '81', '281');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('282', 'Brycen', 'Satterfield', '1986-02-21', 'm', '1983-01-29', 'E', '82', '282');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('283', 'Hoyt', 'O\'Kon', '1989-09-16', 'f', '1981-06-14', 'C', '83', '283');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('284', 'Arvid', 'Fahey', '2005-04-01', 'f', '1980-03-19', 'D', '84', '284');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('285', 'Ramon', 'Kiehn', '2014-05-10', 'f', '2015-11-24', 'A', '85', '285');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('286', 'Darryl', 'Weimann', '2016-01-08', 'f', '1986-04-08', '', '86', '286');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('287', 'Damien', 'Blick', '2021-03-14', 'm', '2009-05-22', '', '87', '287');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('288', 'Janie', 'Ryan', '1991-10-05', 'f', '2015-12-07', 'D', '88', '288');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('289', 'Roosevelt', 'Nikolaus', '1980-02-20', 'f', '1989-12-28', 'A', '89', '289');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('290', 'Whitney', 'Deckow', '2009-09-13', 'f', '2021-10-13', 'B', '90', '290');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('291', 'Gerardo', 'Ziemann', '1983-02-18', 'm', '2006-02-06', 'B', '91', '291');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('292', 'Rashawn', 'Sawayn', '2006-01-25', 'f', '1994-07-07', 'C', '92', '292');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('293', 'Mario', 'Bashirian', '1990-12-18', 'm', '2020-04-04', 'D', '93', '293');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('294', 'Brayan', 'Shields', '2018-01-25', 'm', '1990-04-29', 'A', '94', '294');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('295', 'Alex', 'Haag', '1999-08-17', 'm', '2005-05-14', 'B', '95', '295');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('296', 'Ally', 'Huel', '2003-11-07', 'f', '2014-12-03', '', '96', '296');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('297', 'Edwardo', 'Hudson', '1979-04-17', 'f', '2006-01-11', 'A', '97', '297');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('298', 'Thomas', 'Runolfsdottir', '2000-05-09', 'm', '1970-01-03', 'E', '98', '298');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('299', 'Elian', 'Orn', '2016-03-09', 'f', '1990-09-01', 'A', '99', '299');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('300', 'Aric', 'Hodkiewicz', '1973-10-25', 'f', '2006-01-29', 'E', '100', '300');
INSERT INTO `man` (`id`, `firstname`, `lastname`, `birthday`, `gender`, `license_from`, `type_of_license`, `photo_id`, `address_id`) VALUES ('301', 'Aric', 'Hodkiewicz', '1973-10-25', 'f', '2006-01-29', '', '100', '300');




INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('1', '177', '244', '2021-02-25', '202', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('2', '252', '310', '2019-10-20', '7', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('3', '18', '262', '2019-03-25', '112', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('4', '5', '8', '2021-11-08', '80', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('5', '217', '208', '2021-01-15', '12', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('6', '272', '60', '2021-12-09', '253', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('7', '222', '295', '2019-05-18', '111', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('8', '75', '114', '2020-03-01', '106', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('9', '273', '205', '2021-11-29', '55', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('10', '274', '13', '2020-03-06', '174', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('11', '130', '32', '2021-08-21', '80', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('12', '294', '176', '2021-12-03', '224', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('13', '206', '145', '2019-05-10', '194', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('14', '26', '399', '2021-05-02', '133', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('15', '273', '97', '2020-03-28', '70', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('16', '23', '189', '2020-06-29', '262', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('17', '296', '211', '2019-04-15', '63', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('18', '175', '123', '2021-05-06', '196', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('19', '276', '294', '2021-01-23', '236', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('20', '177', '313', '2021-10-03', '254', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('21', '75', '263', '2019-11-03', '112', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('22', '67', '225', '2021-03-21', '76', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('23', '61', '66', '2020-11-09', '263', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('24', '142', '179', '2020-05-23', '112', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('25', '39', '129', '2021-08-11', '194', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('26', '219', '395', '2020-04-05', '215', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('27', '268', '155', '2021-09-12', '17', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('28', '114', '5', '2019-10-08', '155', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('29', '175', '376', '2020-04-19', '114', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('30', '92', '34', '2020-09-09', '195', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('31', '298', '132', '2021-04-18', '219', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('32', '79', '130', '2021-11-05', '148', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('33', '222', '218', '2019-02-28', '285', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('34', '145', '269', '2020-07-12', '153', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('35', '144', '364', '2021-08-07', '119', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('36', '260', '21', '2019-10-23', '275', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('37', '81', '278', '2019-05-20', '176', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('38', '164', '299', '2021-04-18', '72', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('39', '91', '233', '2019-11-27', '142', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('40', '32', '334', '2019-02-17', '200', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('41', '260', '50', '2019-05-26', '133', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('42', '51', '331', '2019-05-20', '194', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('43', '185', '286', '2019-11-22', '112', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('44', '84', '54', '2021-06-03', '223', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('45', '241', '246', '2019-05-25', '112', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('46', '201', '186', '2021-08-12', '144', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('47', '172', '335', '2020-03-03', '64', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('48', '124', '172', '2020-04-11', '184', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('49', '102', '100', '2021-11-23', '107', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('50', '166', '80', '2019-05-19', '134', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('51', '68', '236', '2019-08-02', '252', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('52', '230', '91', '2021-05-24', '209', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('53', '274', '159', '2019-06-21', '158', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('54', '300', '79', '2019-06-23', '216', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('55', '204', '283', '2020-11-17', '83', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('56', '82', '180', '2019-11-22', '167', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('57', '229', '11', '2021-11-22', '258', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('58', '255', '227', '2019-01-05', '204', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('59', '180', '124', '2019-11-26', '101', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('60', '27', '154', '2020-01-24', '213', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('61', '12', '373', '2019-08-02', '151', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('62', '289', '272', '2020-07-18', '168', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('63', '51', '93', '2019-05-31', '271', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('64', '23', '267', '2019-09-21', '276', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('65', '249', '146', '2020-11-14', '79', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('66', '195', '343', '2019-09-03', '133', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('67', '57', '109', '2020-02-21', '81', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('68', '103', '307', '2021-03-25', '215', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('69', '88', '309', '2019-08-10', '59', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('70', '284', '99', '2018-12-26', '258', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('71', '164', '25', '2019-08-06', '56', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('72', '123', '178', '2021-04-05', '116', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('73', '75', '45', '2019-03-05', '40', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('74', '37', '234', '2019-08-22', '267', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('75', '56', '394', '2021-09-15', '249', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('76', '81', '158', '2020-02-03', '127', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('77', '77', '240', '2021-08-02', '230', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('78', '254', '379', '2021-07-17', '77', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('79', '97', '327', '2020-07-26', '292', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('80', '195', '85', '2020-03-02', '269', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('81', '57', '340', '2020-05-24', '229', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('82', '61', '160', '2020-12-19', '247', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('83', '246', '243', '2020-12-02', '83', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('84', '271', '18', '2020-04-24', '5', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('85', '140', '221', '2019-11-27', '120', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('86', '74', '134', '2021-01-12', '33', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('87', '3', '256', '2020-05-19', '28', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('88', '204', '193', '2019-01-17', '169', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('89', '167', '143', '2021-01-25', '234', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('90', '135', '151', '2019-11-04', '26', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('91', '281', '288', '2019-02-24', '16', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('92', '157', '14', '2020-05-19', '115', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('93', '295', '65', '2021-08-20', '90', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('94', '236', '29', '2019-04-19', '103', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('95', '63', '68', '2021-12-08', '79', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('96', '180', '96', '2019-05-09', '41', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('97', '85', '87', '2021-03-03', '187', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('98', '225', '210', '2021-06-30', '87', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('99', '35', '181', '2019-05-29', '290', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('100', '172', '17', '2021-01-07', '157', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('101', '189', '235', '2020-12-05', '235', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('102', '269', '16', '2019-03-03', '182', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('103', '237', '375', '2021-12-10', '74', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('104', '267', '366', '2021-07-22', '107', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('105', '257', '285', '2020-09-30', '290', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('106', '263', '156', '2020-03-08', '271', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('107', '277', '19', '2020-08-09', '225', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('108', '44', '38', '2019-09-03', '235', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('109', '135', '70', '2020-08-28', '209', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('110', '126', '51', '2020-07-08', '170', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('111', '163', '111', '2021-02-03', '201', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('112', '248', '127', '2020-06-25', '209', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('113', '298', '26', '2020-08-29', '81', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('114', '91', '302', '2020-05-29', '105', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('115', '241', '259', '2020-08-06', '273', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('116', '129', '147', '2019-12-27', '37', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('117', '295', '317', '2019-01-16', '269', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('118', '206', '6', '2019-11-04', '19', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('119', '167', '316', '2021-01-21', '212', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('120', '171', '107', '2020-01-28', '208', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('121', '6', '40', '2019-08-09', '232', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('122', '56', '277', '2021-08-09', '226', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('123', '179', '260', '2021-08-29', '105', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('124', '75', '81', '2021-02-04', '58', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('125', '241', '148', '2019-08-09', '142', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('126', '78', '197', '2020-02-29', '150', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('127', '124', '64', '2021-05-23', '112', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('128', '295', '98', '2021-02-16', '233', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('129', '36', '321', '2019-09-25', '273', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('130', '52', '363', '2020-12-25', '179', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('131', '175', '342', '2019-05-30', '172', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('132', '193', '128', '2020-02-06', '238', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('133', '48', '153', '2021-11-17', '3', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('134', '45', '341', '2020-03-29', '115', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('135', '178', '58', '2020-05-12', '107', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('136', '128', '226', '2020-11-07', '98', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('137', '222', '192', '2021-11-26', '281', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('138', '51', '352', '2020-12-17', '289', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('139', '209', '67', '2020-09-02', '211', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('140', '54', '22', '2021-01-16', '17', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('141', '203', '200', '2019-10-28', '293', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('142', '290', '167', '2021-03-19', '130', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('143', '2', '131', '2019-06-05', '155', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('144', '297', '152', '2021-10-28', '91', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('145', '199', '161', '2019-08-23', '109', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('146', '282', '224', '2020-09-05', '118', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('147', '32', '74', '2021-07-28', '90', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('148', '104', '119', '2020-01-31', '76', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('149', '11', '368', '2021-01-01', '245', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('150', '45', '47', '2021-05-15', '146', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('151', '105', '358', '2021-10-27', '43', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('152', '222', '165', '2019-07-14', '216', '1');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('153', '125', '281', '2021-08-12', '212', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('154', '127', '213', '2019-05-28', '249', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('155', '137', '92', '2021-04-03', '1', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('156', '185', '392', '2019-02-13', '151', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('157', '211', '42', '2019-12-19', '170', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('158', '181', '371', '2020-04-11', '94', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('159', '182', '88', '2020-08-14', '243', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('160', '226', '348', '2019-08-22', '48', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('161', '80', '157', '2019-04-06', '275', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('162', '152', '35', '2021-10-17', '297', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('163', '119', '41', '2019-06-13', '207', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('164', '179', '219', '2019-05-22', '52', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('165', '50', '212', '2021-09-03', '101', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('166', '86', '76', '2019-04-20', '246', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('167', '126', '142', '2019-09-30', '38', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('168', '55', '36', '2019-04-25', '247', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('169', '35', '337', '2019-05-14', '248', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('170', '200', '380', '2019-02-23', '235', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('171', '115', '9', '2019-01-27', '262', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('172', '281', '393', '2021-11-14', '287', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('173', '106', '217', '2019-06-16', '222', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('174', '41', '82', '2019-03-08', '136', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('175', '209', '326', '2021-03-13', '231', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('176', '254', '113', '2020-05-31', '257', '3');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('177', '245', '185', '2021-04-02', '188', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('178', '166', '203', '2019-08-24', '156', '9');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('179', '160', '2', '2020-09-13', '278', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('180', '208', '271', '2021-05-03', '49', '11');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('181', '9', '355', '2020-08-16', '25', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('182', '43', '239', '2020-10-28', '14', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('183', '292', '377', '2021-11-05', '215', '7');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('184', '103', '49', '2021-01-12', '187', '6');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('185', '96', '253', '2018-12-27', '234', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('186', '77', '89', '2021-03-16', '209', '8');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('187', '68', '110', '2021-06-09', '164', '15');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('188', '64', '173', '2020-12-01', '182', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('189', '142', '175', '2019-11-24', '259', '5');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('190', '168', '222', '2020-10-07', '41', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('191', '252', '138', '2020-12-17', '189', '13');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('192', '198', '349', '2019-12-31', '49', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('193', '217', '57', '2021-09-16', '155', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('194', '159', '390', '2021-07-06', '70', '4');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('195', '75', '398', '2020-06-23', '275', '10');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('196', '66', '273', '2019-11-10', '35', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('197', '65', '332', '2019-11-14', '263', '14');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('198', '62', '254', '2021-03-30', '269', '12');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('199', '125', '378', '2020-03-12', '113', '2');
INSERT INTO `fine` (`id`, `man_id`, `photo_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('200', '95', '195', '2019-05-31', '164', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('289', '2019-09-15', '21', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('35', '2019-05-03', '241', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('77', '2019-12-25', '240', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('58', '2021-07-10', '149', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('111', '2021-07-23', '112', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('283', '2021-04-13', '11', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('228', '2021-10-05', '97', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('204', '2021-05-06', '37', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('152', '2019-02-22', '219', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('188', '2020-04-01', '300', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('212', '2019-07-21', '284', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('190', '2020-10-13', '88', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('36', '2020-05-21', '222', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('14', '2019-01-16', '156', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('222', '2020-04-03', '225', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('204', '2021-03-29', '207', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('249', '2021-04-23', '116', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('53', '2020-02-29', '59', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('232', '2019-03-31', '67', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('59', '2020-11-05', '189', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('6', '2019-01-08', '230', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('39', '2019-12-27', '181', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('297', '2021-07-24', '243', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('183', '2019-02-07', '15', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('28', '2019-05-16', '7', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('269', '2020-12-08', '92', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('267', '2021-08-12', '41', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('219', '2020-07-22', '68', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('95', '2020-05-17', '206', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('7', '2020-05-09', '278', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('144', '2021-01-22', '167', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('257', '2020-06-13', '263', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('146', '2020-12-05', '63', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('51', '2020-07-18', '300', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('14', '2020-06-15', '225', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('55', '2021-04-21', '167', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('103', '2019-04-29', '174', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('235', '2019-11-18', '220', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('254', '2019-08-02', '190', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('53', '2020-08-18', '238', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('157', '2020-04-06', '218', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('171', '2020-02-28', '62', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('135', '2021-06-17', '186', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('167', '2019-10-08', '255', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('23', '2019-03-24', '116', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('116', '2019-03-12', '135', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('255', '2020-07-22', '194', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('99', '2020-03-23', '3', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('283', '2019-11-20', '211', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('244', '2021-01-31', '280', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('164', '2019-07-28', '283', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('216', '2019-01-09', '248', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('255', '2019-12-25', '221', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('9', '2019-09-13', '267', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('228', '2021-09-24', '256', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('59', '2020-08-07', '153', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('170', '2021-10-17', '298', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('258', '2019-09-19', '161', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('38', '2020-04-07', '76', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('35', '2020-05-21', '220', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('81', '2020-09-05', '265', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('38', '2021-12-08', '140', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('264', '2019-02-04', '296', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('121', '2021-05-05', '127', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('292', '2020-06-15', '215', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('31', '2021-04-26', '90', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('48', '2020-05-29', '162', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('256', '2020-12-12', '259', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('132', '2020-08-24', '215', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('201', '2019-05-07', '262', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('147', '2019-07-03', '140', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('264', '2020-01-02', '221', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('245', '2021-07-24', '202', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('182', '2020-05-28', '124', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('99', '2019-11-27', '296', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('148', '2021-10-10', '101', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('143', '2019-10-20', '59', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('285', '2021-01-20', '7', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('113', '2021-09-07', '111', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('141', '2019-05-11', '67', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('149', '2020-09-21', '58', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('271', '2019-06-19', '243', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('95', '2020-01-16', '172', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('226', '2020-11-07', '231', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('30', '2019-12-16', '21', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('77', '2021-04-04', '111', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('46', '2021-12-19', '268', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('49', '2021-06-13', '220', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('68', '2019-06-12', '230', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('102', '2020-12-26', '295', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('25', '2019-04-18', '187', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('261', '2020-03-18', '105', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('242', '2021-10-23', '257', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('24', '2019-05-26', '183', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('24', '2020-02-21', '38', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('213', '2019-10-19', '8', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('159', '2021-01-20', '30', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('225', '2020-07-06', '164', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('254', '2019-11-10', '18', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('66', '2021-06-09', '294', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('64', '2019-02-19', '89', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('15', '2020-08-29', '149', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('199', '2020-09-03', '244', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('82', '2020-02-14', '297', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('26', '2020-04-08', '266', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('121', '2020-02-26', '144', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('253', '2020-06-21', '82', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('277', '2020-09-22', '270', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('191', '2019-04-12', '249', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('155', '2020-08-01', '146', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('55', '2021-01-14', '37', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('173', '2019-08-12', '180', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('180', '2020-06-23', '290', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('177', '2020-11-13', '242', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('203', '2019-12-25', '283', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('85', '2019-12-07', '184', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('100', '2019-10-30', '128', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('7', '2021-04-30', '41', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('98', '2019-11-30', '109', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('188', '2019-08-07', '123', '12');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('134', '2019-08-08', '15', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('2', '2019-01-20', '80', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('89', '2021-01-02', '59', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('229', '2019-08-15', '214', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('219', '2019-03-24', '69', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('144', '2020-01-20', '75', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('253', '2020-04-21', '129', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('267', '2021-03-16', '171', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('82', '2019-02-02', '27', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('51', '2021-06-20', '24', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('182', '2020-07-29', '285', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('207', '2019-11-19', '238', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('130', '2021-05-21', '185', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('295', '2021-09-03', '263', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('195', '2019-06-27', '118', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('159', '2020-02-27', '19', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('56', '2021-02-16', '31', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('22', '2021-03-19', '61', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('78', '2021-12-08', '49', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('9', '2019-03-23', '141', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('120', '2021-04-08', '240', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('99', '2021-01-04', '33', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('112', '2021-11-12', '206', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('65', '2021-09-13', '278', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('45', '2020-01-25', '14', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('201', '2019-07-15', '19', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('53', '2021-02-27', '191', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('171', '2021-11-29', '194', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('209', '2019-01-05', '189', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('243', '2020-09-07', '106', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('109', '2018-12-30', '37', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('121', '2020-11-16', '110', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('255', '2020-11-24', '118', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('190', '2020-05-22', '229', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('50', '2020-09-11', '290', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('60', '2019-10-23', '64', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('224', '2020-09-29', '193', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('40', '2020-05-28', '239', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('4', '2020-06-01', '143', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('185', '2020-12-30', '268', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('61', '2019-08-23', '147', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('195', '2020-06-21', '135', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('190', '2019-11-30', '205', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('233', '2020-05-03', '134', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('179', '2020-03-07', '237', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('232', '2020-04-02', '111', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('128', '2021-08-06', '219', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('244', '2021-12-06', '23', '8');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('36', '2021-11-16', '165', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('96', '2020-01-07', '288', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('54', '2021-05-04', '160', '1');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('299', '2020-04-04', '215', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('86', '2019-10-12', '267', '4');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('110', '2021-01-30', '121', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('127', '2019-12-17', '47', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('73', '2021-06-24', '139', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('218', '2019-02-16', '197', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('244', '2020-07-07', '215', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('284', '2020-05-30', '3', '10');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('198', '2019-12-03', '9', '7');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('73', '2021-11-03', '283', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('100', '2021-04-08', '69', '6');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('166', '2019-11-21', '73', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('156', '2020-01-27', '61', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('19', '2019-05-01', '129', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('277', '2021-03-20', '146', '9');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('197', '2020-03-10', '139', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('41', '2020-05-16', '259', '3');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('217', '2021-02-26', '256', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('191', '2021-10-02', '40', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('202', '2021-12-06', '182', '2');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('106', '2020-10-16', '275', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('159', '2019-11-22', '297', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('116', '2020-02-19', '290', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('220', '2020-09-22', '290', '13');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('68', '2019-07-11', '41', '11');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('135', '2019-08-15', '25', '15');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('193', '2019-01-04', '152', '5');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('300', '2020-08-11', '184', '14');
INSERT INTO `fine` (`man_id`, `fine_from`, `address_id`, `type_of_fine_id`) VALUES ('207', '2020-12-03', '230', '13');


-- к сожалению, в генераторе данных нет возможности сгенерировать марки и модели авто, вместо это выбрал названия компаний как бренд и люые слова как модель
INSERT INTO `car` VALUES (1,'Koepp Group','voluptatum','z839lh662','maroon',164,'NO'),
(2,'Cremin Ltd','occaecati','a330gp614','black',137,'YES'),
(3,'Steuber-Boyle','voluptatem','d007zo714','blue',256,'NO'),
(4,'Dare-Schulist','dolore','q410iu568','olive',194,'NO'),
(5,'Kuhic-Bradtke','incidunt','i234ov327','gray',55,'NO'),
(6,'Hartmann Ltd','laboriosam','y926dy422','black',287,'NO'),
(7,'Erdman-Kulas','consequatur','g562ik568','yellow',85,'NO'),
(8,'Torp, Conn and Durgan','voluptas','x110av442','teal',2,'YES'),
(9,'Greenholt, Bailey and Boyle','ut','j204cr832','lime',69,'NO'),
(10,'Moen, Cartwright and Feeney','voluptatibus','b651rf321','aqua',103,'YES'),
(11,'Kautzer and Sons','nesciunt','p608zg043','teal',32,'YES'),
(12,'Kilback-Reinger','sint','z354gq337','purple',294,'YES'),
(13,'Rogahn Ltd','voluptas','h095oc366','white',169,'NO'),
(14,'Durgan-Cummings','voluptatum','z303vx435','black',204,'YES'),
(15,'Mayert-Torp','numquam','w740mn891','blue',233,'YES'),
(16,'Tremblay and Sons','enim','i605vn261','navy',28,'YES'),
(17,'Ruecker, Cormier and Ryan','eius','m903mg628','yellow',217,'YES'),
(18,'Reichert-Connelly','ea','t564yw238','purple',241,'NO'),
(19,'Gerlach-Emard','qui','n940yb858','teal',136,'YES'),
(20,'Barton LLC','asperiores','u341as458','fuchsia',52,'NO'),
(21,'Stoltenberg Ltd','est','q012si408','lime',135,'YES'),
(22,'Hettinger, Feest and Hammes','exercitationem','g212bf837','blue',296,'YES'),
(23,'Steuber, Spinka and Donnelly','quia','p622nd982','purple',300,'YES'),
(24,'Boyle-Waelchi','totam','q891ao760','blue',191,'NO'),
(25,'Block, Bartell and Cummings','dolorum','m696gr547','black',223,'NO'),
(26,'Towne-Wisoky','dolorem','k551uz406','silver',3,'NO'),
(27,'Hilll-Sipes','et','p589mm147','silver',113,'NO'),
(28,'Kirlin, Waelchi and Reichel','quia','s762zt077','silver',215,'NO'),
(29,'Yundt LLC','ducimus','l787uj052','teal',41,'YES'),
(30,'Blanda-Beatty','tempore','i265ss369','black',230,'YES'),
(31,'White Inc','dolorem','n300kt808','black',185,'YES'),
(32,'Rippin-Reichel','error','m321kz124','lime',49,'YES'),
(33,'Murazik LLC','perspiciatis','i741wj059','yellow',160,'YES'),
(34,'Quigley-Bogan','hic','y562go543','green',81,'YES'),
(35,'Willms, Green and Wiegand','illo','x634wa303','white',12,'NO'),
(36,'Hansen-McGlynn','fugit','c675sl317','lime',44,'YES'),
(37,'Torphy Inc','qui','c771sr893','yellow',73,'NO'),
(38,'Kohler, Cartwright and Franecki','et','v062dl118','yellow',261,'YES'),
(39,'Reichert, Barton and Bechtelar','voluptates','n076ws876','navy',286,'YES'),
(40,'Stokes Ltd','maiores','j064rp387','green',58,'NO'),
(41,'Schmidt, Pollich and Kuphal','provident','n560di216','white',280,'YES'),
(42,'Ernser-Cremin','reiciendis','h664uo999','silver',279,'NO'),
(43,'Kris, Predovic and Rice','beatae','s366gw031','teal',290,'YES'),
(44,'Zieme-Kris','veritatis','l195dn636','purple',105,'YES'),
(45,'Padberg-Howell','quisquam','x861ii693','teal',147,'NO'),
(46,'Baumbach-Collins','dignissimos','x680ho300','gray',250,'NO'),
(47,'Kilback-Schmitt','ullam','j500qo148','gray',112,'YES'),
(48,'Hessel-Gutmann','soluta','s890ex013','maroon',102,'NO'),
(49,'Stracke LLC','et','q465no187','yellow',203,'NO'),
(50,'Stoltenberg, Marvin and Lakin','est','b269ae414','gray',139,'NO'),
(51,'Cartwright-Bergnaum','non','g263hb906','gray',53,'NO'),
(52,'Moore-Legros','eos','q914ai395','black',29,'YES'),
(53,'Pagac, Buckridge and Corwin','quas','m280dm521','white',165,'NO'),
(54,'Littel-Lueilwitz','atque','r900sr812','fuchsia',123,'NO'),
(55,'O\'Hara LLC','in','f193js811','aqua',38,'YES'),
(56,'Hayes-Pacocha','quis','m157bm209','white',72,'YES'),
(57,'Connelly, Schuppe and Schneider','id','h348nl953','aqua',149,'YES'),
(58,'Lind, Glover and Schmitt','veniam','g513kx290','navy',254,'YES'),
(59,'Kemmer, Hoeger and Halvorson','quia','g240vq904','black',11,'NO'),
(60,'Spencer Ltd','pariatur','j373ll775','lime',171,'YES'),
(61,'Dickinson Inc','voluptate','b422tk265','green',218,'YES'),
(62,'Bergnaum Ltd','excepturi','q172mt821','black',57,'YES'),
(63,'Murazik, Schaefer and Dicki','harum','x219bm492','teal',129,'YES'),
(64,'Beier-Greenfelder','eum','f652cq185','fuchsia',170,'NO'),
(65,'Bauch-Leffler','nam','i661xt124','aqua',195,'YES'),
(66,'Emmerich, Nolan and Langosh','alias','h025su280','silver',56,'YES'),
(67,'Parker PLC','voluptatem','e348hx553','fuchsia',46,'NO'),
(68,'Schmitt, Tromp and Hyatt','deleniti','r953rm872','yellow',163,'YES'),
(69,'Kemmer-Reinger','voluptatem','e288xm025','blue',257,'YES'),
(70,'Waelchi Ltd','eum','x862gb025','silver',43,'NO'),
(71,'Trantow-Kuhic','molestias','p869pf778','gray',61,'YES'),
(72,'Bergnaum, Funk and Kuphal','id','e475fb587','purple',224,'NO'),
(73,'Graham, Rohan and Hermann','harum','y806wp404','gray',214,'YES'),
(74,'Casper LLC','sint','y391ih006','black',157,'NO'),
(75,'Jones Inc','hic','m500mk658','lime',98,'YES'),
(76,'Dickens Inc','quia','d481wp360','teal',114,'NO'),
(77,'Dicki Inc','officia','m134wf513','lime',175,'YES'),
(78,'Farrell-Carroll','fugit','t454qk129','blue',216,'NO'),
(79,'Fay-Sawayn','neque','r781rw472','blue',68,'YES'),
(80,'Wolff, Mayert and Pfannerstill','dicta','o732vb107','teal',255,'NO'),
(81,'Kovacek Ltd','autem','f444vp460','lime',212,'NO'),
(82,'Cartwright, Roberts and Morissette','repudiandae','p212xr801','olive',10,'YES'),
(83,'Weissnat, Rempel and Bogisich','iste','x384wq991','navy',62,'NO'),
(84,'Jenkins-Deckow','assumenda','e525sg534','green',127,'YES'),
(85,'Bauch Inc','ad','c604me715','green',108,'NO'),
(86,'Kuvalis Group','qui','w409rh173','white',199,'YES'),
(87,'Gaylord Group','voluptatem','h387kl580','aqua',205,'NO'),
(88,'Rice, Zieme and Moen','possimus','j122ky084','navy',65,'YES'),
(89,'Goyette Group','fugiat','c605la214','aqua',15,'NO'),
(90,'Fadel, Torp and Kautzer','fugiat','o135is426','navy',126,'YES'),
(91,'Dooley, Rath and Abernathy','est','g689by945','navy',111,'YES'),
(92,'Schroeder, Treutel and Satterfield','non','f530hd633','purple',267,'NO'),
(93,'Kessler-O\'Kon','quas','k676gu090','navy',265,'NO'),
(94,'Collins, Glover and Collier','aut','v855pe223','purple',297,'NO'),
(95,'Kovacek, Farrell and Fadel','porro','o114ru695','maroon',196,'YES'),
(96,'Connelly PLC','perspiciatis','c956km803','silver',106,'YES'),
(97,'Ward-Terry','neque','c143pn706','white',202,'YES'),
(98,'Mayert, Pacocha and Nitzsche','aliquid','u702yw388','purple',104,'NO'),
(99,'Hahn LLC','odio','v282ld420','fuchsia',64,'YES'),
(100,'O\'Connell-Jacobs','repellendus','m327hh020','black',76,'NO');



INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('1', '35', '2020-09-29', '2021-07-23', 'Kutch LLC');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('2', '59', '2020-12-02', '2022-01-13', 'Trantow, Ryan and Zieme');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('3', '51', '2020-04-04', '2021-07-18', 'Kreiger, Johnson and VonRueden');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('4', '83', '2020-12-14', '2020-05-09', 'Weissnat, Mueller and Stroman');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('5', '46', '2020-04-20', '2020-01-21', 'Schamberger, Gutmann and McDermott');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('6', '4', '2020-10-07', '2021-05-04', 'Conn-Herman');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('7', '94', '2020-06-01', '2021-11-15', 'Lockman-Ledner');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('8', '81', '2020-05-02', '2020-11-17', 'Kertzmann-Schinner');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('9', '92', '2021-06-24', '2022-01-15', 'Altenwerth Inc');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('10', '93', '2021-08-05', '2021-01-23', 'Gutmann, Quigley and McKenzie');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('11', '22', '2021-10-14', '2020-12-08', 'Schumm Inc');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('12', '32', '2021-07-02', '2022-11-06', 'Murray, Ondricka and Bins');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('13', '41', '2021-09-09', '2022-10-25', 'Kling, Hintz and Rutherford');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('14', '70', '2021-09-21', '2020-11-13', 'Gusikowski-Kemmer');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('15', '100', '2020-12-08', '2020-05-26', 'Johnston, Johns and Lowe');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('16', '52', '2020-10-08', '2022-03-02', 'Volkman-Collier');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('17', '76', '2020-12-06', '2020-07-18', 'Robel-McLaughlin');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('18', '16', '2021-05-06', '2022-05-10', 'Spencer-Aufderhar');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('19', '96', '2020-04-20', '2021-02-21', 'Jacobs LLC');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('20', '91', '2020-11-15', '2021-06-17', 'Purdy, Hansen and Rolfson');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('21', '89', '2021-11-26', '2022-11-30', 'O\'Connell, Kessler and Koss');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('22', '45', '2021-11-22', '2022-12-03', 'Christiansen-Blanda');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('23', '95', '2020-05-29', '2022-06-16', 'Halvorson, Turcotte and Hamill');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('24', '56', '2021-09-19', '2020-11-07', 'Macejkovic Group');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('25', '36', '2021-07-25', '2021-08-07', 'Balistreri-Hauck');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('26', '30', '2020-10-28', '2022-10-19', 'Grimes-Jast');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('27', '38', '2021-06-14', '2020-06-03', 'Klein Ltd');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('28', '55', '2021-01-30', '2022-07-11', 'McCullough, Marquardt and Becker');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('29', '40', '2021-07-17', '2021-07-14', 'Wilkinson-Sipes');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('30', '62', '2021-05-26', '2020-04-08', 'Reynolds Inc');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('31', '68', '2021-12-04', '2021-07-01', 'Kiehn, Parker and Harris');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('32', '66', '2020-10-31', '2021-09-12', 'Schaefer, Upton and Rippin');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('33', '37', '2020-08-22', '2022-10-11', 'Jerde-Crona');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('34', '2', '2021-06-21', '2021-12-09', 'Terry-Littel');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('35', '44', '2021-02-28', '2020-04-20', 'Moore-Zboncak');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('36', '43', '2020-03-14', '2021-01-03', 'Kuhn-Schuster');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('37', '8', '2020-05-03', '2021-01-09', 'Fahey-Stracke');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('38', '27', '2021-06-11', '2022-09-19', 'Trantow, Lynch and Barrows');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('39', '19', '2021-08-01', '2020-03-26', 'Hilll-Herzog');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('40', '61', '2020-02-15', '2022-01-13', 'Mitchell, Wehner and Haag');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('41', '3', '2020-12-07', '2020-09-17', 'Bailey-Carter');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('42', '78', '2021-08-03', '2021-03-03', 'Wehner LLC');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('43', '17', '2020-08-31', '2022-10-11', 'Volkman PLC');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('44', '98', '2020-12-20', '2022-02-17', 'Anderson, Roberts and Wilderman');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('45', '75', '2020-05-25', '2020-08-22', 'Pagac-Kris');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('46', '77', '2020-04-29', '2022-06-15', 'Swaniawski, Stanton and Murphy');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('47', '20', '2021-03-03', '2021-03-02', 'McClure, Armstrong and Schimmel');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('48', '53', '2021-10-27', '2021-10-18', 'Marks Ltd');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('49', '33', '2020-05-12', '2022-08-05', 'Dicki, Hahn and Osinski');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('50', '67', '2020-07-27', '2020-07-14', 'Hodkiewicz, Conroy and Kuvalis');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('51', '9', '2020-01-02', '2020-11-21', 'Nikolaus, Schroeder and Prohaska');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('52', '31', '2020-05-03', '2022-04-06', 'Gerhold Group');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('53', '72', '2020-01-18', '2022-08-01', 'Schmitt Group');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('54', '82', '2021-05-17', '2022-05-03', 'Shanahan Ltd');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('55', '10', '2019-12-22', '2020-05-06', 'Pagac and Sons');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('56', '11', '2021-04-25', '2020-08-13', 'Auer and Sons');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('57', '57', '2021-01-25', '2022-06-01', 'Walsh-Bahringer');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('58', '5', '2020-06-20', '2022-11-12', 'Runolfsdottir, Schinner and Gutmann');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('59', '34', '2020-01-18', '2020-12-24', 'Brakus-Runolfsdottir');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('60', '63', '2021-04-19', '2020-11-03', 'Jerde and Sons');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('61', '84', '2020-01-10', '2020-08-04', 'Padberg Group');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('62', '74', '2021-11-10', '2021-03-05', 'Mertz-Stroman');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('63', '99', '2020-06-15', '2022-12-05', 'Ledner-Treutel');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('64', '21', '2020-08-17', '2020-09-12', 'Hauck-Homenick');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('65', '73', '2020-02-19', '2021-12-08', 'Walker-Deckow');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('66', '29', '2021-05-05', '2021-04-09', 'Jenkins, Lowe and Howell');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('67', '42', '2021-09-01', '2021-03-09', 'Schmidt, Mante and Ortiz');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('68', '14', '2021-07-19', '2022-07-30', 'Nader-Parisian');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('69', '28', '2020-04-06', '2022-03-06', 'Stiedemann PLC');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('70', '6', '2021-02-12', '2020-12-06', 'Auer-Macejkovic');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('71', '24', '2020-09-29', '2022-12-05', 'Stoltenberg Ltd');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('72', '50', '2021-03-12', '2021-06-22', 'McDermott-Wiegand');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('73', '47', '2020-07-07', '2020-02-04', 'Koepp, Gleason and Tromp');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('74', '88', '2021-09-28', '2022-06-20', 'Bradtke, Windler and Bosco');
INSERT INTO `osago` (`id`, `car_id`, `created_at`, `validity_period`, `insurance_agent`) VALUES ('75', '97', '2020-05-02', '2021-02-23', 'Goldner Group');


