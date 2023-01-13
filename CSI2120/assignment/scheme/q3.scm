; test data
(define choices 
  '(
    ("marie" ("peru" "greece" "vietnam"))
    ("jean" ("greece" "peru" "vietnam"))
    ("sasha" ("vietnam" "peru" "greece"))
    ("helena" ("peru" "vietnam" "greece"))
    ("emma" ("greece" "peru" "vietnam"))
    ("jane" ("greece" "vietnam" "peru")) ; test for tied situation
  )
)
; test data

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

(define (calc-result place pts res)
  (cond
    ( (null? pts) res)
    ( (equal? (caar pts) place) (calc-result place (cdr pts) (+ res (cdar pts))) )
    ( else (calc-result place (cdr pts) res) )
  )
)

(define (do-calc-result places pts)
  (cond
    ( (null? places) '() )
    ( else (cons (cons (car places) (calc-result (car places) pts 0)) (do-calc-result (cdr places) pts)) )
  )
)

(define (get-max-score res max-score)
  (cond
    ( (null? res) max-score )
    ( (null? max-score) (get-max-score (cdr res) (cdar res)) )
    ( (< max-score (cdar res)) (get-max-score (cdr res) (cdar res)) )
    ( else (get-max-score (cdr res) max-score) )
  )
)

(define (get-ans res max-score ans)
  (cond
    ( (null? res) ans )
    ( (equal? (cdar res) max-score) (get-ans (cdr res) max-score (append ans (list (car res)))) )
    ( else (get-ans (cdr res) max-score ans) )
  )
)

(define (destination choices)
  (let ((places (do-add-places choices '())) (pts (do-assign-pts choices)))
    (let ((res (do-calc-result places pts)))
      (let ((max-score (get-max-score res null)))
        (get-ans res max-score '())
      )
    )
  )
)