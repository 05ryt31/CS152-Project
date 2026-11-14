(import scheme (chicken io) (chicken string))

(define (numbers line)
    (if (string=? line "") 
        '() 
        (map string->number (string-split line))))

(define (merge a b)
    (cond ((null? a) b)
          ((null? b) a)
          ((<= (car a) (car b)) (cons (car a) (merge (cdr a) b)))
          (else (cons (car b) (merge a (cdr b))))))

(define (print-list values)
    (unless (null? values)
        (display (car values))
        (for-each (lambda (value) (display (string-append " " (number->string value))))
                  (cdr values))
        (newline)))

(define (safe-read-line)
    (let ((line (read-line)))
        (if (eof-object? line)
            ""
            line)))

(print-list (merge (numbers (safe-read-line)) (numbers (safe-read-line))))
