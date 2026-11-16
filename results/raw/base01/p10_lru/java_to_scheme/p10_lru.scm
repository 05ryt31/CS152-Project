(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((reader (open-input-port "stdin"))
         (capacity (string->number (read-line reader)))
         (n (string->number (read-line reader)))
         (cache (make-hash-table)))
    (define (remove-eldest-entry? table)
      (> (hash-table-count table) capacity))
    (define lru-cache
      (make-hash-table
       :test equal?
       :weakness 'value
       :delete-proc (lambda (key value) (hash-table-remove! lru-cache key))))
    (do ((i 0 (+ i 1))) ((= i n))
      (let* ((line (read-line reader))
             (parts (string-split line #\space))
             (op (car parts))
             (key (string->number (cadr parts))))
        (cond
          ((string=? op "get")
           (if (hash-table-exists? lru-cache key)
               (begin
                 (hash-table-set! lru-cache key (hash-table-ref lru-cache key))
                 (display (hash-table-ref lru-cache key))
                 (newline))
               (begin
                 (display -1)
                 (newline))))
          ((string=? op "set")
           (hash-table-set! lru-cache key (string->number (caddr parts)))))))
    (exit 0)))

(main)
