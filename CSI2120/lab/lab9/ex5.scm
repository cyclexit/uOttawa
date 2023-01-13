(define (halfTrig theta) 
	(/ (* 2 (let ((x theta)) (tan (/ x 2))))
	  (+ 1 (let ((y (let ((x 1.57)) (tan (/ x 2))))) (* y y))))
)