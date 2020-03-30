(define (list-gen l)
  (cond
    ( (null? l) '() )
    ( else (cons (string-split (car l) ",") (list-gen (cdr l))) )
  )
)

(define (read-csv file) 
  (list-gen (string-split (file->string file) "\n"))
)

(define (findStableMatch emp-file stu-file)
  (let ((emp-pref (read-csv emp-file)) (stu-pref (read-csv stu-file)))
    emp-pref 
  )
)