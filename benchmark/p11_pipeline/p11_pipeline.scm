(import scheme (chicken io) (chicken string))

(define (numbers line)
    (if (string=? line "") 
        '() 
        (map string->number (string-split line))))

(define (sum values)
    (if (null? values) 
        0 
        (+ (car values) (sum (cdr values)))))

(define (maximum values)
    (if (null? (cdr values)) 
        (car values) 
        (max (car values) (maximum (cdr values)))))

(define (keep predicate values)
    (cond 
        ((null? values) '())
        ((predicate (car values)) (cons (car values) (keep predicate (cdr values))))
        (else (keep predicate (cdr values)))))

(define (apply-stage values parts)
    (let ((kind (car parts)) (name (cadr parts)))
        (cond 
            ((string=? kind "map")
                (let ((amount (string->number (caddr parts))))
                    (map (if (string=? name "add") (lambda (x) (+ x amount)) (lambda (x) (* x amount))) values)))
            ((string=? kind "filter")
            (cond 
                ((string=? name "even") (keep even? values))
                ((string=? name "odd") (keep odd? values))
                (else (keep (lambda (x) (> x (string->number (caddr parts)))) values))))
            ((string=? name "sum") (sum values))
            ((null? values) 'none)
            (else (maximum values)))))

(define (pipeline k values)
    (let loop ((i 0) (result values))
        (if (= i k)
            (if (list? result)
                (unless (null? result)
                    (display (car result))
                    (for-each (lambda (x) (display (string-append " " (number->string x)))) (cdr result))
                    (newline))
                (print result))
            (loop (+ i 1) (apply-stage result (string-split (read-line)))))))

(define values (numbers (read-line)))
(define k (string->number (read-line)))
(pipeline k values)
