module type RANGE =
sig
  (* types *)
  (* RANGE type *)
  type t
  (* element type *)
  type e

  (* constructors *)
  (* construct a one-item range *)
  val singleton : e -> t
  (* construct a range with two endpoints, inclusive *)
  val range : e -> e -> t

  (* modifiers *)
  (* scalar multiply range, e.g. if r is a range from 2 through 4,
     smult r 3 produces a range from 6 through 12. 
     This operation may change the size of a range. *)                        
  val smult : t -> e -> t

  (* observers *)
  (* how many elements are in the range? *)
  val size : t -> int
end

module LoHiPairRange : RANGE with type e = int =
struct
  type e = int
  type t = e * e
  let singleton (i:e) : t = (i,i)
  let range (i:e) (j:e) : t = ((min i j), (max i j))
  let smult (x:t) (i:e) : t =
    let (lo, hi) = x in
    if i >= 0 then (lo*i,hi*i)
    else (hi*i,lo*i)
  let size (x:t) : int =
    let (lo,hi) = x in
    hi - lo - (-1)
end

(*a*)
type range_t =
| Point of int
| Interval of int * int

module LoHiRange : RANGE with type e = int =
struct
  type e = int
  type t = range_t
  let singleton (i:e) : t = Point i
  let range (i:e) (j:e) : t = Interval (min i j,max i j)
  let smult (x:t) (i:e) : t =
    match x with
    | Point x -> Point (x*i)
    | Interval (low, high) -> (
        if i >= 0 then
            Interval ((low * i), (high * i))
        else
            Interval ((high * i), (low * i))
    )
  let size (x:t) : int = 
    match x with
    | Point _ -> 1
    | Interval (low, high) -> high - low + 1
end

(*b*)
let pt = LoHiRange.singleton 2
let rg = LoHiRange.range 1 3
let _ = LoHiRange.smult pt (-1)
let _ = LoHiRange.smult rg (-2)
let _ = LoHiRange.size pt
let _ = LoHiRange.size rg