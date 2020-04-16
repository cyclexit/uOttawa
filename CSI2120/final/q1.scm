; pre-defined name list
(define names '("marie" "jean" "claude" "emma" "sam" "tom" "eve" "bob"))

; part a): first function
(define (first sz arr)
  (if (equal? sz 0)
    '()
    (cons (car arr) (first (- sz 1) (cdr arr)))
  )
)

; part b): insertAt function
(define (insertAt elem arr index)
  (cond
    ((null? arr) (list elem))
    ((equal? index 0) (cons elem arr))
    (else (cons (car arr) (insertAt elem (cdr arr) (- index 1))))
  )
)

; part c): shuffle function
(define (shuffle lst n)
  (if (= n 0)
    lst
    (shuffle (insertAt (car lst) (cdr lst) (random (- (length lst) 1))) (- n 1))
  )
)

; part c): winner function
(define (winner lst n)
  (first n (shuffle lst 20))
)