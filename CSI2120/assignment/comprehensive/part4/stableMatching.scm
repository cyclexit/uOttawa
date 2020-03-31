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

(define (get-stud emp-choice emps-pref)
  (cond
    ( (null? emps-pref) null ) ; actually will not happen...
    ( (equal? (car emp-choice) (caar emps-pref)) (list-ref (car emps-pref) (cadr emp-choice)) )
    ( else (get-stud emp-choice (cdr emps-pref)) )
  )
)

; calculation function ;
(define (prefer stud studs-pref new-emp cur-emp)
  (cond
    ( (null? studs-pref) null ) ; actually will not happen...
    ( (equal? stud (caar studs-pref)) (< (index-of (car studs-pref) new-emp) (index-of (car studs-pref) cur-emp)) )
    ( else (prefer stud (cdr studs-pref) new-emp cur-emp) )
  )
)

(define (evaluate emp-choice match emps-pref studs-pref)
  (let ((stud (get-stud emp-choice emps-pref)))
    (cond
      ( (equal? (stud-match stud match) #f) (append match (list (cons (car emp-choice) (list stud)))) )
      ( (equal? (pref stud studs-pref (car emp) (stud-match stud match)) #t) ) ; TODO
      ( else match )
    )
  )
)

(define (offer emps-choices match emps-pref studs-pref)
  (let ((cur (car emps-choices)))
    (cond
      ( (equal? (emp-match (car cur) match) #f) 
        (offer
          (append (cdr emps-choices) (list (cons (car cur) (list (+ 1 (cadr cur))))))
          (evaluate cur match)
          emps-pref
          stud-pref
        )
      )
      ( else match )
    )
  )
)

; main function
(define (stableMatching emps-pref studs-pref)
  (let 
    (
      (emps-choices (choices-gen emps-pref))
      (match '())
    )
    ; emps-choices ; test
    ; emps-pref ; test
    studs-pref ; test
  )
)

(define (findStableMatch emp-file stud-file)
  (let ((emps-pref (read-csv emp-file)) (studs-pref (read-csv stud-file)))
    (stableMatching emps-pref studs-pref)
  )
)