use `shop`;

-- 1 

select user_id from orders group by user_id;

-- 2

select id, name, desription, price, catalog_id, (select name from catalogs where id = products.catalog_id) as `type_of_product` 
from products;

-- 3

create database `flight`;
use `flight`;

drop table if exists `flights`;
create table `flights` (
id serial primary key,
`from` varchar(255),
`to`varchar(255)
);

drop table if exists `cities`;
create table `cities`(
`label` varchar(255) primary key,
`name` varchar(255)
);

INSERT INTO flight.flights
(`from`, `to`)
values
('moscow', 'novgorod'),
('novgorod', 'kazan'),
('irkutsk', ''),
('omsk', 'moscow'),
('moscow', 'irkutsk');

INSERT INTO flight.cities
(label, name)
values
('moscow', 'москва'),
('novgorod', 'новгород'),
('irkutsk', 'иркутск'),
('omsk', 'омск'),
('kazan', 'казань');

select name as `from` from cities where label in (select `from` from flights);
-- больше ни до чего не додумался



