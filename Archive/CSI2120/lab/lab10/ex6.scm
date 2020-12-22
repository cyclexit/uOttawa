(define Q `(1 2 (3 4) 1 5 (7 8)))

(define (append-list l1 l2)
  (if (null? l1) 
      l2
      (cons (car l1) (append-list (cdr l1) l2))
  )
)

(define (sum-list l)
  (if (null? l)
    0
    (+ (car l) (sum-list (cdr l)))
  )
)

(define (addSubList l)
  (cond
    ((null? l) '())
    ( (list? (car l)) (cons (sum-list (car l)) (addSubList (cdr l))) )
    (else (cons (car l) (addSubList (cdr l))))
  )
)