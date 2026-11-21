(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((reader (open-input-port))
         (values (map string->number (string-split (read-line reader) #\space)))
         (k (string->number (read-line reader)))
         (result values))
    (do ((i 0 (+ i 1))) ((= i k))
      (let* ((line (read-line reader))
             (parts (string-split line #\space))
             (op (car parts))
             (arg1 (cadr parts))
             (arg2 (if (<= (length parts) 2) "" (caddr parts))))
        (cond
          ((string=? op "map")
           (set! values
                 (map (lambda (x)
                        (if (string=? arg1 "add")
                            (+ x (string->number arg2))
                            (* x (string->number arg2))))
                      values)))
          ((string=? op "filter")
           (set! values
                 (filter (lambda (x)
                           (cond
                             ((and (string=? arg1 "even") (= (modulo x 2) 0))
                              #t)
                             ((and (string=? arg1 "odd") (not (= (modulo x 2) 0)))
                              #t)
                             ((and (string=? arg1 "gt") (> x (string->number arg2)))
                              #t)
                             (else
                              #f)))
                       values)))
          ((string=? arg1 "sum")
           (set! result
                 (apply + values)))
          (else
           (if (null? values)
               (set! result "none")
               (set! result
                     (foldl max -inf.0 values)))))))
    (if (list? result)
        (begin
          (for-each (lambda (x)
                      (when (> (current-output-port-position) 0)
                        (display " "))
                      (display x))
                    result)
          (newline))
        (display result)
        (newline))))

(main)
