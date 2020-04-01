(require racket/trace) ; test

; test data ;
(define emps-choices '(("Thales" 1) ("Canada Post" 1) ("Cisco" 1)))

(define emps-pref '(("Thales" "Olivia" "Jackson" "Sophia") ("Canada Post" "Sophia" "Jackson" "Olivia") ("Cisco" "Olivia" "Sophia" "Jackson")))

(define studs-pref '(("Olivia" "Thales" "Canada Post" "Cisco") ("Jackson" "Thales" "Canada Post" "Cisco") ("Sophia" "Cisco" "Thales" "Canada Post")))

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

(define (update-match match stud new-emp)
  (cond
    ( (null? match) null ) ; actually will not happen...
    ( (equal? (cadar match) stud) (cons (cons new-emp (list stud)) (cdr match)) )
    ( else (cons (car match) (update-match (cdr match) stud new-emp)) )
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
      ( (equal? (prefer stud studs-pref (car emp-choice) (stud-match stud match)) #t) (update-match match stud (car emp-choice)) )
      ( (equal? (prefer stud studs-pref (car emp-choice) (stud-match stud match)) #f) #f)
      ( else match )
    )
  )
)

(define (offer emps-choices match emps-pref studs-pref)
  (let ((cur (car emps-choices)))
    (cond
      ( (equal? (emp-match (car cur) match) #f)
        (cond
          ( (equal? (evaluate cur match emps-pref studs-pref) #f) 
            (offer
              (cons (cons (caar emps-choices) (list (+ (cadar emps-choices) 1))) (cdr emps-choices))
              match
              emps-pref
              studs-pref
            )
          )
          ( else 
            (offer
              (append (cdr emps-choices) (list (cons (car cur) (list (+ 1 (cadr cur))))))
              (evaluate cur match emps-pref studs-pref)
              emps-pref
              studs-pref
            )
          )
        )
      )
      ( (< (length match) (length emps-pref)) 
        (offer
          (append (cdr emps-choices) (list (car emps-choices)))
          match
          emps-pref
          studs-pref
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

; (trace offer) ; test
; (trace evaluate) ; test
; (trace prefer) ; test
; (trace update-match) ; test