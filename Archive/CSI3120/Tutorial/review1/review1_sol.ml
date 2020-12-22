(* Sample Solutions to Selected Questions *)
(* Review Question 1: Inductive Data Types *)

type tree = 
  | Empty
  | Node of tree * int * tree

(* helper function for constructing trees *)
let leaf (i:int) : tree =
  Node(Empty, i, Empty)

let t1 = 
  Node(Node(leaf 2, 1, Empty),
       0,
       Node(leaf 7, 6, leaf 8))

(* Question 1a. Draw the tree represented by t1. *)

(* Question 1b. What does the following function do? Replace the empty
   string below with your answer. *)

let fun_1b (t:tree) : bool =
  begin match t with
  | Node(Empty,_,Empty) -> true
  | _ -> false
  end

let answer1b : string =
  "This function returns true if the tree contains one node and both
   subtrees are empty, and returns false otherwise."

(* Question 1c. What is the value of l1 below?  Add a comment with
   your answer.  What does the function fun_1c do? Replace the empty
   string below with your answer. *)

let rec fun_1c (t:tree) : int list =
  begin match t with
  | Empty -> []
  | Node(l,n,r) -> n::(fun_1c l)@(fun_1c r)
  end

let l1 = fun_1c t1
(* val l1 : int list = [0; 1; 2; 6; 7; 8] *)

let answer1c : string =
  "This function returns a list containing all of the values at the
   nodes in the input tree. The nodes are listed in a top-down,
   left-to-right traversal, which means the value at the parent node
   is included in the list, followed by all the values in the left
   subtree, followed by all the values in the right subtree."



(* Question 2. Polymorphic and Higher-Order Programming *)

let add (x:int) (y:int) : int = x + y
let mult (x:int) (y:int) : int = x * y
           
let rec fun2 x n =
  match n with
  | 0 -> []
  | n -> if n < 0 then []
         else x::(fun2 x (n-1))

(* Question 2a. What does the fun2 function do? Replace the empty
   string below with your answer. *)

let answer2a : string =
  "This function creates a list of n elements where every element is
   the value of x"
       
(* Question 2b. What is the type of fun2?  Add a comment with your answer *)

(* 'a -> int -> 'a list *)

(* Question 2c. What are the types and values of a2, b2, c2, and d2
   below?  Add a comment with your answers. *)

let a2 = fun2 true 4
let b2 = fun2 add 2
let c2 = fun2 (add 3) 2
let d2 = fun2 (fun2 false 3) 2

(*
a2 : bool list = [true; true; true; true]
b2 : (int -> int -> int) list = [add; add]
c2 : (int -> int) list = [(add 3); (add 3)]
d2 : bool list list = [[false; false; false]; [false; false; false]]
 *)
                   
(* Question 2d.  What are the types of e2, f2, g2, h2, i2, j2 below.
   Add a comment with your answers? *)

let e2 = (1,false)
let f2 = [(1,false);(2,true)]
let g2 = ([1;2],[false;true])
let h2 = fun2 4.3
let i2 = fun x -> x < 5
let j2 = [add;mult]

(*
e2 : int * bool
f2 : (int * bool) list
g2 : int list * bool list
h2 : int -> float list
i2 : int -> bool
j2 : (int -> int -> int) list
 *)



(* Question 3. Parsing and Precedence

Draw parse trees for the following expressions, assuming the grammar
and precedence described in class:

Multipication ("*") has a higher precedence than addition ("+") or
subtraction ("-").  All 3 operators associate to the left.

Use the following grammar for expressions:
e ::= n | e+e | e-e | e*e
n ::= 1

3a. 1 - 1 * 1
3b. 1 - 1 + 1
3c. 1 - 1 + 1 - 1 + 1 (Here give higher precedence to + than to -)

Solutions:
3a.   e        1 - (1 * 1)
     /|\
    e - e
   |    /|\
   n   e * e
   |   |   |
   1   n   n   
       |   |
       1   1   

3b.   e        (1 - 1) + 1
     /|\
    e + e
  /|\    |
 e - e   n
 |   |   |
 n   n   1
 |   |
 1   1   

3c. 1 - 1 + 1 - 1 + 1 (Here give higher precedence to + than to -)

                             e
                           / | \
                          /  |  \
                         e   -   e
                       /|\      /|\
                      e - e    e + e
                     |   /|\   |   |
                     n  e + e  n   n
                     |  |   |  |   |
                     1  n   n  1   1
                        |   |
                        1   1
 *)



(* Question 4: Anonymous Functions *)
(* What is the value of x4 ? Add a comment with your answer. *)
       
let rec guess (f:int -> int -> int) (l:int list) : int option =
  match l with
  | [] -> None
  | [a] -> Some a
  | a::b::l' -> guess f ((f a b)::l')

let x4 = guess (fun x -> fun y -> (x * x) + y) [2;3;5]
(* val x4 : int option = Some 54 *)



(* Question 5: More Inductive Data Types *)

type ('a,'b) newtype =
    New_const1
  | New_const2 of (('a,'b) newtype * 'a * 'b)

let rec q5_fun (xs:('a,'b) newtype) =
  match xs with
  | New_const1 -> []
  | New_const2 (xs',xa,xb) -> (xa::q5_fun xs')

let q5a = q5_fun (New_const2 (New_const2 (New_const2 (New_const1,3,true),7,false),5,false))

(* Question 5a. What is the value of q5a? Add a comment with your
   answer. *)
(* val q5a : int list = [5; 7; 3] *)

(* Question 5b. What is the type of q5_fun? Add a comment with your
   answer. *)
(* ('a, 'b) newtype -> 'a list *)

(* Question 5c. What does q5_fun do? Replace the empty string below
   with your answer. *)

let answer5c : string =
  "This function returns a list containing all of the middle values of
   the 3-tuple argument to the New_const2 constructor, in the same
   order as they appear in the argument."
                      
(* Question 5d. Write a function that takes an input of type
   "(int,float) newtype" and returns a pair of type "int * float"
   where the first element is the sum of all of the integer elements
   appearing in the input data structure and the second element is the
   sum of all of the float elements appearing in the input data
   structure. *)

let rec q5d_fun (xs:(int,float) newtype) : int * float =
  match xs with
  | New_const1 -> (0,0.0)
  | New_const2 (xs',xa,xb) ->
     let (result_a,result_b) = q5d_fun xs' in
     (xa + result_a, xb +. result_b)
       
(* Question 5e. Write an expression of type
   "(int,float) newtype" with 3 integers and 3 floats
   that can be used as input to the function from
   Question 5d. *)
let q5e = q5d_fun (New_const2 (New_const2 (New_const2 (New_const1,3,3.1),7,5.2),5,8.5))



(* Question 6 Imperative Abstract Data Types *)

module type DICTIONARY =
  sig
    (* An 'a dict is a mapping from strings to 'a.
       We write {k1->v1, k2->v2, ...} for the dictionary which
       maps k1 to v1, k2 to v2, and so forth. *)
    type key = string
    type 'a dict

    (* make an empty dictionary carrying 'a values *)
    val make : unit -> 'a dict

    (* insert a key and value into the dictionary *)
    val insert : 'a dict -> key -> 'a -> unit

    (* Return the value that a key maps to in the dictionary.
       Return None if there is not mapping for the key. *)
    val lookup : 'a dict -> key -> 'a option
  end

(* Uncomment all of the code below, including the test data and
   complete the implementation of the module below.  Use a sorted list
   for the implementation of the dictionary. *)

module SortedAssocList : DICTIONARY =
  struct
    type key = string
    type 'a dict = (key * 'a) list ref
        
    let make() : 'a dict = ref []

    let insert (d : 'a dict) (k : key) (x : 'a) : unit =
      let rec aux (l:(key * 'a) list) : (key * 'a) list =
        match l with
        | [] -> [(k, x)]
        | (k', x') :: tl ->
           if k = k' then (k, x)::tl
           else if k < k' then (k, x)::l
           else (k', x')::aux tl
      in d := aux !d

    let lookup (d : 'a dict) (k : key) : 'a option =
      let rec aux (l:(key * 'a) list) : 'a option =
        match l with
        | [] -> None
        | (k', x) :: tl ->
           if k = k' then Some x
           else if k < k' then None
           else aux tl in
      aux !d
    end

let d = SortedAssocList.make()
let _ = SortedAssocList.insert d "Sam" 22
let _ = SortedAssocList.insert d "Ada" 19
let _ = SortedAssocList.insert d "Eric" 24
let _ = SortedAssocList.lookup d "Sam"
let _ = SortedAssocList.lookup d "Eric"
let _ = SortedAssocList.lookup d "Ada"
let _ = SortedAssocList.lookup d "Christine"



(* Question 7: References *)

type point = int ref * int ref

let f (p1:point) (p2:point) : int =
  match (p1,p2) with
  | (x1,y1),(x2,y2) ->
              (x1 := 17;
               let z = !x1 in
               x2 := 42;
               z)

let point1 = (ref 3, ref 4)
let point2 = (ref 8, ref 6)
let a = f point1 point2
let b = match point1 with
    (x,y) -> (!x,!y)
let c = match point2 with
    (x,y) -> (!x,!y)

let a' = f point1 point1
let b' = match point1 with
    (x,y) -> (!x,!y)

(* What are the values of a, b, c, a', and b'? Add a
   comment with your answer. *)
(* 
val a : int = 17
val b : int * int = (17, 4)
val c : int * int = (42, 6)
val a' : int = 17
val b' : int * int = (42, 4)
 *)

          
