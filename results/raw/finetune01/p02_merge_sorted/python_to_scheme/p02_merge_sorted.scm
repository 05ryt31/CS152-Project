(define merge
  (lambda (a b)
    (cond ((null? a) b)
          ((null? b) a)
          ((<= (car a) (car b)) (cons (car a) (merge (cdr a) b)))
          (else (cons (car b) (merge a (cdr b)))))))
 
(display (merge '(1 3 5 7 9) '(2 4 6 8))) (newline)
