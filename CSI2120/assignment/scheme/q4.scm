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
