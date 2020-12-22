let rec prods (xs : (int * int) list) : int list = 
    match xs with
    | [] -> []
    | (x, y)::tl -> (x * y)::(prods tl);;

let _ = 
    prods [(2, 3); (4, 7); (5, 2)]