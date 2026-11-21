(import scheme (chicken base) (chicken io))

(define (main args)
  (let* ((line (read-line))
         (seen (make-hash-table))
         (result '()))
    (when line
      (let loop ((tokens (string-split (string-trim line) #\space)))
        (when tokens
          (let ((value (string->number (car tokens))))
            (unless (hash-table-exists? seen value)
              (hash-table-set! seen value #t)
              (set! result (cons value result))))
          (loop (cdr tokens)))))
    (when result
      (display (string-join (map number->string (reverse result)) " "))
      (newline))))

(main (command-line-arguments))
