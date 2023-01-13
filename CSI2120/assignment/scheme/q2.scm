(require racket/trace) ; test
(define tl '(0 1 5 3 3 3 2 1 1 1)) ; test
(define taux '(1 1 1 1 2 3 1 1 2)) ; test

(define (mark-len l pre cnt)
  (cond
    ( (null? l) '() )
    ( (null? pre) (cons cnt (mark-len (cdr l) (car l) cnt)) )
    ( (equal? pre (car l)) (cons (+ cnt 1) (mark-len (cdr l) (car l) (+ cnt 1))) )
    ( else (cons 1 (mark-len (cdr l) (car l) 1)) )
  )
)

(define (last-max aux l len val)
  (cond
    ( (null? aux) (list len val) )
    ( (null? len) (last-max (cdr aux) (cdr l) (car aux) (car l)) )
    ( (>= (car aux) len) (last-max (cdr aux) (cdr l) (car aux) (car l)) )
    ( else (last-max (cdr aux) (cdr l) len val) )
  )
)

(define (list-gen len val)
  (if (= len 0)
    '()
    (cons val (list-gen (- len 1) val))
  )
)

(define (sameNum l)
  (let ((aux (mark-len l null 1)))
    (let ((res (last-max aux l null null)))
      (list-gen (car res) (cdr res))
    )
  )
)

; (trace mark-len) ; test
; (trace last-max) ; test