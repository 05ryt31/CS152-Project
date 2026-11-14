(import scheme (chicken io) (chicken string))

(define (numbers line)
    (if (string=? line "") 
        '() 
        (map string->number (string-split line))))

(define (dedupe values seen)
    (if (null? values)
        '()
        (let ((value (car values)))
            (if (member value seen)
                (dedupe (cdr values) seen)
                (cons value (dedupe (cdr values) (cons value seen)))))))

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

(print-list (dedupe (numbers (safe-read-line)) '()))
