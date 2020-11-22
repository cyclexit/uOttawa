let a = 3.12 in
  let f x = [a;4.2;x] in
  let a = 9.35 in
  let b = f a in
  (a, b)

let m = ref 1 in
  let i = 5 in
  let f j = (j := !j - 1; i - !j) in
  let k = ref 3 in
  let i = 1 in
  let _ = k := f m in
  (i, !k, !m)
