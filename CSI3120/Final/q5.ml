exception Answer_is of int

let z = 23 in
let f (x:int) : int =
  if x = 0 then raise (Answer_is z)
  else z / x in
let z = 38 in
let g (n:int) : int =
  try (f (n - 7))
  with | Answer_is i -> raise (Answer_is z) in
let z = 5 in
let h (k:int) = try (g (z + k))
                with | Answer_is i -> (z * i) + 2 in
(h 2)