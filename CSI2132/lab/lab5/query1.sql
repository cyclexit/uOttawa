set search_path = "lab";

select customer.custid, custname
from customer, likeartist
where customer.custid = likeartist.custid
    and likeartist.artistname = 'Picasso';