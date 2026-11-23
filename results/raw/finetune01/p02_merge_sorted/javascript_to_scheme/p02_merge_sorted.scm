(define merge
  (lambda (l r)
    (cond ((null? l) r)
          ((null? r) l)
          ((<= (car l) (car r))
           (cons (car l) (merge (cdr l) r)))
          (else
           (cons (car r) (merge l (cdr r)))))))
 
(display (merge '(1 3 5 7 9) '(2 4 6 8))) (newline)
