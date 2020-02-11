set search_path = "lab";

select cust.custname
from customer as cust
where not exists (
    select ats.artistname
    from artist as ats
    where not exists (
        select la.artistname
        from likeartist as la
        where la.custid = cust.custid
            and la.artistname = ats.artistname
    )
);