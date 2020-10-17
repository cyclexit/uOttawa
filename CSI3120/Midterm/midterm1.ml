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
(* Write a function that takes two int option arguments and returns a
   float option. The function should divide the first argument by the
   second if both arguments are present and the second is not 0.
   Convert values of type int to float when necessary. Otherwise, the
   function must return None. Name your function "div_option" *)

let div_option (x:int option) (y:int option) : float option =
  match (x, y) with
  | (None, None) -> None
  | (None, _) -> None
  | (_, None) -> None
  | (Some a, Some b) -> (
    if b = 0 then
      None
    else
      Some ((float_of_int a) /. (float_of_int b))
  )

(* Question C (8 marks) Programming with Data Types *)
type newtype =
  | Con1 of string
  | Con2 of string * int
(* Write a function that takes a string and a list of elements of
   newtype and counts the number of times that the string appears in
   the elements of the list. For example, the function should return 2
   if the input string is "yes" and the input list is:
   [Con1 "yes"; Con2 ("no", 3); Con2 ("yes", 4)]

   Your function should be called count_occurrences and have type
   string -> newtype list -> int.
*)
let rec count_occurrences (str:string) (l:newtype list) : int =
  match l with
  | [] -> 0
  | (Con1 x)::tl -> (
    if x = str then
      1 + (count_occurrences str tl)
    else
      0 + (count_occurrences str tl)
  )
  | (Con2 (x, _))::tl -> (
    if x = str then
      1 + (count_occurrences str tl)
    else
      0 + (count_occurrences str tl)
  )

(*
let str1 = "yes"
let l1 = [Con1 "yes"; Con2 ("no", 3); Con2 ("yes", 4)]
let test_count_occurrences = count_occurrences str1 l1
*)

(* Question D (7 marks) Higher-Order and Polymorphic Programming *)
type newtype =
  | X of float
  | Y of int
  | Z of int * float
(* Use the map function included in the preface to implement a
   function transform_newtypes that takes an integer n and a list of
   elements of newtype and returns a new list where the integer
   component of every element of the list is replaced by n. *)

let transform_newtypes (n:int) (xs:newtype list) : newtype list =
  let helper_func (nt:newtype) : newtype =
    match nt with
    | X fnum -> X fnum
    | Y inum -> Y n
    | Z (inum, fnum) -> Z (n, fnum)
  in
    map helper_func xs

(*
let ntl = [X 1.0; Y 3; Z (4, 2.0)]
let test_transform_newtypes = transform_newtypes 100 ntl
*)

(* Question E (7 marks) Modules and Abstract Data Types *)
(* The interface and structure for the polymorphic immutable stack
   datatype given in the code in the preface is very similar to the
   code in the course notes.  The only difference is that there is no
   "top" operation and the "pop" operation returns a tuple containing
   both the new stack and the top element.  Replace all of the
   occurrences of ?? in the bodies of teststack1 and teststack2 so
   that when they are called they return true. *)

let teststack1 () =
   let emp = ListStack.empty() in
   let s0 = ListStack.push "x" emp in
   let s1 = ListStack.push "y" s0 in
   let s2 = ListStack.push "z" s1 in
   let (s3,a) = ListStack.pop s2 in
   let (s4,b) = ListStack.pop s3 in
   let (s5,c) = ListStack.pop s4 in
   (a = Some "z" && b = Some "y" && c = Some "x" && ListStack.is_empty s5)

let teststack2 () =
   let emp = ListStack.empty() in
   let s0 = ListStack.push "a" emp in
   let s1 = ListStack.push "b" emp in
   let (s2,a) = ListStack.pop s0 in
   (a = Some "a" && ListStack.is_empty s2)

(* Question F (5 marks) Mutable Types *)
