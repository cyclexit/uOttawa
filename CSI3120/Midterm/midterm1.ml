(* Name: Hongyi Lin *)
(* Student Number: 300053082 *)
(* Email: hlin087@uottawa.ca *)

(* For each question in the Brightspace quiz (except for the
   True/False questions at the end), copy the code and question here,
   and follow the instructions to answer it. *)

(* Preface: Some OCaml code that you may need in some of your answers
   below. (Some questions will refer to code in the preface, and you
   can find that code here.) *)

let inc x = x+1
let square y = y*y
let add x y = x+y
let mult x y = x*y
let double s = s ^ s
let uppercase s = String.uppercase_ascii s
let concat s1 s2 = s1 ^ s2
let add_to_ends s s' = s' ^ s ^ s'

type 'a tree = | Leaf of 'a
               | Node of 'a tree * 'a tree

let rec map (f:'a -> 'b) (xs: 'a list) : 'b list =
  match xs with
  | [] -> []
  | hd::tl -> (f hd) :: (map f tl)

module type STACK = 
  sig
    type 'a stack
    val empty : unit -> 'a stack
    val push  : 'a -> 'a stack -> 'a stack
    val is_empty : 'a stack -> bool
    val pop : 'a stack -> 'a stack * 'a option
  end

module ListStack : STACK = 
  struct
    type 'a stack = 'a list
    let empty() : 'a stack = []
    let push (x:'a)(s:'a stack) : 'a stack = x::s
    let is_empty(s:'a stack) = 
	   match s with
     | [] -> true
     | _::_ -> false
    let pop (s:'a stack) : 'a stack * 'a option =
      match s with 
       | [] -> ([],None)
       | h::tl -> (tl,Some h)
end

type 'a mlist = 
  Nil | Cons of 'a * ('a mlist ref)

(* Question A (10 marks) Types in OCaml *)
(* For all parts of Question A, uncomment and fill in the expressions
   below to satisfy the types and follow any other instructions that
   are given.  As in Assignment 2, for option, list, and function
   types, you must provide a nontrivial answer. For a list that means
   a non-empty one, for an option type that means a Some construction,
   and for a function, that means using all its arguments to generate
   the return value.  *)

let a1 : int list = 3::4::[5; 6]

let a2 : (string list * bool list) list = [(["hello"; "world"], [true; true]); (["runtime error"; "tle"], [false; false])]

let a3 : (string -> string -> string) list = [concat; add_to_ends]

(* (a4) Define a function a4 that has type string -> string tree. *)
let a4 (str:string) : string tree =
  Node(Leaf str, Leaf str)

(* (a5) Using the 'a tree data type defined in the preface, represent
   the following tree.  You may define auxiliary functions and
   variables to help build the tree step-by-step, but this is not
   required. *)

(*
         /\
        /  \
       /    \
      3.14   \ 
             /\
            /  \
           /    \
        2.718  (sqrt 2.0)
 *)

let a5 : float tree = Node (Leaf 3.14, Node (Leaf 2.718, Leaf (sqrt 2.0)))

(* Question B (7 marks) Options *)

(* Question C (8 marks) Programming with Data Types *)

(* Question D (7 marks) Higher-Order and Polymorphic Programming *)

(* Question E (7 marks) Modules and Abstract Data Types *)

(* Question F (5 marks) Mutable Types *)
