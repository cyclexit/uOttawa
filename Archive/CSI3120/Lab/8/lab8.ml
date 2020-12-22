(* Object-Oriented Programming in OCaml (Real World OCaml Chapter 12):
   Representing Grammars as Classes and Expressions as Objects *)

(* We can represent expressions given by the grammar:

   e ::= num | e + e

   by using objects from a class called "expression".  We begin with
   an abstract class (using the keyword "virtual" in OCaml) called
   "expression".  Although this class has no instances, it lists the
   operations common to all the different kinds of expressions.  These
   operations include a predicate "is_atomic" indicating whether there
   are subexpressions or not, operations to retrieve the left and
   right subexpressions (if the expression is not atomic), and a
   method computing the value of the expression.
 *)

class virtual expression = object
  method virtual is_atomic : bool
  method virtual left_sub : expression option
  method virtual right_sub : expression option
  method virtual value : int
end

(* Because the grammar has two cases, we have two subclasses of
   "expression", one for numbers, and one for sums.
 *)

class number_exp (n:int) = object
  inherit expression as super
  val mutable number_val = n
  method is_atomic = true
  method left_sub = None
  method right_sub = None
  method value = number_val
end               

class sum_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value + right_exp#value
end

(* QUESTION 1. Product Class and Method Calls *)
(* 1(a). Extend this class hierarchy by writing a "prod_exp" class to
   represent product expressions of the form:

   e ::= ... | e * e
 *)

class prod_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable left_exp = e1
  val mutable right_exp = e2
  method is_atomic = false
  method left_sub = Some left_exp
  method right_sub = Some right_exp
  method value = left_exp#value * right_exp#value
end

(* 1(b). Create objects representing the following expressions:
   - An expression "a" representing the number 3
   - An expression "b" representing the number 0
   - An expression "c" representing the number 5
   - An expression "d" representing the sum of "a" and "b"
   - An expression "e" representing the product of "d" and "c"
   Then send the message "value" to "e".
   Note that "e" represents the expression (3+0)*5.

   To answer 1(b), uncomment this code and fill it in:
   let a = ...
   let b = ...
   ...
 *)

let a = new number_exp 3
let b = new number_exp 0
let c = new number_exp 5
let d = new sum_exp a b
let e = new prod_exp d c
let value_of_e = e#value
                                              
(* QUESTION 2. Unary Expressions *)
(* Extend the class hierarchy further by writing a "square_exp".
   The expression below written e^2 means "e squared":

   e ::= ... | e^2

   Changes will be required to the "expression" interface, so you will
   need to reimplement all the classes from above with these changes.
   Try to make as few changes as possible to the program. *)

class square_exp (e:expression) = object
  inherit expression as super
  val mutable sub_exp = e
  method is_atomic = false
  method left_sub = Some sub_exp
  method right_sub = None
  method value =
    let v = sub_exp#value in
      v * v
end

let test_square = new square_exp a
let _ = test_square#value

(* QUESTION 3. Ternary Expressions and More Method Calls *)
(* 3(a). Extend this class heirarchy by writing a "cond_exp" class to
   represent conditionals of the form

   e ::= ... | e?e:e

   In a conditional expression a?b:c, evaluate "a" and if the value is
   not 0, then return the value of "b".  If the value of "a" is 0,
   then return the value of "c".

   Again, try to make as few changes as possible to the program.  If
   necessary, redesign the class hierarchy you created for Question 2
   so that it handles both unary and ternary expressions.
 *)

class virtual expression = object
  method virtual is_atomic : bool
  method virtual first_sub : expression option
  method virtual second_sub : expression option
  method virtual third_sub : expression option
  method virtual value : int
end

class number_exp (n:int) = object
  inherit expression as super
  val mutable number_val = n
  method is_atomic = true
  method first_sub = None
  method second_sub = None
  method third_sub = None
  method value = number_val
end

class sum_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = None
  method value = first_exp#value + second_exp#value
end

class prod_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = None
  method value = first_exp#value * second_exp#value
end

class square_exp (e:expression) = object
  inherit expression as super
  val mutable first_exp = e
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = None
  method third_sub = None
  method value = 
    let t = first_exp#value in
      t * t
end

(*cond_exp class for question 3*)
class cond_exp (e1:expression) (e2:expression) (e3:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  val mutable third_exp = e3
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = Some third_exp
  method value = 
    if first_exp#value <> 0 then
      second_exp#value
    else
      third_exp#value
end


(* 3(b). Re-create all the objects a,b,c,d,e above and create new
   objects:
   - An expression "f" representing the square of "c"
   - An expression "g" representing the conditional b?e:f
   Then send the message "value" to "g".
 *)

let a = new number_exp 2
let b = new number_exp 1
let c = new number_exp 3
let d = new prod_exp a b
let e = new sum_exp d c
let f = new square_exp c
let g = new cond_exp b e f
let value_of_g = g#value (*expected: 5; actual: 5*)

(* 3(c) Enter the following expressions (for a,b,c,d,e,f,g) into OCaml
   so that you can see what is printed by the OCaml interpreter.  In
   each case, the type of the expression will be printed. Note that
   they are not all the same.

   Then enter the expression defining the value of "e_list".  Note
   that this is a list containing elements of type "expression", which
   is a different type than the ones printed out for a,b,c,d,e,f,g.
   Explain why these elements are all allowed to have more than one
   type in OCaml.

   To answer 3(c), uncomment this code and execute it.
*)

let _ = a
let _ = b
let _ = c
let _ = d
let _ = e
let _ = f
let _ = g
let e_list : expression list = [a;b;c;d;e;f;g]

(* Answer:
Because OCaml supports subtyping mechanism and a, b, c, d, e, f, g 
has all the functionality of the class 'expression', these elements can be
used in any context where 'expression' type is expected. In this way, the elements
from a to g can be included in the e_list, since they can casted to 'expression' type
by the OCaml interpreter.
*)

(* QUESTION 4. Redesign the entire hierarchy again, so that it
   includes a new operation that takes one argument (x:int) and
   modifies an expression object so that all of its leaves are
   incremented by the value of x.  (The leaves of an expression are
   all the subexpressions belonging to the "number_exp" class.)  This
   operation should not return a new instance of an "expression".  It
   should modify the instances that it is applied to.

   Re-create all the objects a,b,c,d,e,f,g again.  Then send the
   message "value" to "g".  Then apply the new operation with any
   argument value greater than 0.  Then send the message "value" to
   "g". The new value should be different than the original one.
   Verify that your implementation gives the expected new value.  *)

class virtual expression = object
  method virtual is_atomic : bool
  method virtual first_sub : expression option
  method virtual second_sub : expression option
  method virtual third_sub : expression option
  method virtual value : int
  method virtual inc : int -> unit
end

class number_exp (n:int) = object
  inherit expression as super
  val mutable number_val = n
  method is_atomic = true
  method first_sub = None
  method second_sub = None
  method third_sub = None
  method value = number_val
  method inc (x:int) = number_val <- number_val + x
end

class sum_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = None
  method value = first_exp#value + second_exp#value
  method inc (x:int) = 
    first_exp#inc x;
    second_exp#inc x
end

class prod_exp (e1:expression) (e2:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = None
  method value = first_exp#value * second_exp#value
  method inc (x:int) = 
    first_exp#inc x;
    second_exp#inc x
end

class square_exp (e:expression) = object
  inherit expression as super
  val mutable first_exp = e
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = None
  method third_sub = None
  method value = 
    let t = first_exp#value in
      t * t
  method inc (x:int) = first_exp#inc x
end

class cond_exp (e1:expression) (e2:expression) (e3:expression) = object
  inherit expression as super
  val mutable first_exp = e1
  val mutable second_exp = e2
  val mutable third_exp = e3
  method is_atomic = false
  method first_sub = Some first_exp
  method second_sub = Some second_exp
  method third_sub = Some third_exp
  method value = 
    if first_exp#value <> 0 then
      second_exp#value
    else
      third_exp#value
  method inc (x:int) = 
    first_exp#inc x;
    second_exp#inc x;
    third_exp#inc x
end

let a = new number_exp 10
let b = new number_exp 20
let c = new number_exp 30
let d = new sum_exp b c
let e = new prod_exp d a
let f = new cond_exp a d e
let g = new square_exp c
let value_of_g = g#value (*900*)
let _ = g#inc 1
let value_of_g = g#value (*expected: 961; actual: 961*)
