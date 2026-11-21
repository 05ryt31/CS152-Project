(import scheme (chicken base) (chicken io))

(define (generate letters used current out)
  (if (= (length current) (length letters))
      (begin
        (set! out (cons (list->string current) out))
        (return))
      (for ([i (in-range (length letters))])
        (when (not (list-ref used i))
          (set-car! (list-tail used i) #t)
          (set! current (append current (list (list-ref letters i))))
          (generate letters used current out)
          (set! current (butlast current))
          (set-car! (list-tail used i) #f)))))


(define (main)
  (let* ((letters (sort (string->list (read-line)) char<?))
         (results '()))
    (generate letters (make-list (length letters) #f) '() results)
    (for-each displayln results)))

(main)
