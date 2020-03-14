(let ((a 3) (b 4)) (* a b))

(
  define (fact n)
  (
    if (> n 0)
      (* n (fact (- n 1))) 1 
  )
)

(
  define gcd
  (
    lambda (a b)
    (
      if (= a b) a
      (
        if (> a b)
          (gcd (- a b) b)
          (gcd a (- b a))
      )
    )
  )
)