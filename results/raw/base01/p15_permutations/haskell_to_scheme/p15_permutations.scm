(import scheme (chicken base) (chicken io))

(define (permutations lst)
  (cond ((null? lst) (list '()))
        (else (apply append (map (lambda (pair)
                                    (map (lambda (perm)
                                           (cons (car pair) perm))
                                             (permutations (cdr pair))))
                                (picks lst))))))

(define (picks lst)
  (if (null? lst)
      '()
      (append (list (cons (car lst) (cdr lst)))
              (map (lambda (pair)
                     (cons (car pair) (cons (car lst) (cdr pair))))
                   (picks (cdr lst))))))

(define (main)
  (let ((line (read-line)))
    (for-each display (sort (permutations line)))
    (newline)))

(main)
