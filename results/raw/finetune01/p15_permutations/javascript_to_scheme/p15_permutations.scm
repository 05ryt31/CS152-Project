(define (permutations l)
  (cond ((null? l) '(()))
        ((null? (cdr l)) (list l))
        (else (append-map
               (lambda (x) (map (lambda (y) (cons x y))
                                (permutations (remove x l))))
               l))))
 
(display (permutations "abc"))
(newline)
