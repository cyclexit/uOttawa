(* Question 1 *)
(* Recall the following pipe combinator and pair combinators: *)

(* let (|>) x f = f x *)
let both   f (x,y) = (f x, f y)
let do_fst f (x,y) = (f x,   y)
let do_snd f (x,y) = (  x, f y)

(* 1(a). Define a function that uses these combinators and applies the
   following operations to its input argument.  The argument must be
   a pair of pairs where each element has type float,
   e.g. ((75.3,45.2),(88.9,40.0))

   1. double the second element of each pair
   2. replace the first pair with the minumum of its two elements
   3. replace the second pair with the maximum of its two elements
   4. return the average of the remaining elements

   You may use the "double", "min", "max", and "average" functions below. *)

let double x = 2. *. x
let min (p:float*float) =
  let (x,y) = p in
  if x < y then x else y
let max (p:float*float) =
  let (x,y) = p in
  if x > y then x else y
let average (p:float*float) =
  let (x,y) = p in (x +. y) /. 2.0

(* 1(b). What is the type of your function? *)


(* Question 2 *)
(* Consider the following function in Concurrent ML:

let f2 (x:bool) (y:bool) (result:bool ref) =
  spawn (fn () => (if x = true then result := true));
  spawn (fn () => (if y = true then result := true));
  if (x = false && y = false) then result := false *)

(* 2(a). Assume that each test and each assignment statement is
   executed atomically.  Describe all the possible evaluation orders
   of the statements in the parent process and the two child
   processes.  Hint: first draw a diagram like the one on page 36 of
   the course notes for Mitchell Chapter 14.

   2(b) What operation does this function implement?
 *)


(* Question 3 *)
(* Consider the following OCaml code: *)
      
let point (x:float) (y:float) = object
    val mutable x_coord = x
    val mutable y_coord = y
    method get_x = x
    method get_y = y
    method move x y =
      (x_coord <- x;
       y_coord <- y)
  end

type primary_colour = Red | Yellow | Blue
type colour = Primary of primary_colour | Green | Orange | Purple
              | Garnet | Other of string

let coloured_point (x:float) (y:float) (c:colour) = object
    val mutable x_coord = x
    val mutable y_coord = y
    val mutable colour = c
    method get_x = x
    method get_y = y
    method move x y =
      (x_coord <- x;
       y_coord <- y)
    method get_colour = c
    method change_colour c =
      colour <- c
  end

let p = point 1.0 2.3
(* val p : < get_x : float; get_y : float; move : float -> float -> unit > =
   <obj> *)
let cp = coloured_point 5.2 3.0 (Primary Red)
(* val cp :
  < change_colour : colour -> unit; get_colour : colour;
    get_x : float; get_y : float; move : float -> float -> unit > =
  <obj> *)

let double_and_move p =
  let new_x = (p#get_x) *. 2.0 in
  let new_y = (p#get_y) *. 2.0 in
  (p#move new_x new_y;
   (new_x,new_y))

let has_primary_colour p =
  let c = (p#get_colour) in
  match c with
  | Primary _ -> true
  | _ -> false

(* 3(a). Note the types of objects "p" and "cp".  Is one a subtype of
   the other?  If not, why not? If so, which one is the subtype and
   which one is the type? 

   What do the following expressions evaluate to?
   3(b). double_and_move p;;
   3(c). double_and_move cp;;
   3(d). has_primary_colour p;;
   3(e). has_primary_colour cp;;
 *)
       

(* Question 4. *)
(* Recall the grammars for assertions, booleans, expressions, and
   program statements.

   P ::= B | P and P | P or P | not P | P => P
   B ::= true | false | E = E | E <> E | E > E | E < E |
         E <= E | E >= E | ...
   E ::= x | n | E + E | E – E | E * E | E / E | E! | ...
   S ::= x := E | S;S | if B then S else S |
         while B do S end

   Find a program (from grammar S) such that the following
   Hoare triple can be proved using the inference rules of Hoare
   logic:

   { true } <your program> { ( a>0 => b<x+y ) and ((not(a>0)) => b=x-2) }

 *)


(* Question 5. *)
(* Consider the following program and Hoare triple.

   { y > 0 }
   a := x;
   b := 0;
   while b <> y do
        a := a-1;
        b := b+1
   end
   { a = x-y }

   Find a loop invariant for the loop in the above program that
   can be used to prove that the above Hoare triple is true.  (Hint:
   use the method we used in class to find an invariant.  An example
   of this method is shown on page 10 of the solutions to Lab 4.)

 *)

  
(* Question 6. *)
(* Using the data structure below, write a function that takes an
   integer x and an integer tree t and returns the integer leaf value
   from t that is closes in absolute value to x *)

type 'a tree = 
  | Leaf of 'a
  | Node of 'a tree * 'a tree


(* Question 7. *)
(* The signature below is for a module that defines a pair data
   type. *)

module type PAIR = 
  sig
    type 'a pair

    (* init_pair x returns the pair (x,x) *)
    val init_pair : 'a -> 'a pair

    (* lookup a n returns an option, where the value is the element of
       the pair at index n.  Valid indices are 1 and 2.  If the index
       n is not 1 or 2, None is returned. *)
    val lookup : 'a pair -> int -> 'a option

    (* replace p n m returns a pair where the value at index n in p is
       replaced by the value m.  If the index is not valid, the input
       pair is returned as the result. *)
    val replace : 'a pair -> int -> 'a -> 'a pair
  end

(* 7(a). Two incomplete implementations of the pair datatype are below.
   Complete these partial implementations by instantiating the type

   'a pair

   in two different ways and implementing one of the three operations.
   In the first partial implementation, write the init_pair function.
   In the second implementation, write the lookup function.

module Pair1 : PAIR =
  struct
    type 'a pair = (* type goes here *)

    let init_pair (x:'a) : 'a pair =
    (* your implementation here *)

    ...
  end

module Pair1 : PAIR =
  struct
    type 'a pair = (* type goes here *)

    let rec lookup (p:'a pair) (i:int) : 'a option =
    (* your implementation here *)

    ...
  end *)

(* 7(b). Fill in the types of the imperative version of the PAIR
   signature below.

module type IMP_PAIR = 
  sig
    type 'a pair
    val init_pair : (* fill in type *)

    val lookup : (* fill in type *)

    val replace : (* fill in type *)

 *)

