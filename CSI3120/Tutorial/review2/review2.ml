(* Review Question 1: Lambda Calculus *)
(* See the associated PDF file. *)

(* Review Question 2: Exceptions and Memory Management *)
(* Consider the following OCaml code: *)

exception Excpt of int

let e2_a = 
  let twice f x = try f (f x) with | Excpt z -> z in
  let pred x = if x = 0 then raise (Excpt x) else x-1 in
  let dumb x = raise (Excpt x) in
  let smart x = try 1 + pred x with | Excpt z -> 1 in
  twice pred 1

let e2_b = 
  let twice f x = try f (f x) with | Excpt z -> z in
  let pred x = if x = 0 then raise (Excpt x) else x-1 in
  let dumb x = raise (Excpt x) in
  let smart x = try 1 + pred x with | Excpt z -> 1 in
  twice dumb 1

let e2_c = 
  let twice f x = try f (f x) with | Excpt z -> z in
  let pred x = if x = 0 then raise (Excpt x) else x-1 in
  let dumb x = raise (Excpt x) in
  let smart x = try 1 + pred x with | Excpt z -> 1 in
  twice smart 0

(* 2(a). Draw the activation stack for the execution of the code that
   evaluates e2_a.  Include access links, parameters, local variables,
   and exception handlers.  Represent functions as closures.  What is
   the value of e2_a?  Which exception gets raised (if any) and where
   is it handled?

   2(b). What is the value of e2_b?  Which exception gets raised (if
   any) and where is it handled?

   2(c). What is the value of e2_c?  Which exception gets raised (if
   any) and where is it handled?  *)


(* Review Question 3: Higher-Order Functions and Memory Management *)
(* Consider the OCaml program below. *)

let _ =
  let counter () =
    let c = ref 1 in
    let counter_fun () =
      let v = !c in
      (c := v+1 ; v)
    in counter_fun in
  let countA = counter() in
  let countB = counter() in
  countA()+countB()

(* 3(a). What is the value of the above expression?

   3(b). Ignore the first line and draw the activation stack for the
   execution of this code starting with the declaration of the
   function "counter".
 *)

(* Review Question 4: Continuations and Exceptions *)
             
(* Consider the following OCaml function, whose second argument is a
   continuation. *)

let rec f n k =
  match n with
  | 0 -> k 1
  | 1 -> k (-1)
  | _ -> f (n-2) (fun x -> k (x*2))

(* 4(a) Trace the OCaml expression below by listing the
   series of calls to f.  What is the value of this expression? *)
(*

f 6 (fun x -> x) =
f ...

*)

(* 4(b) Trace the OCaml expression below by listing the
   series of calls to f.  What is the value of this expression? *)
(*

f 5 (fun x -> x) =
f ...

*)

(* 4(c) Note that the function f enters an infinite loop whenever the
   value of argument n is negative.  Rewrite f to raise an exception
   when n is negative.  (Be sure to correctly declare your exception.) *)  

(* 4(d) Write a function that takes one argument and calls your
   solution to part 4(c) with the input argument and the continuation
   (fun x -> x) and handles the exception that is raised in your
   solution to part 4(c) by returning 0. *)

(* 4(e) Modify your solutions to parts (c) and (d) so that they use
   an error continuation instead of an exception *)

(* 4(f) Rewrite the function f above so that it does the
   same computation, but does not use any contintuations.
   (Rewrite the original version of f, not your modified versions.) *)
