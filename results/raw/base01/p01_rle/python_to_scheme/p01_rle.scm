(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((line (read-line))
         (result "")
         (i 0))
    (while (< i (string-length line))
      (let loop ((j i))
        (if (and (< j (string-length line)) (char=? (string-ref line i) (string-ref line j)))
            (loop (+ j 1))
            (begin
              (set! result (string-append result (string (string-ref line i)) (number->string (- j i))))
              (set! i j)))))
    (display result)
    (newline)))

(main)
