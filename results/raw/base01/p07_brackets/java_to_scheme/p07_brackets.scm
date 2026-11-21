(import scheme (chicken base) (chicken io))

(define (balanced text)
  (if (null? text)
      #t
      (let loop ((chars (string->list text))
                 (stack '()))
        (cond
          ((null? chars)
           (null? stack))
          ((member (car chars) '(#\( #\[ #\{))
           (loop (cdr chars) (cons (car chars) stack)))
          (else
           (let ((top (car stack)))
             (cond
               ((or (null? top)
                    (and (eqv? (car chars) #\)) (not (eqv? top #\())))
                     (and (eqv? (car chars) #\]) (not (eqv? top #\[)))
                     (and (eqv? (car chars) #\}) (not (eqv? top #\{)))))
                (return #f))
               (else
                (loop (cdr chars) (cdr stack))))))))))

(define (main)
  (let* ((n (string->number (read-line)))
         (results (map balanced (sequence 0 (- n 1)))))
    (for-each (lambda (result)
                (display (if result "yes" "no"))
                (newline))
              results)))

(main)
