(define choices 
  '(
    ("marie" ("peru" "greece" "vietnam"))
    ("jean" ("greece" "peru" "vietnam"))
    ("sasha" ("vietnam" "peru" "greece"))
    ("helena" ("peru" "vietnam" "greece"))
    ("emma" ("greece" "peru" "vietnam"))
  )
)

(define (add-places rank places)
  (cond
    ( (null? rank) places )
    ( (equal? #f (member (car rank) places)) (add-places (cdr rank) (append places (list (car rank)))) )
    ( else (add-places (cdr rank) places) )
  )
)

(define (do-add-places choices places)
  (cond 
    ( (null? choices) places )
    ( else (do-add-places (cdr choices) (add-places (cadar choices) places)) )
  )
)

(define (assign-pts rank pts)
  (if (null? rank) 
    '()
    (cons (cons (car rank) pts) (assign-pts (cdr rank) (- pts 1)))
  )
)

(define (do-assign-pts choices)
  (if (null? choices)
    '()
    (append (assign-pts (cadar choices) 3) (do-assign-pts (cdr choices)))
  )
)
