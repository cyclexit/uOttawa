; input handler ;
(define (list-gen l)
  (cond
    ( (null? l) '() )
    ( else (cons (string-split (car l) ",") (list-gen (cdr l))) )
  )
)

(define (read-csv file) 
  (list-gen (string-split (file->string file) "\n"))
)

(define (choices-gen emps-pref)
  (cond
    ( (null? emps-pref) '())
    ( else (cons (cons (caar emps-pref) (list 1)) (choices-gen (cdr emps-pref))) )
  )
)

(define (get-emps emps-pref)
  (cond
    ( (null? emps-pref) '())
    ( else (cons (caar emps-pref) (get-emps (cdr emps-pref))) )
  )
)

; assistant function ;
(define (emp-match emp match) 
  (cond
    ( (null? match) #f )
    ( (equal? emp (caar match)) (cadar match) ) ; found the matched student
    ( else (emp-match emp (cdr match)) )
  )
)

(define (stud-match stud match)
  (cond
    ( (null? match) #f )
    ( (equal? stud (cadar match)) (caar match) ) ; found the matched employee
    ( else (stud-match stud (cdr match)) )
  )
)

; update the match, 
; return: the updated match
; use: evaluate
(define (offer emp emps-choices emps-pref studs-pref match)
  (cond
    (()) ; TODO: here
  )
)

(define (solve emps emps-choices emps-pref studs-pref match)
  (cond
    ( (null? emps) match )
    ( else 
      (solve 
        (cdr emps) 
        emps-choices 
        emps-pref 
        studs-pref 
        (offer (car emps) emps-choices emps-pref studs-pref match)
      ) 
    )
  )
)

; main function
(define (stableMatching emps-pref studs-pref)
  (let 
    ( 
      (emps (get-emps emps-pref))
      (emps-choices (choices-gen emps-pref))
      (match '())
    )
    ; emps ; test
    (solve emps emps-choices emps-pref studs-pref match)
  )
)

(define (findStableMatch emp-file stud-file)
  (let ((emps-pref (read-csv emp-file)) (studs-pref (read-csv stud-file)))
    (stableMatching emps-pref studs-pref)
  )
)