use vk;

-- Операторы, фильтрация, ограничения

-- 1


INSERT INTO vk.media
(media_type_id, user_id, body, filename, `size`)
values
(1, 1, '251qewfe', '1123rqw', 544),
(2, 2, '251qeawfe', '112wefz3rqw', 544),
(3, 3, '251qewqfe', '112asdfb3rqw', 544)
;

UPDATE vk.media
SET created_at=current_timestamp() , updated_at=current_timestamp()  
; 

-- 2

ALTER TABLE vk.media MODIFY COLUMN created_at DATEtime DEFAULT CURRENT_TIMESTAMP  null;
ALTER TABLE vk.media MODIFY COLUMN updated_at DATEtime DEFAULT CURRENT_TIMESTAMP  NULL;


-- 3



select 
	`count`, 
	user_id, 
	media_id 
from views
where `count` != 0
;

-- 4

select convert(datetime, '6-8-2010', 101);

-- Агрегация данных

-- 1 посчитать средний возраст

select sum(TIMESTAMPDIFF(year, birthday, now()))/count(*) as age from profiles;

-- 2 посчитать количество дней рождений на каждый из дней недели

select
count(*),
weekday(concat(year(now()), '-', substring(birthday, 6, 5))) as `day_of_week`,
birthday 
from profiles
group by `day_of_week`
order by `day_of_week`;
*/

