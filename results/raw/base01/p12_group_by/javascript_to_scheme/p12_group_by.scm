(import scheme (chicken base) (chicken io))

(define (main args)
  (define lines (string-split (read-string) #\newline))
  (define n (string->number (car lines)))
  
  (define groups (make-hash-table))
  
  (do ((i 0 (+ i 1)))
      ((= i n))
    (let* ((line (list-ref lines (+ i 1)))
           (parts (string-split line #px"\\s+"))
           (key (car parts))
           (raw (cadr parts))
           (value (string->number raw))
           (group (hash-table-ref/default groups key '(0 . 0))))
      (hash-table-set! groups key (cons (+ (car group) value) (+ (cdr group) 1)))))
  
  (let loop ((keys (sort (hash-table-keys groups) string<?)))
    (if (null? keys)
        (exit 0)
        (begin
          (display (car keys))
          (display " ")
          (display (car (hash-table-ref groups (car keys))))
          (display " ")
          (display (cdr (hash-table-ref groups (car keys))))
          (newline)
          (loop (cdr keys)))))))

(main (command-line-arguments))
