((lambda (x y) (+ (* (sin x) (cos y)) (* (cos x) (sin y)))) (/ pi 4) (/ pi 3))

(define sin_sum
  (lambda (a b)
    (+ (* (sin a) (cos b)) (* (cos a) (sin b)))
  )
)