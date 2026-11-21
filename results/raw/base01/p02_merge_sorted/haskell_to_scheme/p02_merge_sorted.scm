(import scheme (chicken base) (chicken io))

(define (read-numbers str)
  (map string->number (string-split str #\space)))

(define (merge lst1 lst2)
  (cond ((null? lst1) lst2)
        ((null? lst2) lst1)
        ((<= (car lst1) (car lst2))
         (cons (car lst1) (merge (cdr lst1) lst2)))
        (else
         (cons (car lst2) (merge lst1 (cdr lst2))))))

(define (safe-get-line)
  (if (eof-object? (peek-char))
      ""
      (read-line)))

(define (main)
  (let* ((a (safe-get-line))
         (b (safe-get-line))
         (result (merge (read-numbers a) (read-numbers b))))
    (when (not (null? result))
      (for-each display (map number->string result))
      (newline))))

(main)
