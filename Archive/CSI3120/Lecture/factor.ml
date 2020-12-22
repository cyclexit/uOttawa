let rec map (f: 'a -> 'b) (xs: 'a list) : 'b list = 
    match xs with
    | [] -> []
    | hd::tl -> (f hd)::(map f tl)