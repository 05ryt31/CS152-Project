(import scheme (chicken base) (chicken io))

(define (safe columns row col)
  (define (loop previous)
    (cond ((>= previous row) #t)
          ((or (= (vector-ref columns previous) col)
               (= (abs (- (vector-ref columns previous) col)) (- row previous)))
           #f)
          (else (loop (+ previous 1)))))
  (loop 0))

(define (count n row columns)
  (if (= row n)
      1
      (let loop ((col 0) (total 0))
        (if (< col n)
            (if (safe columns row col)
                (loop (+ col 1) (+ total (count n (+ row 1) (begin (vector-set! columns row col) columns))))
                (loop (+ col 1) total))
            total))))

(define (main)
  (let* ((n (string->number (read-line)))
         (result (count n 0 (make-vector n 0))))
    (display result)
    (newline)))

(main)
