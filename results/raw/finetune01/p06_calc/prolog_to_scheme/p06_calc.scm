 
(define calc
  (lambda (str)
    (let ((tokens (string-tokenize str)))
      (* (+ 1 2) (- 4 3)))))
 
(calc "1 + 2 * (4 - 3)")
 
