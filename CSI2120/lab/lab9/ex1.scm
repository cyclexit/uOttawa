(define sum_sqr
  (lambda (n)
    (if (= n 0) 0
      (+ (* n n) (sum_sqr (- n 1)))
    )
  )
)

(define sol_quar
  (lambda (a b c)
    (if (> 0 (- (* b b) (* 4 (* a c)))) "no real roots"
      (values
        (/ (+ (- 0 b) (sqrt (- (* b b) (* 4 (* a c))))) (* 2 a))
        (/ (- (- 0 b) (sqrt (- (* b b) (* 4 (* a c))))) (* 2 a))
      )
    )
  )
)

(+ (* (sin (/ pi 4)) (cos (/ pi 3))) (* (cos (/ pi 4)) (sin (/ pi 3))))