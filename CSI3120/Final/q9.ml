let rec find_min (min_so_far:int) (xs:int list) =
match xs with
| [] -> min_so_far
| h::t -> if h < min_so_far
then find_min h t
else find_min min_so_far t

exception ProductIsZero
exception NegativeInList of int
let rec product_cp (xs:int list) (k:int -> int) : int =
match xs with
| [] -> (k 1)
| h::t -> if h = 0 then raise ProductIsZero
else if h < 0 then raise (NegativeInList (find_min h t))
else product_cp t (fun x -> k (h * x))

let try_product_cp (xs:int list) : int =
try product_cp xs (fun x -> x)
with | ProductIsZero -> 0
| NegativeInList x -> x * 2

let list0 = [9;80]
let list1 = [9;0;80]
let x0 = try_product_cp list0
let x1 = try_product_cp list1

let rec new_product_cp (xs:int list) (k:int -> int)
                       (zerok: int) (negk: int->int list->int) : int =
  match xs with
  | [] -> (k 1)
  | h::t -> (
      if h = 0 then 
        zerok
      else if h < 0 then
        negk h t
      else
        new_product_cp t (fun x -> k (h * x)) zerok negk
  )

let new_try_product_cp (xs:int list) : int = new_product_cp xs (fun x -> x) 0 (fun (cur:int) (xs:int list) -> find_min cur xs)

let x00 = new_try_product_cp list0
let x11 = new_try_product_cp list1