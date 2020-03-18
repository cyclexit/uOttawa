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