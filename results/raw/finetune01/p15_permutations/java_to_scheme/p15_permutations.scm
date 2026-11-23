(define (permutations s)
  (if (null? s)
      '(())
      (apply append
             (map (lambda (x)
                    (map (lambda (p) (cons x p))
                         (permutations (remove x s))))
                  s))))
 
(display (permutations "abc"))
(newline)
