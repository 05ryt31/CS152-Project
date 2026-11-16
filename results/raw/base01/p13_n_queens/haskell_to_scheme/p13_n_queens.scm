(import scheme (chicken base) (chicken io))

(define (safe cols col)
  (all (lambda (cd) (and (/= (car cd) col) (/= (abs (- (car cd) col)) (cdr cd))))
       (zip cols (iota 1))))

(define (count n row cols)
  (if (= row n)
      1
      (apply + (map (lambda (col)
                      (count n (+ row 1) (cons col cols)))
                    (iota n)
                    (filter (lambda (col) (safe cols col))
                            (iota n))))))

(define (iota n)
  (let loop ((i 0) (acc '()))
    (if (< i n)
        (loop (+ i 1) (cons i acc))
        (reverse acc))))

(define (all pred lst)
  (cond ((null? lst) #t)
        ((not (pred (car lst))) #f)
        (else (all pred (cdr lst)))))

(define (main)
  (let* ((n (string->number (read-line)))
         (result (count n 0 '())))
    (display result)
    (newline)))

(main)
