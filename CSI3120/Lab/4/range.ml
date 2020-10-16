(* A condensed version of the signature in range.mli.  Your first step is to study the contents of range.mli. *)
module type RANGE =
sig
  type t
  type e
  val singleton : e -> t
  val range : e -> e -> t
  val sadd : t -> e -> t
  val smult : t -> e -> t
  val bridge : t -> t -> t
  val size : t -> int
  val contains : t -> e -> bool
  val rless : t -> t -> bool option
end

(* An implementation of the RANGE datatype with int as range type and
   pairs representing a range *)
  module LoHiPairRange : RANGE with type e = int =
struct
  type e = int
  type t = e * e
  let singleton (i:e) : t = (i,i)
  let range (i:e) (j:e) : t = ((min i j), (max i j))
  let sadd (x:t) (i:e) : t = let (lo,hi) = x in (lo+i,hi+i)
  let smult (x:t) (i:e) : t =
    let (lo, hi) = x in
    if i >= 0 then (lo*i,hi*i)
    else (hi*i,lo*i)
  let bridge (x:t) (y:t) : t =
    let (lx, hx) = x in
    let (ly, hy) = y in
    ((min lx ly), (max hx hy))
  let size (x:t) : int =
    let (lo,hi) = x in
    hi - lo - (-1)
  let contains (x:t) (i:e) : bool =
    let (lo,hi) = x in
    (lo <= i) && (i <= hi)
  let rless (x:t) (y:t) : bool option =
    let (lx, hx) = x in
    let (ly, hy) = y in
    if hx < ly then Some true
    else if hy < lx then Some false
    else None
end

(* Exercise 1: Complete the new implementation of RANGE in the
     ListRange module below.  The part that is already implemented
     should give you enough information to implement the rest.  Add
     some test code to test your implementation. *)
    
(* An implementation of the RANGE datatype with int as range type and
   lists representing a range *)
module ListRange : RANGE with type e = int =
struct
  type e = int
  type t = e list

  (* auxiliary functions *)
  let minmax (l:t) : (e*e) option =
      let rec max (t:t) (e:e) : e =
          match t with
          | [] -> e
          | h::r -> max r h
      in
      match l with
      | [] -> None
      | h::r -> Some (h, (max r h))
  let rec build (i:e) (j:e) : e list =
    if i = j then [j]
    else i :: build (i+1) j
  
  (* interfacce functions *)
  let singleton (i:e) : t = [i]
  let range (i:e) (j:e) : t = build (min i j) (max i j)
  
  (* TODO Exercise 1: Replace all the code below with correct implementations of the operations. *)
  let sadd (x:t) (i:e) : t =
    match (minmax x) with
    | None -> []
    | Some (lx, hx) -> build (lx + i) (hx + i)

  let smult (x:t) (i:e) : t =
    match (minmax x) with
    | None -> []
    | Some (lx, hx) -> build (lx * i) (hx * i)
  
  let bridge (x:t) (y:t) : t =
    match ((minmax x), (minmax y)) with
    | (None, None) -> []
    | (Some (_, _), None) -> x
    | (None, Some (_, _)) -> y
    | (Some (lx, hx), Some (ly, hy)) -> build (min lx ly) (max hx hy)
  
  let size (x:t) : int = 
    let rec aux_size (x:t) (i:int) : int =
      match x with
      | [] -> i
      | _::tl -> aux_size tl (i + 1)
    in
      aux_size x 0
  
  let contains (x:t) (i:e) : bool =
    match (minmax x) with
    | None -> false
    | Some (lx, hx) -> (lx <= i) && (i <= hx)
  
  let rless (x:t) (y:t) : bool option =
    match ((minmax x), (minmax y)) with
    | (None, None) -> None
    | (Some (_, _), None) -> None
    | (None, Some (_, _)) -> None
    | (Some (lx, hx), Some (ly, hy)) -> Some (hx < ly)

end

(* TODO Exercise 1: Add some test code to test your new implementation. *)
let rg = ListRange.range 2 4
let rg_size = ListRange.size rg
let rg_contains_3 = ListRange.contains rg 3
let rg_contains_5 = ListRange.contains rg 5

let rg1 = ListRange.singleton 6
let rg1_size = ListRange.size rg1
let rg1_contains_6 = ListRange.contains rg1 6

let rg2 = ListRange.sadd rg 2
let rg2_size = ListRange.size rg2
let rg2_contains_5 = ListRange.contains rg2 5

let rg3 = ListRange.smult rg 3
let rg3_size = ListRange.size rg3
let rg3_contains_12 = ListRange.contains rg3 12

let rg4 = ListRange.bridge rg rg3
let rg4_size = ListRange.size rg4
let rg4_contains_2 = ListRange.contains rg4 2
let rg4_contains_12 = ListRange.contains rg4 12

let rg_rless_rg1 = ListRange.rless rg rg1
let rg_rless_rg2 = ListRange.rless rg rg2
let rg_rless_rg3 = ListRange.rless rg rg3
let rg_rless_rg4 = ListRange.rless rg rg4

(* Exercise 2: Design an imperative version of RANGE.  Do so by
   copying range.mli here and changing the types as necessary.  And
   then copy the implementation of LoHiPairRange and modify the code
   as necessary.  All the operations should remain the same as in the
   functional version.  The singleton and range operations should each
   create a new range.  The sadd and smult operations should modify
   existing ranges. Consider the design choices and design your own
   version of bridge. *)
