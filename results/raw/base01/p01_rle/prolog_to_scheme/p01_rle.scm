(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((line (read-line))
         (chars (string->list line))
         (out (encode chars)))
    (display out)
    (newline)
    (exit 0)))

(define (encode lst)
  (cond
    ((null? lst) '())
    (else
     (let loop ((lst lst) (current-char (car lst)) (count 1) (result '()))
       (if (null? lst)
           (reverse (append (list (cons current-char count)) result))
           (let ((next-char (car lst)))
             (if (eqv? next-char current-char)
                 (loop (cdr lst) current-char (+ count 1) result)
                 (loop (cdr lst) next-char 1 (append (list (cons current-char count)) result))))))))

(main)
