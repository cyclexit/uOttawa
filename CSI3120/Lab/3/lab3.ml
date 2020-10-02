(* Goal for this lab: more practice with Ocaml, in particular,
   with regard to recursion, higher order functions, and options *)

(* 1a. Write a function that takes a list of boolean values
   [x1; x2; ... ; xn] and returns x1 AND x2 AND ... AND xn.
   For simplicity, assume and_list [] is TRUE. *)

let rec and_list (lst: bool list) : bool =
    match lst with
    | [] -> true
    | x::tl -> x && (and_list tl)

let q1a_result = and_list [true; false]

(* 1b. Do the same as above, with OR.
   Assume or_list [] is FALSE. *)


let rec or_list (lst: bool list) : bool =
    match lst with
    | [] -> false
    | x::tl -> x || (and_list tl)

let q1b_result = or_list [true; false]


(* 2. The functions and_option, or_option, and calc_option below are
   possible solutions to optional questions 7 and 8 in Lab 2.  You are
   asked to implement new versions of and_option and or_option using
   calc_option.  Note that this is a minor variation of questions from
   Lab 2.  In particular, using calc_option, write a function to
   return the boolean AND/OR of two bool options, or None if both are
   None. If exactly one is None, return the other. *)

let and_option (x:bool option) (y: bool option) : bool option =
  match x with
  | Some a -> (match y with
               | Some b -> if a then y else Some false
               | None -> x)
  | None -> y

let or_option (x:bool option) (y: bool option) : bool option =
  match x with
  | Some a -> (match y with
               | Some b -> if a then Some true else y
               | None -> x)
  | None -> y

let calc_option (f: 'a->'a->'a) (x: 'a option) (y: 'a option) : 'a option =
  match x with
  | Some a -> (match y with
               | Some b -> Some (f a b)
               | None -> x)
  | None -> y

let and_option' (x:bool option) (y: bool option) : bool option =
    calc_option (fun a b -> a && b) x y

let q2_and_option_result = and_option' (Some true) (None)

let or_option' (x:bool option) (y: bool option) : bool option =
    calc_option (fun a b -> a || b) x y

let q2_or_option_result = or_option' (Some false) (None)


(* 3. The following code is a possible solution to optional question 9 in Lab 2. *)

let min (a:int) (b:int) : int = if a < b then a else b
let max (a:int) (b:int) : int = if a < b then b else a

let min_option2 (x: int option) (y: int option) : int option =
  calc_option min x y

let max_option2 (x: int option) (y: int option) : int option =
  calc_option max x y

(* Write a recursive function that returns the max of a list, or None
   if the list is empty. You may use the code above but you don't have
   to. *)

let rec max_of_list (lst:int list) : int option =
    match lst with
    | [] -> None
    | hd::tl -> max_option2 (Some hd) (max_of_list tl)

let q3_result = max_of_list [5; 2; 4; 1; 3]


(* 4. In the following exercises, we will use map (as seen in class)
   to implement some functions. *)

let rec map (f:'a -> 'b) (xs: 'a list) : 'b list =
  match xs with
  | [] -> []
  | hd::tl -> (f hd) :: (map f tl)

(* 4a. Write a function that takes an int list and multiplies every
   int by 3.  Use map. *)

let times_3 (lst: int list): int list =
    map (fun a -> 3 * a) lst

let q4a_result = times_3 [1; 2; 3]

(* 4b. Write a function that takes an int list and an int and
   multiplies every entry in the list by the int. Use map. *)

let times_x (x: int) (lst: int list) : int list =
    map (fun a -> x * a) lst

let q4b_result = times_x 10 [1; 2; 3]

(* 4c. Rewrite times_3 in terms of times_x.  This should take very
   little code. *)

let times_3_shorter (lst: int list): int list =
    times_x 3 lst

let q4c_result = times_3_shorter [1; 2; 3]


(* 5. Consider the following higher-order function reduce *)

let rec reduce (f:'a -> 'b -> 'b) (u:'b) (xs:'a list) : 'b =
  match xs with
  | [] -> u
  | hd::tl -> f hd (reduce f u tl);;

(* Consider the following functions defined using reduce *)

let sum xs = reduce (fun x y -> x+y) 0 xs
let prod xs = reduce (fun x y -> x*y) 1 xs

(* What do the sum and prod functions do?  What does the reduce
   function do?  Trace the following code to help figure this out.
   Show your trace and provide your explanation here:

ANSWER HERE

The "sum" function calculates and returns the sum of the list "xs".

The "prod" function calculates and returns the product of the list "xs".

The "reduce" function applies the function "f" to all elements of the list "xs" recursively, 
and return the base value "u" when the list is empty.

Trace:
    "sum [2; 5; 6]" calls "reduce (fun x y -> x+y) 0 [2; 5; 6]"
    reduce (fun x y -> x+y) 0 [2; 5; 6]
        2::[5; 6] -> (fun x y -> x+y) 2 (reduce (fun x y -> x+y) 0 [5; 6])
    reduce (fun x y -> x+y) 0 [5; 6]
        5::[6] -> (fun x y -> x+y) 5 (reduce (fun x y -> x+y) 0 [6])
    reduce (fun x y -> x+y) 0 [6]
        6::[] -> (fun x y -> x+y) 6 (reduce (fun x y -> x+y) 0 [])
    reduce (fun x y -> x+y) 0 []
        0
    So the mysum is calculated as (2 + (5 + (6 + 0))) = 13

    "prod [2; 5; 6]" calls "reduce (fun x y -> x*y) 1 [2; 5; 6]"
    reduce (fun x y -> x*y) 1 [2; 5; 6]
        2::[5; 6] -> (fun x y -> x*y) 2 (reduce (fun x y -> x*y) 1 [5; 6])
    reduce (fun x y -> x*y) 1 [5; 6]
        5::[6] -> (fun x y -> x*y) 5 (reduce (fun x y -> x*y) 1 [6])
    reduce (fun x y -> x*y) 1 [6]
        6::[] -> (fun x y -> x*y) 6 (reduce (fun x y -> x*y) 1 [])
    reduce (fun x y -> x*y) 1 []
        1
    So the myprod is calculated as (2 * (5 * (6 * 1))) = 60

*)

let mysum = sum [2;5;6]
let myprod = prod [2;5;6]


