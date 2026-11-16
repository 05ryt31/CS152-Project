(import scheme (chicken base) (chicken io))

(define (rle str)
  (define (helper s i)
    (if (< i (string-length s))
        (let loop ((j i) (count 1))
          (if (and (< j (- (string-length s) 1)) (= (char->integer (string-ref s j)) (char->integer (string-ref s (+ j 1)))))
              (loop (+ j 1) (+ count 1))
              (begin
                (display (string-ref s i))
                (display count)
                (helper s (+ j 1)))))))
        (void)))
  (helper str 0))

(let ((line (read-line)))
  (rle line)
  (newline))
