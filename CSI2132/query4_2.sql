set search_path = "lab";

select avg(artwork.price) as avg_price
from artwork
where
    artwork.arttype in (
        select aw.arttype
            from artwork as aw
            group by aw.arttype
            having count(*) >= 2
    )
    and artwork.created_year >= 1490
group by artwork.arttype;