let x = true in
  let f (y:bool) : int =
    if (x || y) then 10 else 5 in
  let x = false in
  let g (z:bool) : float =
    let w = (f z) in
    2.1 *. (float_of_int w) in
  let y = g x in
  y