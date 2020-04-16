; part a)
(define (numOccur num arr)
  (cond
    ((null? arr) 0)
    ((equal? num (car arr)) (+ 1 (numOccur num (cdr arr))))
    (else (numOccur num (cdr arr)))
  )
)

; part b)
(define (frequency arr)
  (if (null? arr)
    '()
    (let ((sarr (sort arr <)))
      (let solv
        (
          (tail (cdr sarr))
          (head (car sarr))
          (cnt 1)
        )
        (cond
          ( (null? tail) (list (list head cnt)) )
          ( (equal? head (car tail)) (solv (cdr tail) head (+ 1 cnt)) )
          ( else (cons (list head cnt) (solv (cdr tail) (car tail) 1)) )
        )
      )
    )
  )
)