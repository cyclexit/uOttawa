(*** CSI 3120 Assignment 2 ***)
(*** Hongyi Lin ***)
(*** 300053082 ***)
(*** 4.08.1 ***)
(* If you use the version available from the lab machines via VCL, the
   version is 4.05.0 ***)

(*************)
(* PROBLEM 1 *)
(*************)

(* For each part of problem 1, explain in the given string why the code
   will not typecheck, then follow the instructions for that part to
   change the code so that it typechecks while keeping the same values
   as intended by the erroneous code. Once you have done so, uncomment
   the fixed expression for submission.
*)

(* Problem 1a - Give your explanation in exp1a and then fix the
   right-hand-side of the assignment to match the listed type.
   (Do not change the left-hand-side.)
*)

let exp1a : string = "The list on the right-hand-side has elements with different types, but the left-hand-side specifies that the list should only have (string * int * char) tuples as elements."
let prob1a : (string * int * char) list = [("7", 8, '9')];;


(* Problem 1b - Give your explanation in exp1b and then fix the type
   of variable prob1b to match the type of the expression on the
   right-hand-side of the assignment. (Do not change the
   right-hand-side.)
 *)

let exp1b : string = "The right-hand-side is a tuple of a string list and an int list, but the left-hand-side has the type (string * int) list which means a list with (string * int) tuples."
let prob1b : (string list * int list) = (["apples";"bananas";"carrots"],[3;2;1]);;

(* Problem 1c - Give your explanation in exp1c and then fix the
   right-hand-side of the expression to match the variable prob1c's
   listed type.  (Do not change the left-hand-side.)
 *)


let exp1c : string = "The first half and the second half both have the type (string string list), so this does not the obey the typing rule for the list. Besides, in the second half, two string lists are connected by ::, and this also does not obey the typing rule."
let prob1c : string list list = ["2"; "b"]::["or"; "not"; "2b"]::[["that is"; "the"]; ["question"]]


(*************)
(* PROBLEM 2 *)
(*************)

(* Fill in expressions to satisfy the following types:
 *
 * NOTE: for option, list, and function types, you must
 * provide a nontrivial answer. For a list that means a
 * non-empty one, for an option type that means a Some
 * construction, and for a function, that means using
 * its arguments to generate the return value.
 * example problems:
 *   let x : int option = ???
 *   let y : int list = ???
 *   let f (x: int) (y: int) : int = ???
 * incorrect answers:
 *   let x : int option = None
 *   let y : int list = []
 *   let f (x: int) (y: int) : int = 7
 * possible correct answers:
 *   let x : int option = Some 1
 *   let y : int list = [1]
 *   let y : int list = [1; 2]
 *   let y : int list = 1 :: [2]
 *   let f (x: int) (y: int) : int = x + y
 *   let f (x: int) (y: int) : int =
 *         String.length  ((string_of_int x) ^ (string_of_int y))
 *)

(* Problem 2a *)

let prob2a : (int * ((string * float) option list)) list = 
    [(100, [Some ("HaHa", 20.0); None]); (20, [None; Some ("ss", 11.1)])]

(* Problem 2b *)
(* a pet is a (name, animal_type, age option) tuple *)

type pet = string * string * int option

let prob2b : string * pet list option =
    ("my pets", Some [("Tom", "Cat", Some 2); ("Jerry", "Mouse", Some 3)])


(* Problem 2c *)
(* Fill in a valid function call to f to make prob2c typecheck *)

let prob2c =
  let rec f arg =
    match arg with
    | (a, b) :: xs -> if a then (b ^ (f xs)) else f xs
    | _ -> ""
  in
    f [(true, "This "); (true, "is "); (false, "not"); (true, " possible!")]


(*************)
(* PROBLEM 3 *)
(*************)

(* Problem 3a.  You have been asked to write a text filter,
   where you want to find all search characters in your text
   if they appear the right order.

   Write a function text_filter that takes two lists of characters
   and checks to see if all the characters in the first list are
   included in the second list AND in the same order, BUT possibly
   with other characters in between.  For example

   text_filter ['a';'m';'z'] ['1';'a';'2';'m';'3';'z'] = true
   text_filter ['a';'m';'z'] ['1';'a';'3';'z'] = false
   text_filter ['a';'m';'z'] ['1';'z';'2';'m';'3';'a'] = false
 *)

let rec text_filter (xs:char list) (ys:char list) : bool =
    match (xs, ys) with
    | (x::xtl, y::ytl) ->
        if x = y then
            true && (text_filter xtl ytl)
        else
            text_filter xs ytl
    | ([], _::_) -> true
    | ([], []) -> true
    | (_::_, []) -> false

(* Problem 3b. Rewrite the function above so that is is polymorphic,
   i.e., it should work on lists whose elements are any types.  Give
   at least one test case (call your function at least once) with a
   type that is different from chars. 
   
    any_filter [1;2;3] [1;7;8;9;2;4;5;6;3];; => true
    any_filter ["hello"; "world"] ["world"; "foo"; "bar"; "hello"];; => false
    any_filter [[1]; [2]] [[1]; [3]; [2]];; => true
    any_filter [true; false] [false; false; true; false];; => true
 *)

let rec any_filter (xs:'a list) (ys:'a list) : bool = 
    match (xs, ys) with
    | (x::xtl, y::ytl) ->
        if x = y then
            true && (any_filter xtl ytl)
        else
            any_filter xs ytl
    | ([], _::_) -> true
    | ([], []) -> true
    | (_::_, []) -> false

(*************)
(* PROBLEM 4 *)
(*************)

(* Write a function (int_to_whole) that converts an integer
   into a whole number if one exists
   (a whole numbner is 1, 2, 3, ...).
   Use an option type because not all integer inputs can
   be converted. *)

type whole = One | Succ of whole

