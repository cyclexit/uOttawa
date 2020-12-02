(*** CSI 3120 Assignment 6 ***)
(*** Hongyi Lin ***)
(*** 300053082 ***)
(*** 4.08.1 ***)
(* If you use the version available from the lab machines via VCL, the
   version is 4.05.0 ***)

(*********************************************)
(* PROBLEM 1: Function-Oriented Organization *)
(*********************************************)

(* Consider the OCaml code below. *)

type fBalance = float
type fInterestRate = float
type fMonthlyPayment = float

type loan =
  | NotePayable of fBalance
  | CreditCard of fBalance * fInterestRate
  | BankLoan of fBalance * fMonthlyPayment

(* Problem 1(a) *)
(* Write a function that takes a list of loans and returns a
   list of balances.  Your function must preserve order.  For
   example, the first element of the result must be the balance of the
   first loan in the input list *)

let rec get_fBalances (l:loan list) : fBalance list =
  match l with
  | [] -> []
  | hd::tl -> (
    match hd with
    | NotePayable x -> x::(get_fBalances tl)
    | CreditCard (x, _) -> x::(get_fBalances tl)
    | BankLoan (x, _) -> x::(get_fBalances tl)
  )

(* Problem 1(b)  *)
(* Write some test code: Create a list containing 3 loan accounts (one
   of each kind).  Set the monthly payment for the bank loan
   to 0. Apply your function from part 1(a) to your list of accounts *)
  
let loan_list = [NotePayable 1000.0; CreditCard (150.0, 0.03); BankLoan (50000.0, 0.0)]
let balance_list = get_fBalances loan_list

(*******************************************)
(* PROBLEM 2: Object-Oriented Organization *)
(*******************************************)

(* Your code for parts 2(a) and (b) go here *)

exception PaybackOverflow of fBalance
class note_payable = object
  val mutable balance = 0.0
  method get_balance = balance
  method borrow (amount:fBalance) =
    balance <- balance +. amount
  method payback (amount:fBalance) =
    if amount > balance then
      raise (PaybackOverflow balance)
    else
      balance <- balance -. amount
  method to_loan =
    NotePayable balance
end

class credit_card = object
  inherit note_payable as super
  val mutable interest_rate = 0.2
  method get_interest_rate = interest_rate
  method set_interest_rate (r:fInterestRate) =
    interest_rate <- r
  method add_interest =
    let interest = super#get_balance *. interest_rate in
      super#borrow interest
  method to_loan =
    CreditCard (super#get_balance, interest_rate)
end

class bank_loan = object
  inherit note_payable as super
  val mutable monthly_payment = 0.0
  method borrow (amount:fBalance) =
    super#borrow amount;
    monthly_payment <- monthly_payment +. (amount *. 0.1)
  method payback_monthly_amount =
    super#payback monthly_payment;
    monthly_payment <- super#get_balance *. 0.1
  method get_monthly_payment = monthly_payment
  method to_loan =
    BankLoan (super#get_balance, monthly_payment)
end

(* test for problem 2 *)

let np_test = new note_payable
let _ = np_test#get_balance
let _ = np_test#borrow 10.0
let _ = np_test#get_balance
let _ = np_test#payback 5.0
let _ = np_test#to_loan

let cc_test = new credit_card
let _ = cc_test#get_balance
let _ = cc_test#get_interest_rate
let _ = cc_test#to_loan
let _ = cc_test#borrow 100.0
let _ = cc_test#get_balance
let _ = cc_test#set_interest_rate 0.1
let _ = cc_test#get_interest_rate
let _ = cc_test#add_interest
let _ = cc_test#to_loan

let bl_test = new bank_loan
let _ = bl_test#get_balance
let _ = bl_test#get_monthly_payment
let _ = bl_test#to_loan
let _ = bl_test#borrow 5000.0
let _ = bl_test#get_balance
let _ = bl_test#get_monthly_payment
let _ = bl_test#payback_monthly_amount
let _ = bl_test#to_loan


(* Problem 2(a)  *)
(* Implement an inheritance hierarchy of loans (an object-oriented
   version of the data type in Problem 1). The credit_card and
   bank_loan classes should be subclasses of the note_payable class.
   The arguments to the NotePayable, CreditCard, and BankLoan
   constructors of the loan data type should become instance
   variables.  The initial values should be 0.0 for the balance, 0.2
   (representing 20%) for the interest rate, and 0 for the monthly
   payment.  Define a method called get_balance that returns the
   balance amount.

   Use the following programming conventions.
   - Do not use abstract classes.
   - The instance variables and methods should go in the highest class
     possible in the hierarchy to maximize inheritance.  Only override
     methods when necessary.  (In this hierarchy credit cards are
     the only kind of loan with an interest rate and bank
     loans are the only kind of loan with a monthly payment.)
   - In a subclass, do not use instance variables of the super class
     directly.  For example, if the implementation of a method in
     credit_card needs to access the balance amount, then it must
     call "get_balance".

   Implement methods called "borrow" and "payback" that take one
   argument, the amount to add to (borrow) or subtract from (payback)
   the balance.  If the amount of the payback is more than the balance,
   raise an exception that takes one argument. The data returned
   when this exception is raised should be the loan balance.

   Add methods in credit_card to get and set the interest rate.
   Also add an "add_interest" method that modifies the balance by
   adding interest to the balance using the interest rate.

   In the bank_loan class, override the borrow method so that
   it also increases the monthly payment by 10% (0.1) of the borrowed
   amount.  So borrowing an additional 100.00 would add 10.00 to the
   monthly payment.  Add a "payback_monthly_amount" method that
   reduces the balance by the monthly payment amount.
   Also add a method to get the value of the monthly payment,
   but do not allow clients to set it. *)


(* Problem 2(b)  *)
(* Add a method "to_loan" to every class that transforms an
   object to the corresponding value of type loan (where
   loan is the data type defined at the beginning of this file
   just before the statement of Problem 1(a)).  (It must return an
   element of type loan where the values of the arguments are
   determined from the values of the instance variables. *)


(*********************************************)
(* PROBLEM 3: Object-Oriented "Constructors" *)
(*********************************************)
(* Problem 3(a)  *)
(* Write a function that takes an argument, creates a note_payable
   object, and then uses the argument to update the balance.  Do the
   same for credit_card and bank_loan.  The function that
   creates a credit card must take an additional argument used to
   set the interest rate. *)

let construct_note_payable (amount:fBalance) : note_payable =
  let np = new note_payable in
    np#borrow amount;
    np

let construct_credit_card (amount:fBalance) (ir:fInterestRate) : credit_card =
  let cc = new credit_card in
    cc#borrow amount;
    cc#set_interest_rate ir;
    cc

let construct_bank_loan (amount:fBalance) =
  let bl = new bank_loan in
    bl#borrow amount;
    bl


(* Problem 3(b)  *)
(* Using the same data that you used to create your solution to 1(b),
   create one object of each class, and then create a list containing
   all of them.  You may have to use the coercion operator from
   Chapter 12 of "Real World OCaml".  (See the course notes.) *)

let np3b = construct_note_payable 1000.0
let cc3b = construct_credit_card 150.0 0.03
let bl3b = construct_bank_loan 50000.0
let loan_list3b = [np3b; (cc3b :> note_payable); (bl3b :> note_payable)]

(* Problem 3(c)  *)
(* Redo Problem 1(a), writing the object-oriented version this time (a
   function that takes a list of objects of type note_payable and
   returns a list of balances.  Call your function on your list from
   Problem 3(b). *)

let rec get_oBalances1 (l:note_payable list) : fBalance list =
  match l with
  | [] -> []
  | hd::tl -> (hd#get_balance)::(get_oBalances1 tl)

let balance_list3b = get_oBalances1 loan_list3b


(****************************************************)
(* PROBLEM 4: Conversion to Function-Oriented Style *)
(****************************************************)
(* Write a function that returns a list of loan balances with the
   same return values as your solution to Problem 3(c), but this time,
   your function must first take a list of note_payable objects,
   convert them to elements of type loan, and then call your
   function from Problem 1(a) *)

(* let get_oBalances2 ... *)
