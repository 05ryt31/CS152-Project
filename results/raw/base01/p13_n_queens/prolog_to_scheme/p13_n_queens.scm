(import scheme (chicken base) (chicken io))

(define (p13-n-queens)
  (let* ((line (read-line))
         (n (string->number line))
         (result (aggregate-all count (n-queens n '()))))
    (display result)
    (newline)
    (exit 0)))

(define (n-queens n columns)
  (cond
    ((= n (length columns)) (list columns))
    (else
     (let loop ((col 0))
       (if (< col n)
           (let ((new-columns (cons col columns)))
             (if (safe new-columns columns)
                 (append (n-queens n new-columns) (loop (+ col 1)))
                 (loop (+ col 1))))
           '())))))

(define (safe new-column columns dist)
  (cond
    ((null? columns) #t)
    (else
     (let ((previous (car columns)))
       (and (/= previous new-column)
            (/= (abs (- previous new-column)) dist)
            (safe new-column (cdr columns) (+ dist 1)))))))

(p13-n-queens)
