(import scheme (chicken io) (chicken sort))

(define (remove-first value values)
    (cond 
        ((null? values) '())
        ((char=? value (car values)) (cdr values))
        (else (cons (car values) (remove-first value (cdr values))))))

(define (generate prefix remaining)
    (if (null? remaining)
        (begin 
            (display (list->string (reverse prefix))) 
            (newline))
        (for-each (lambda (letter)
                    (generate (cons letter prefix) (remove-first letter remaining)))
                    remaining)))

(define letters (sort (string->list (read-line)) char<?))
(generate '() letters)
