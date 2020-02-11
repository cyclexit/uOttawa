set search_path = "lab"; 

select customer.custname
from customer, likeartist, artist
where customer.amount > 30000
    and customer.custid = likeartist.custid
    and artist.artistname = likeartist.artistname
    and artist.artstyle = 'Cubism';