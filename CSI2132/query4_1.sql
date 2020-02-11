set search_path = "lab";

select avg(aw.price) as avg_price, aw.arttype
from artwork as aw
where aw.created_year > 1490
group by aw.arttype
having count(*) >= 2;