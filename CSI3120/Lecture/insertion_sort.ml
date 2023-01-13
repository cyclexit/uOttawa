let rec insert (x : int) (sorted : int list) : int list = 
    match sorted with
    | [] -> [x]
    | hd::tl ->
        if hd < x then
            hd::(insert x tl)
        else
            x::sorted

let insertion_sort (xs : int list) : (int list) =
    let rec aux (sorted : int list) (unsorted : int list) : int list = 
        match unsorted with
        | [] -> sorted
        | hd::tl -> aux (insert hd sorted) tl
    in
    aux [] xs
