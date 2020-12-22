let both f (x,y) = (f x, f y)
let do_fst f (x,y) = (f x, y)
let do_snd f (x,y) = (x, f y)
(*
both : ('a -> 'b) -> 'a * 'a -> 'b * 'b
do_fst : ('a -> 'b) -> 'a * 'c -> 'b * 'c
do_snd : ('a -> 'b) -> 'c * 'a -> 'c * 'b
*)

let idouble x = 2 * x
let fdouble x = 2. *. x
let iaverage p = let (x,y) = p in (float_of_int (x + y)) /. 2.
let faverage p = let (x,y) = p in (x +. y) /. 2.0
let swap p = let (x,y) = p in (y,x)
let min p = let (x,y) = p in if x < y then x else y
let max p = let (x,y) = p in if x > y then x else y

let f x =
  x |> both (do_snd fdouble)
    |> do_fst (both int_of_float)
    |> do_fst min
    |> do_snd max

let example = ((75.3,45.2),(88.9,40.0))