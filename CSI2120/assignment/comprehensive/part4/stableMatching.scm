(define (list-gen l)
  (cond
    ( (null? l) '() )
    ( else (cons (string-split (car l) ",") (list-gen (cdr l))) )
  )
)

(define (read-csv file) 
  (list-gen (string-split (file->string file) "\n"))
)

(define (choices-gen emp-pref)
  (cond
    ( (null? emp-pref) '())
    ( else (cons (cons (caar emp-pref) (list 1)) (choices-gen (cdr emp-pref))) )
  )
)

(define (stableMatching emp-pref stu-pref)
  (let ((emp-choices (choices-gen emp-pref)))
    emp-choices ; test
  )
)

(define (findStableMatch emp-file stu-file)
  (let ((emp-pref (read-csv emp-file)) (stu-pref (read-csv stu-file)))
    (stableMatching emp-pref stu-pref)
  )
)