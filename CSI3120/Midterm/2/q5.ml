(* Code for the part (a) *)

exception QuotientIsZero
let quotient (xs:int list) : int =
  let rec aux (ls:int list) (t:int) : int =
    if t = 0 then
      raise QuotientIsZero
    else
      match ls with
      | [] -> t
      | hd::tl -> aux tl (t / hd)
  in
  match xs with
  | [] -> 1
  | hd::tl -> aux tl hd

(*
let testa1 = quotient [100; 2; 6]
let testa2 = quotient [100; 2; 5]
let testa3 = quotient [10; 3; 0; 5; 0]
let testa4 = quotient [10; 5; 3; 4]
*)

(* Code for the part (b) *)

let rec member (xs:'a list) (x:'a) : bool =
  match xs with
  | [] -> false
  | h::t -> if h = x then true else member t x

exception NotFound
let rec findpos (xs:'a list) (x:'a) : int =
  match xs with
  | [] -> raise NotFound
  | h::t -> if h = x then 1 else ((findpos t x) + 1)

exception ZeroInListAtPos of int
let div_list (xs:int list) : int =
  if member xs 0 then
    raise (ZeroInListAtPos (findpos xs 0))
  else
    quotient xs
(*
let testb1 = div_list [100; 2; 6]
let testb2 = div_list [100; 2; 5]
let testb3 = div_list [10; 3; 0; 5; 0]
let testb4 = div_list [10; 5; 3; 4]
*)