set search_path = "lab";

select distinct c1.custname
from customer as c1, likeartist as la1, artist as a1
where la1.custid = c1.custid
	and la1.artistname = a1.artistname
	and a1.birthplace = 'Malaga'
	and c1.custid in (
		select c2.custid
		from customer as c2, likeartist as la2, artist as a2
		where la2.custid = c2.custid
			and la2.artistname = a2.artistname
			and a2.birthplace = 'Florence'
	)