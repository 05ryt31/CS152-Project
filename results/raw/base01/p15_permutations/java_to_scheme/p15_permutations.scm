(import scheme (chicken base) (chicken io))

(define (generate letters used current)
  (if (= (string-length current) (length letters))
      (begin
        (display current)
        (newline))
      (for-each (lambda (i)
                  (when (not (list-ref used i))
                    (set-car! (list-tail used i) #t)
                    (string-append! current (string (list-ref letters i)))
                    (generate letters used current)
                    (string-set! current (- (string-length current) 1) #\null)
                    (set-car! (list-tail used i) #f)))
                (iota (length letters)))))

(define (main)
  (let* ((input (read-line))
         (letters (string->list input))
         (sorted-letters (sort letters char<?))
         (used (make-list (length sorted-letters) #f)))
    (generate sorted-letters used "")))

(main)
