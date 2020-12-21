let rec fib n =
  if n <= 2 then
    1
  else
    fib (n-1) + fib (n-2)

let _ = fib 1 (* - : int = 1 *)
let _ = fib 2 (* - : int = 1 *)
let _ = fib 3 (* - : int = 2 *)
let _ = fib 5 (* - : int = 5 *)
let _ = fib 7 (* - : int = 13 *)

type 'a delay =
  | EV of 'a
  | UN of (unit -> 'a)

let ev (d:'a delay) =
  match d with
  | EV x -> x
  | UN f -> f()

let force (d:'a delay ref) =
  let v = ev !d in
  (d := EV v; v)

(*a*)
let rec fibthree (n:int) : int =
    if n <= 3 then
        1
    else
        fibthree (n - 1) + fibthree (n - 2) + fibthree (n - 3)

let _ = fibthree 1 (* - : int = 1 *)
let _ = fibthree 2 (* - : int = 1 *)
let _ = fibthree 3 (* - : int = 1 *)
let _ = fibthree 4 (* - : int = 3 *)
let _ = fibthree 5 (* - : int = 5 *)
let _ = fibthree 6 (* - : int = 9 *)
let _ = fibthree 7 (* - : int = 17 *)

(*b*)
(*Answer: no*)

(*c*)
let rec delayed_fib_list (n:int) =
    if n = 0 then
        []
    else if n <= 2 then
        (delayed_fib_list (n - 1))@[ref (EV 1)]
    else
        (delayed_fib_list (n - 1))@[ref (UN (fun () -> fib n))]

let _ = delayed_fib_list 4

(*d*)
let calc_somefibs () : int delay ref list =
  let somefibs = delayed_fib_list 10
  in
    let rec force_eval (i:int) (lst:int delay ref list) =
        match lst with
        | [] -> 0
        | hd::tl -> (
            if i = 1 then
                force hd
            else
                force_eval (i - 1) tl
        )
    in
        let _ = force_eval 5 somefibs in
        let _ = force_eval 8 somefibs in
        somefibs

let _ = calc_somefibs ()