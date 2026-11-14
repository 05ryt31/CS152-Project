(import scheme (chicken io))

(define (matching? opener closer)
    (or (and (char=? opener #\() (char=? closer #\)))
        (and (char=? opener #\[) (char=? closer #\]))
        (and (char=? opener #\{) (char=? closer #\}))))

(define (balanced? text)
    (let loop ((chars (string->list text)) (stack '()))
        (cond 
            ((null? chars) (null? stack))
            ((memv (car chars) '(#\( #\[ #\{))
                (loop (cdr chars) (cons (car chars) stack)))
            ((null? stack) #f)
            ((matching? (car stack) (car chars))
            (loop (cdr chars) (cdr stack)))
            (else #f))))

(define n (string->number (read-line)))
(do ((i 0 (+ i 1))) ((= i n))
    (print 
        (if (balanced? (read-line)) 
            "yes" 
            "no")))
