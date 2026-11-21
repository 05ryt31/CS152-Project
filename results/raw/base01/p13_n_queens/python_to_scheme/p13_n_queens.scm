(import scheme (chicken base) (chicken io))

(define (safe columns row col)
  (define (loop prev-row)
    (if (< prev-row row)
        (let ((prev-col (list-ref columns prev-row)))
          (if (or (= prev-col col) (= (abs (- prev-col col)) (- row prev-row)))
              #f
              (loop (+ prev-row 1))))
        #t))
  (loop 0))

(define (count n row columns)
  (if (= row n)
      1
      (let loop ((col 0) (total 0))
        (if (< col n)
            (if (safe columns row col)
                (loop (+ col 1) (+ total (count n (+ row 1) (cons col columns))))
                (loop (+ col 1) total))
            total))))

(define (main)
  (let* ((n (string->number (read-line)))
         (result (count n 0 '())))
    (display result)
    (newline)))

(main)
