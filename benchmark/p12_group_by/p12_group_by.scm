(import scheme (chicken io) (chicken string) (chicken sort))

(define (keep predicate values)
    (if (null? values) 
        '()
        (if (predicate (car values))
            (cons (car values) (keep predicate (cdr values)))
            (keep predicate (cdr values)))))

(define (without key groups)
    (keep (lambda (group) (not (string=? key (car group)))) groups))

(define (update key value groups)
    (let ((entry (assoc key groups)))
        (if entry
            (cons (list key (+ (cadr entry) value) (+ (caddr entry) 1))
                (without key groups))
            (cons (list key value 1) groups))))

(define (read-groups n)
    (let loop ((i 0) (groups '()))
        (if (= i n) 
            groups
            (let ((parts (string-split (read-line))))
                (loop (+ i 1) (update (car parts) (string->number (cadr parts)) groups))))))

(define (print-groups groups)
    (for-each (lambda (group) (print (car group) " " (cadr group) " " (caddr group)))
    (sort groups (lambda (a b) (string<? (car a) (car b))))))

(define n (string->number (read-line)))
(define groups (read-groups n))
(print-groups groups)
