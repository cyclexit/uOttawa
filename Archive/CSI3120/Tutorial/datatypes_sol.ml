(* Exercise 1 *)
(* Look at the following type definition. *)
type colour = Red | Yellow | Blue | Green | Orange | Purple | Garnet | Other of string
type favourite = Colour of colour | Movie of string | Tvshow of string |
                 Number of float | Letter of char

(* We've defined some sample lists of favourite movies/colours/etc.
 * You can think of each of these lists as representing someone's
 * input describing their favourite things. 
 * You may want to use these for testing your functions later.*)

let a : favourite list = [Movie "Love Story"; Colour Blue;
                          Tvshow "The Simpsons"; Colour Orange]

let b : favourite list = [Number 1.0; Number 2.0; Number 5.0;
                          Number 14.0; Number 42.0]

let c : favourite list = [Movie "Tenet"; Tvshow "Westworld";
                          Letter 'P'; Colour Orange]

let d : favourite list = [Tvshow "Looney Tunes"; Number 3.14]

let students = [a; b; c; d]


(* 1a. Define a value of type favourite list for someone whose
 * favourite colour is Aubergine and whose favourite number is 5. *)

let prob1a : favourite list = [Colour (Other "Aubergine"); Number 5.]


(* 1b. Write a function that takes a value of type favourite list (like 
 * those above) and returns the title of this person's favourite movie, 
 * or None if a favourite movie isn't given. If multiple movies are 
 * return the first. What is the type of this function? (Enter the
 * type of favmovie as a string in favmovie_type below.) *)

let favmovie_type = "favourite list -> string option"

let rec favmovie (lst: favourite list) : string option  =
  match lst with
  | [] -> None
  | hd::tl ->
    match hd with
    | Movie m -> Some m
    | _ -> favmovie tl


(* 1c. Write a function that takes a value of type favourite list and
 * returns true if and only if this person has listed Garnet as a
 * favourite colour. What is the type signature for this function?*)

let uottawa_colours_type = "favourite list -> bool"
let rec uottawa_colours (lst: favourite list) : bool =
  match lst with
  | [] -> false
  | (Colour Garnet)::_ -> true
  | _::tl -> uottawa_colours tl


(* Exercise 2 *)
(* 2a. Define a data type to represent either int or float *)

type realnum = 
  | Int of int
  | Float of float


(* 2b. Define two functions to create realnums from an int and a float, respectively *)

let real_of_int (i:int) : realnum = Int i
let real_of_float (f:float) : realnum = Float f


(* 2c. Define a function testing whether two realnums are equal. It shouldn't
 * matter whether they are ints or floats, e.g (realequal 4 4.0) => True. *)

(* note: really shouldn't compare floats for equality, but done here for simplicity *)
(* also: could separate int/int case, where comparison is "pure" *)
let realequal (a: realnum) (b: realnum) : bool = 
  let float_of_real (x: realnum) : float =
    match x with 
    | Int y -> float_of_int y
    | Float y -> y
  in
  float_of_real a = float_of_real b


(* Exercise 3: 
   Below is a definition of a datatype for propositional logic with
   connectives for conjunction, (the AND operator written /\),
   disjunction (the OR operator written \/), and logical implication
   (written =>).  For example, the following is a formula of
   propositional logic.

   (p /\ q) => (r \/ s)

   Note that strings are used to represent propositional variables.
 *)

type prop = string

type form =
  | True
  | False
  | Prop of prop 
  | And of form * form
  | Or of form * form
  | Imp of form * form

(* 3a. Represent the formula above, i.e., (p /\ q) => (r \/ s) as an
   expression that has type form *)

let form3a : form = Imp(And(Prop "p",Prop "q"),Or(Prop "r",Prop "s"))

                  
(* 3b. Write a function that given a boolean formula returns the list of all
 * unique propositional variables that may be found in the formula
*)

let fvars (f:form) : prop list  = 
  let rec alreadySeen (v:prop) (vl: prop list) : bool =
    match vl with
    | [] -> false
    | hd::tl -> if hd=v then true else alreadySeen v tl
  in
  let rec collect_props (f:form) : prop list =
    match f with
    | True -> []
    | False -> []
    | Prop v -> [v]
    | And(x,y) -> collect_props x @ collect_props y
    | Or(x,y) -> collect_props x @ collect_props y
    | Imp(x,y) -> collect_props x @ collect_props y
  in
  let rec remove_duplicates (vl: prop list) : prop list =
    match vl with
    | [] -> []
    | hd::tl -> let tl' = remove_duplicates tl
                in if (alreadySeen hd tl') then tl' else hd::tl'
  in
  remove_duplicates (collect_props f)


(* 3c. Write a function that takes a boolean formula and tests whether
   or not it is in conjunctive normal form (CNF).  A CNF expression is
   represented as a series of OR expressions joined together by AND.

   For example, the following is in CNF.

   (x1 \/ x2) /\ (x3 \/ x4 \/ x5) /\ x6

   In addition, each of the x's (x1,...,x6) is either True, False, or
   a propositional variable.  x6 can be considered an OR expression
   with no ORs (a base case).  Another base case is when there is only
   one formula containing only \/, and another is when there is no
   occurrence of either /\ or \/. For example, the following formulas
   are in CNF.

   (x3 \/ x4 \/ x5)
   x
   True
   False

   Note that \/ and /\ are associative, so for example
   (x3 \/ x4 \/ x5) represents ((x3 \/ x4) \/ x5) and is equivalent
   to (x3 \/ (x4 \/ x5)), can thus be represented as
   Or (Or (Prop "x3",Prop "x4"),Prop "x5")  or
   Or (Prop "x3",Or (Prop "x4",Prop "x5"))
*)

let is_cnf (f:form) : bool =
  let rec is_or_series (f:form) : bool =
    match f with
    | True -> true
    | False -> true
    | Prop _ -> true
    | Or(x,y) -> is_or_series x && is_or_series y
    | _ -> false
  in
  let rec is_cnf_aux (f:form) : bool =
    match f with
    | And(x,y) -> (is_cnf_aux x || is_or_series x) && (is_cnf_aux y || is_or_series y)
    | x -> is_or_series x
  in is_cnf_aux f


(* Some tests for both 3b and 3c. *)

let c1 = Or (Prop "x1",Prop "x2")
let c2 = Or (Or (Prop "x3",Prop "x4"),Prop "x5")
let c3 = Prop "x2"

let test_is_cnf1 = is_cnf (And (c1,And (c2,c3)))
let test_is_cnf2 = is_cnf (And (And (c1,c2),c3))
let test_is_cnf3 = is_cnf (And (Imp (c1,c2),c3))
let test_is_cnf4 = is_cnf c2
let test_is_cnf5 = is_cnf c3

let test_fvars1 = fvars c2
let test_fvars2 = fvars (And (Imp (c1,c2),c3))
