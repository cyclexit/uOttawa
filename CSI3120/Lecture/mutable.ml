type 'a mlist = Nil | Cons of 'a * ('a mlist ref)

let rec mlength (m:'a mlist) : int =
    match m with
    | Nil -> 0
    | Cons(h, t) -> 1 + mlength(!t)

let rec mappend xs ys = 
    match xs with
    | Nil -> ()
    | Cons(h, t) ->
        (match !t with
        | Nil -> t := ys
        | Cons(_, _) as m -> mappend m ys)