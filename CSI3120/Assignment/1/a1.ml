(*** CSI 3120 Assignment 1 ***)
(*** Hongyi Lin ***)
(*** 300053082 ***)
(*** 4.08.1 ***)
(* If you use the version available from the lab machines via VCL, the
   version is 4.05.0 ***)

(* You do not have to understand the definition of the "undefined"
   function below.  Part of your job is to replace all calls to this
   function in the code below with the answers that you are asked
   for. *)

let undefined : unit -> 'a = fun () -> failwith "undefined"

(* 1. Please define these variables with the appropriate values.  Be
   sure that these statements all type-check after editing them.  You
   can do this by copying and pasting each definition to the shell
   window running the OCaml interpreter, or by filling in the code and
   loading the file using #use, as demonstrated in class and in the
   lab, or by using an evaluation plugin installed in your editor, for
   example, Ctrl+c and then Ctrl+e in Emacs with Tuareg mode *)
                                     
(* 1a. Create a string with your first name *)
let name : string = "Hongyi"

(* 1b. Use a string operator on the string from 1.a. to create a
   string that contains both your first and last names. *)
let fullname : string = name ^ " Lin"

(* 1c. Create a string containing your email address *)
let email : string = "hlin087@uottawa.ca"

(* 1d. Replace (Other "...") in class_year with the appropriate item
   below *)
(* ie: replace (Other "...") with SecondYear or ThirdYear for example *)
type year = FirstYear | SecondYear | ThirdYear | FourthYear | Other of string

let class_year : year = ThirdYear

(* 1e. Replace the .... with one thing you hope to learn about in
   this course *)
let learning : string = "I hope to learn functional programming."

let print = Printf.printf

let print_survey () = 
  let string_year = 
    (match class_year with
       | FirstYear -> "2023"
       | SecondYear -> "2022"
       | ThirdYear -> "2021"
       | FourthYear -> "2020"
       | Other s -> "Other: " ^ s
    ) in
    (print "----------------------------------------\n";
     print "Name: %s\n" fullname;
     print "Email: %s\n" email;
     print "Year: %s\n" string_year; 
     print "%s\n" learning;
     print "----------------------------------------\n\n")

(* Type in "print_survey()" into the OCaml interpreter to test your code so far. *)


(* Problem 2 - Fill in types: *)
(* Replace each ??? with the appropriate type of the corresponding
   expression.  Be sure to remove the comments from each subproblem
   and to type check it before submission.  *)
(* Note that the expressions might not do anything useful -- and in
   fact might even display interesting problems! -- but all you should
   do is fill in the ???s to make them type check. *)

(* Problem 2a. *)

let prob2a : int * float = let add3 x = 3 + x in
                    let add3' x = 3. +. x in
                    (add3 7, add3' 7.0)

(* Problem 2b. *)

let prob2b : string = string_of_int (String.index "abcd" 'c')


(* Problem 2c. *)

let rec prob2c (x : int) : char =
  if x = int_of_string "hello" then prob2c x else 'h'


(* Problem 2d. *)

let rec prob2d (x : float) (y: int) : (int -> char) =
  if x = float_of_int y then prob2c else prob2d x y



(* Problem 3 - Explain why each of 3a and 3b will not compile.  Note
   that there are 2 distinct problems in 3b.  Use the strings exp3a,
   exp3b1, and exp3b2 for your answers.  Then change the code in some
   small ways so that it does complile, and leave prob3a and prob3b
   uncommented. In 3b, do not change the top-level type associated
   with the expression. *)

(* Problem 3a. *)

let prob3a = let x = 4 in
             let y = 3 in
             (2 * x) + (3 * y)


let exp3a : string = "There will be a type error in (3 * y), since y = 3.9 has type float but the expression is expected of type int."

(* Problem 3b. Hint: look at the section on "Core Expression Syntax"
   in the course notes (the last section of the first lecture about
   OCaml) to help determine one of the problems. *)
 
let prob3b : int = 
  let rec exp x k =
  if k < 0 then 0
  else if k = 0 then 1
  else x * exp x (k-1)
  in
  exp 2 8;;


let exp3b1 : string = "The function exp will have an infinite recursion, since the value of k never decreases in the recursion call."

let exp3b2 : string = "The results cannot be calculated correctly when x is a negative integer, since it directly returns 0."


(* Problem 4 *)
(* Consider the following incomplete program *)

(*
let f (a:string) (b:float) : bool =
   if a = "yes" && b = 3.14 then
      true
   else
      false

let rec prob4 (x:bool) (y:bool) (z:string) : int =
  prob4 (f z 3.14) (x || not y) (if x then "yes" else "no")
 *)

(* Replace each ?? with the type of the corresponding expression, and
   write a function f that has the correct type signature. Explain in
   exp4 a problem that remains with the function prob4 *)

let exp4 : string = "The function prob4 will have an infinite recursion, since it does not have a base case so that the function can return"


(* Problem 5 *)

(* Write a recursive function for testing whether or not a string is a
   palindrome (the same sequence of characters both backwards and forwards) by
   checking whether or not the first and last letters are the same at
   each step. Hint: the String module used in Lab 1 will be useful here. *)

let rec prob5 (str : string) : bool = 
   let len = String.length str in
      if len = 0 || len = 1 then
         true
      else if str.[0] = str.[len - 1] then
         prob5 (String.sub str 1 (len - 2))
      else
         false