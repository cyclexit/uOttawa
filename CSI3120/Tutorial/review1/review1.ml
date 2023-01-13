(* For each question in the Brightspace quiz, copy the code and
   question here, and follow the instructions to answer it.  Do this
   for all questions except those where you have to draw trees.  (You
   can do those on a separate piece of paper. *)

(* Question 1: Inductive Data Types
   (Question 1a can be answered on a separate piece of paper.) *)

type tree = 
  | Empty
  | Node of tree * int * tree

(* helper function for constructing trees *)
let leaf (i:int) : tree = Node(Empty, i, Empty)

let t1 = 
  Node(Node(leaf 2, 1, Empty),
            0,
            Node(leaf 7, 6, leaf 8))

(* Question 1a. Draw the tree represented by t1. Answer this one on a separate sheet of paper.*)

(* Question 1b. What does the following function do? Replace the empty
   string below with your answer. *)

let fun_1b (t:tree) : bool =
  begin match t with
  | Node(Empty,_,Empty) -> true
  | _ -> false
  end

let answer1b : string = "Check whether the tree contains a single node."

(* Question 1c. What is the value of l1 below? Add a comment with
   your answer. What does the function fun_1c do? Replace the empty
   string below with your answer. *)

let rec fun_1c (t:tree) : int list =
  begin match t with
  | Empty -> []
  | Node(l,n,r) -> n::(fun_1c l)@(fun_1c r)
  end

let l1 = fun_1c t1

(*The value of l1 is [0; 1; 2; 6; 7; 8]*)

let answer1c : string = 
   "The fun_1c does the pre-order traversal on the input tree.
    The nodes are listed in the top-down and left-to-right traversal order, 
    which means that the value at the parent node shows up first, followed 
    by all the values in the left subtree, and then all the values in the
    right subtree."

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

let answer2a : string = "Construct a list with n elements with the value x."

(* Question 2b. What is the type of fun2? Add a comment with your answer *)

(* 'a -> int -> 'a list *)

(* Question 2c. What are the types and values of a2, b2, c2, and d2
   below? Add a comment with your answers. *)

let a2 = fun2 true 4
let b2 = fun2 add 2
let c2 = fun2 (add 3) 2
let d2 = fun2 (fun2 false 3) 2

(*
a2: bool list
b2: (int->int->int) list
c2: (int->int) list
d2: bool list list
*)

(* Question 2d. What are the types of e2, f2, g2, h2, i2, j2 below.
   Add a comment with your answers? *)

let e2 = (1,false)
let f2 = [(1,false);(2,true)]
let g2 = ([1;2],[false;true])
let h2 = fun2 4.3
let i2 = fun x -> x < 5
let j2 = [add;mult]

(*
e2: int * bool
f2: (int * bool) list
g2: (int list) * (bool list)
h2: int -> float list
i2: int -> bool
j2: (int->int->int) list
*)

(* Question 3. Parsing and Precedence
   (All parts of Question 3 can be answered on a separate piece
   of paper.) *)


(* Question 4: Anonymous Functions *)

(* What is the value of x4? Add a comment with your answer. To test
   your understanding, find the answer without executing the code. *)
       
let rec guess (f:int -> int -> int) (l:int list) : int option =
  match l with
  | [] -> None
  | [a] -> Some a
  | a::b::l' -> guess f ((f a b)::l')

let x4 = guess (fun x -> fun y -> (x * x) + y) [2;3;5]

(*The value of x4 is Some 54*)

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

(* The value of q5a is [5; 7; 3] *)

(* Question 5b. What is the type of q5_fun? Add a comment with your
   answer. *)

(* The type of q5_fun is ('a, 'b) newtype -> 'a list. *)

(* Question 5c. What does q5_fun do? Replace the empty string below
   with your answer. *)

let answer5c : string = "q5_fun collects the first elements of New_const2 to form a list."
                      
(* Question 5d. Write a function that takes an input of type
   "(int,float) newtype" and returns a pair of type "int * float"
   where the first element is the sum of all of the integer elements
   appearing in the input data structure and the second element is the
   sum of all of the float elements appearing in the input data
   structure.
 *)

let rec q5d_fun (xs:(int, float) newtype) : int * float = 
   match xs with
   | New_const1 -> (0, 0.0)
   | New_const2 (xs',xa,xb) ->
      let (xa', xb') = q5d_fun xs' in
         (xa + xa', xb +. xb')

let test_q5d_fun = q5d_fun (New_const2 (New_const2 (New_const2 (New_const1, 3, 3.0), 7, 2.0),5, 1.0))

(* Question 5e. Write an expression of type
   "(int,float) newtype" with 3 integers and 3 floats
   that can be used as input to the function from
   Question 5d. *)

let q5d_fun_input = (New_const2 (New_const2 (New_const2 (New_const1, 3, 3.0), 7, 2.0),5, 1.0))

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
   complete the implementation of the module below. Use a sorted list
   for the implementation of the dictionary. *)

module SortedAssocList : DICTIONARY =
  struct
   (* in ascending order *)
    type key = string
    type 'a dict = (key * 'a) list ref

    let make () = ref []

    let insert (d:'a dict) (k:key) (v:'a) =
      let rec aux (l:(key * 'a) list) (k:key) (v:'a) : (key * 'a) list =
         match l with
         | [] -> (k, v)::l
         | (k', v')::tl -> (
            if k > k' then
               (k', v')::(aux tl k v)
            else if k = k' then
               (k, v)::tl
            else
               (k, v)::(k', v')::tl
         )
      in
         d := aux (!d) k v

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
   comment with your answer. To test your understanding,
   figure this one out without executing the code. *)

(*
a = 17
b = (17, 4)
c = (42, 6)
a' = 17
b' = (42, 4)
*)
