(import scheme (chicken base) (chicken io))

(define (touch key)
  (let ((item (hash-table-ref values key #f)))
    (when item
      (hash-table-remove! values key)
      (hash-table-set! values key item))))

(let* ((lines (string-split (read-string) "\n"))
       (capacity (string->number (car lines)))
       (n (string->number (cadr lines)))
       (values (make-hash-table))
       (output '()))
  (do ((i 0 (+ i 1))) ((= i n))
    (let* ((parts (string-split (list-ref lines (+ i 2)) #\space))
           (key (string->number (cadr parts))))
      (cond
        ((string=? (car parts) "get")
         (if (hash-table-exists? values key)
             (begin
               (set! output (append output (list (number->string (hash-table-ref values key)))))
               (touch key))
             (set! output (append output (list "-1")))))
        (else
         (if (hash-table-exists? values key)
             (touch key)
             (when (= (hash-table-count values) capacity)
               (let ((first-key (car (hash-table-keys values))))
                 (hash-table-remove! values first-key))))
         (hash-table-set! values key (string->number (caddr parts)))))))
  (unless (null? output)
    (display (string-join output "\n"))
    (newline)))

(exit 0)
