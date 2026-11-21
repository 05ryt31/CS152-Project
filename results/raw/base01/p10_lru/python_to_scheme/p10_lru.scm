(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((capacity (string->number (read-line)))
         (n (string->number (read-line)))
         (values (make-hash-table))
         (order '()))
    (do ((i 0 (+ i 1))) ((= i n))
      (let* ((line (read-line))
             (parts (string-split line))
             (key (string->number (list-ref parts 1))))
        (cond
          ((string=? (list-ref parts 0) "get")
           (if (hash-table-exists? values key)
               (begin
                 (set! order (remove (lambda (x) (= x key)) order))
                 (set! order (append order (list key)))
                 (display (hash-table-ref values key))
                 (newline))
               (begin
                 (display -1)
                 (newline))))
          (else
           (when (hash-table-exists? values key)
             (set! order (remove (lambda (x) (= x key)) order)))
           (when (= (length order) capacity)
             (let ((oldest (car order)))
               (hash-table-delete! values oldest)
               (set! order (cdr order))))
           (hash-table-set! values key (string->number (list-ref parts 2)))
           (set! order (append order (list key))))))))

(main)
