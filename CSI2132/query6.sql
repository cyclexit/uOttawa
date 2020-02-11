set search_path = "lab";

select tmp.arttype, tmp.avg_price
from (
    select aw.arttype, avg(aw.price) as avg_price
    from artwork as aw
    group by aw.arttype
) as tmp
where tmp.avg_price = (
    select min(tmp1.avg_price)
    from (
        select aw.arttype, avg(aw.price) as avg_price
        from artwork as aw
        group by aw.arttype
    ) as tmp1
);