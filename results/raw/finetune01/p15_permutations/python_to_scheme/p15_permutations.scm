 
(define (permutations l)
  (cond ((null? l) '(()))
        ((null? (cdr l)) (list l))
        (else (let ((r (permutations (cdr l))))
                (append (map (lambda (x) (cons (car l) x))
                             r)
                        (map (lambda (x) (cons (cadr l) x))
                             r))))))
 
