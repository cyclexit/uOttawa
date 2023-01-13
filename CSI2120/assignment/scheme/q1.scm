(define (changeList l)
  (cond
    ( (null? l) '() )
    ( (<= -1 (car l) 1)  (changeList (cdr l)) )
    ( (> (car l) 1) (cons (* (car l) 10) (changeList (cdr l))) )
    ( (< (car l) -1) (cons (/ 1 (abs(car l))) (changeList (cdr l))) )
  )
)