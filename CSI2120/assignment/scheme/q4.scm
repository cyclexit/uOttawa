(define (sigmoid v)
  (/ 1 (+ 1 (exp (- 0 v))))
)

(define (neuralNode params sigmoid)
  (lambda (inputs)
    (sigmoid (+ (car params) (+ (* (cadr params) (car inputs)) (* (caddr params) (cadr inputs)))))
  )
)

(define (neuralLayer params-list)
  (lambda (inputs)
    (cond
      ( (null? params-list) '()) ; test
      ( else (cons ((neuralNode (car params-list) sigmoid) inputs) ((neuralLayer (cdr params-list)) inputs)) );test
    )
  )
)

(define (neuralNet inputs)
  (let ((zs ((neuralLayer '((0.1 0.3 0.4) (0.5 0.8 0.3) (0.7 0.6 0.6))) inputs)))
    ( sigmoid (+ 0.5 (+ (* 0.3 (car zs)) (+ (* 0.7 (cadr zs)) (* 0.1 (caddr zs))))) )
  )
)

(define (calc-x1 k n)
  (sin (/ (* (* 2 pi) (- k 1)) n))
)

(define (calc-x2 k n)
  (cos (/ (* (* 2 pi) (- k 1)) n))
)

(define (useNet k n)
  (cond
    ( (> k n) '() )
    ( else 
      (let ((x1 (calc-x1 k n)) (x2 (calc-x2 k n)))
        (cons (neuralNet (list x1 x2)) (useNet (+ 1 k) n))
      )
    )
  )
)

(define (applyNet n)
  (useNet 1 n)
)