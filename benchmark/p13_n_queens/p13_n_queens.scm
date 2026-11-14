(import scheme (chicken io))

(define (n-queens-count n)
    (define (safe? queens col)
        (let loop ((qs queens) (dist 1))
            (or (null? qs)
                (and (not (= (car qs) col))
                    (not (= (abs (- (car qs) col)) dist))
                    (loop (cdr qs) (+ dist 1))))))

    (define (count row queens)
        (if (= row n)
            1
            (let loop ((col 0) (total 0))
                (if (= col n)
                    total
                    (if (safe? queens col)
                        (loop (+ col 1) (+ total (count (+ row 1) (cons col queens))))
                        (loop (+ col 1) total))))))
                        
    (count 0 '()))

(define n (string->number (read-line)))
(print (n-queens-count n))
