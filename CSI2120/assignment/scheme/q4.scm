(define (sigmoid v)
  (/ 1 (+ 1 (exp (- 0 v))))
)

(define (neuralNode params sigmoid)
  (letrec 
    (
      (calc (
        lambda (lst)
          (sigmoid (+ (car params) (+ (* (cadr params) (car lst)) (* (caddr params) (cadr lst)))))
        )
      )
    )
    calc
  )
)
