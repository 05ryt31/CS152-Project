(import scheme (chicken base) (chicken io))

(define (read-numbers str)
  (map string->number (string-split str #\space)))

(define (unique lst)
  (define (loop seen rest)
    (cond ((null? rest) '())
          ((member (car rest) seen) (loop seen (cdr rest)))
          (else (cons (car rest) (loop (cons (car rest) seen) (cdr rest))))))
  (loop '() lst))

(define (safe-get-line)
  (if (eof-object? (peek-char))
      ""
      (read-line)))

(define (main)
  (let* ((line (safe-get-line))
         (result (unique (read-numbers line))))
    (when (not (null? result))
      (for-each display (map number->string result))
      (newline))))

(main)
