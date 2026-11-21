(import scheme (chicken base) (chicken io))

(define (main args)
  (define lines (string-split (read-string) #\newline))
  (define n (string->number (car lines)))
  
  (define balance 0)
  (define output '())
  
  (define (process-command command amount)
    (cond
      ((string=? command "deposit") (set! balance (+ balance amount)))
      ((and (string=? command "withdraw") (> amount balance)) (set! output (cons "error" output)))
      ((string=? command "withdraw") (set! balance (- balance amount)))
      (else (set! output (cons (number->string balance) output)))))
  
  (do ((i 1 (+ i 1))) ((> i n))
    (call-with-values (lambda () (string-split (list-ref lines i) #\space))
                      (lambda (command amount)
                        (process-command command (string->number amount)))))
  
  (when (not (null? output))
    (display (string-join output "\n"))
    (newline)))

(main (command-line-arguments))
