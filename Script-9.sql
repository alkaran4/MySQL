use vk;

-- 1

select m.from_user_id, count(*) from users u 
join messages m on u.id = m.from_user_id 
join friend_requests fr 
	on (fr.initiator_user_id = 1 and fr.target_user_id = m.from_user_id) 
	or (fr.target_user_id = 1 and fr.initiator_user_id = m.from_user_id)
where m.to_user_id = 1 and fr.status = 'approved'
group by m.from_user_id
order by count(*) desc;

-- 2 

select count(*)
from profiles p 
join media m on p.user_id = m.user_id
join likes l on l.media_id = m.id 
where TIMESTAMPDIFF(year, p.birthday, now()) < 10;

-- 3 

select count(*), p.gender 
from likes l 
join profiles p on l.user_id = p.user_id group by gender;
