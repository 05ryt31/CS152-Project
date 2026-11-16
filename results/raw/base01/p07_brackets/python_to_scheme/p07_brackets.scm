(import scheme (chicken base) (chicken io))

(define PAIRS '((#\) . #\() (#\] . #\[) (#\} . #\{)))

(define (balanced text)
  (define stack '())
  (define (helper chars)
    (cond ((null? chars) (null? stack))
          ((member (car chars) '(#\(#\[ #\{))
           (helper (cons (cdr chars))))
          (else
           (if (or (null? stack) (not (eqv? (car stack) (cdr (assoc (car chars) PAIRS)))))
               #f
               (helper (cons (cdr chars)))))))
  (helper (string->list text)))

(define (main)
  (let loop ()
    (let ((n (string->number (read-line))))
      (when (> n 0)
        (do ((i 0 (+ i 1))) ((= i n))
          (let ((line (read-line)))
            (if (balanced line)
                (display "yes\n")
                (display "no\n"))))
        (loop)))))

(main)
