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

(* Solution to 1(a): *)
let f1 x =
  x |> both (do_snd double)
    |> do_fst min
    |> do_snd max
    |> average

let example = ((75.3,45.2),(88.9,40.0))
let _ = f1 example
(* - : float = 77.65 *)

(* 1(b). What is the type of your function? *)
let _ = f1
(* Solution:
- : (float * float) * (float * float) -> float = <fun> *)


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

Solution: The following diagram (similar to one in the course notes)
   shows the constraints on the order of execution of evaluation, with
   the additional property that the boxes marked with a ** only are
   executed when the test evaluates to true.

                    ---------     ---------------
                 ->|x = true?|-->|result:=true **|
                /   ---------     ---------------
 ------------  /    ---------     ---------------
|begin parent|---->|y = true?|-->|result:=true **|
 ------------ \     ---------     ---------------
               \    -----------------------     ----------------
                 ->|x = false && y = false?|-->|result:=false **|
                    -----------------------     ---------------- 

   The possible orderings depend on the values of x and y.  For
   example, the possible orderings when x = true and y = true include

   x = true; result:= true; y = true; result:=true; x = false && y == false;
   x = true; result:= true; y = true; x = false && y == false; result:=true;
   x = true; result:= true; x = false && y == false; y = true; result:=true;
   x = true; x = false && y == false; result:= true; y = true; result:=true;
   x = false && y == false; x = true; result:= true; y = true; result:=true;

   as well as all others where one of the "result:=true" instructions
   occurs somewhere after "x = true" and the other "result:=true"
   occurs somewhere after "y=true"

   2(b) What operation does this function implement?
   Solution: boolean "or"
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
type colour = Primary of primary_colour | Green | Orange | Purple | Garnet | Other of string

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
   Solution: The type of cp is a subtype of the type of p because
   it includes all the same methods, plus additional methods.

   What do the following expressions evaluate to?
   3(b). double_and_move p;;
   Solution:
- : float * float = (2., 4.6)
   3(c). double_and_move cp;;
   Solution:
- : float * float = (10.4, 6.) 
   3(d). has_primary_colour p;;
   Solution:
   Error: This expression has type
         < get_x : float; get_y : float; move : float -> float -> unit >
       but an expression was expected of type < get_colour : colour; .. >
       The first object type has no method get_colour 
   3(e). has_primary_colour cp;;
   Solution:
- : bool = true
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

   Solution: if a>0 then b:=x+y-1 else b:=x-2
   Note: there are many other solutions.  Here is another example:
   if a>0 then b:=x+y-2 else (b:=x; b:=b-2)

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

   Solution: A possible invariant is: a = x-b
 *)


(* Question 6. *)
(* Using the data structure below, write a function that takes an
   integer x and an integer tree t and returns the integer leaf value
   from t that is closes in absolute value to x *)

type 'a tree = 
  | Leaf of 'a
  | Node of 'a tree * 'a tree

(* Some solutions: *)

let rec closest1 x t =
  match t with
  | Leaf y -> y
  | Node (t1,t2) ->
     let left = closest1 x t1 in
     let right = closest1 x t2 in
     if abs (x - left) < abs (x - right) then left else right

exception Found
let closest2 x t =
  let rec closest_aux t =
    match t with
    | Leaf y -> if x = y then raise Found else y
    | Node (t1,t2) ->
       let left = closest_aux t1 in
       let right = closest_aux t2 in
       if abs (x - left) < abs (x - right) then left else right in
  try closest_aux t with | Found -> x


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
   In the second implementation, write the lookup function. *)

(* Solution: There are three possible solutions below. *)
module PairPair : PAIR =
  struct
    type 'a pair = ('a * 'a)

    let init_pair (x:'a) : 'a pair = (x,x)

    let rec lookup (p:'a pair) (i:int) : 'a option =
      match p with
        (x,y) -> match i with
                 | 1 -> Some x
                 | 2 -> Some y
                 | _ -> None

    let rec replace (p:'a pair) (i:int) (z:'a) : 'a pair =
      match p with
        (x,y) -> match i with
                 | 1 -> (z,y)
                 | 2 -> (x,z)
                 | _ -> (x,y)
  end

module ListPair : PAIR =
  struct
    type 'a pair = 'a list

    let init_pair (x:'a) : 'a pair = [x;x]

    let rec lookup (p:'a pair) (i:int) : 'a option =
      match p with
      | [x;y] -> (match i with
                  | 1 -> Some x
                  | 2 -> Some y
                  | _ -> None)
      | _ -> None

    let rec replace (p:'a pair) (i:int) (z:'a) : 'a pair =
      match p with
        [x;y] -> (match i with
                  | 1 -> [z;y]
                  | 2 -> [x;z]
                  | _ -> [x;y])
      | _ -> p
  end

type 'a mypair =
  Pair of ('a * 'a)

module PairPair : PAIR =
  struct
    type 'a pair = 'a mypair

    let init_pair (x:'a) : 'a pair = Pair (x,x)

    let rec lookup (p:'a pair) (i:int) : 'a option =
      match p with
        Pair (x,y) -> match i with
                      | 1 -> Some x
                      | 2 -> Some y
                      | _ -> None

    let rec replace (p:'a pair) (i:int) (z:'a) : 'a pair =
      match p with
        Pair (x,y) -> match i with
                      | 1 -> Pair (z,y)
                      | 2 -> Pair (x,z)
                      | _ -> Pair (x,y)
  end


(* 7(b). Fill in the types of the imperative version of the PAIR
   signature below. *)

module type PAIR = 
  sig
    type 'a pair

    val init_pair : 'a -> 'a pair

    val lookup : 'a pair -> int -> 'a option

    val replace : 'a pair -> int -> 'a -> unit
  end
