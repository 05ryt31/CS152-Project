(import scheme (chicken base) (chicken io))

(define (touch key order)
  (filter (/= key) order) ++ (list key))

(define (apply state command)
  (match state
    [(values order)
     (let* ([words (string-split command)]
            [cmd (car words)]
            [key (and (eq? cmd "get") (cadr words))]
            [val (and (eq? cmd "put") (caddr words))]
            [new-values values]
            [new-order order])
       (cond
         [(and cmd (eq? cmd "get"))
          (if (hash-table-exists? values key)
              (values values (touch (string->number key) order))
              (values values order))]
         [(and cmd (eq? cmd "put"))
          (set! new-values (hash-update values (string->number key) (lambda (_) (string->number val)) (lambda () (string->number val))))
          (set! new-order (touch (string->number key) order))
          (if (> (length new-order) cap)
              (set! new-values (hash-delete new-values (car new-order)))
              '()))
          (values new-values new-order)]
         [else state]))]))

(define (run-lru cap commands)
  (let loop ([commands commands] [values (make-hash-table)] [order '()] [output '()])
    (if (null? commands)
        (reverse output)
        (let* ([command (car commands)]
               [result (apply (cons values order) command)])
          (loop (cdr commands) (car result) (cdr result) (if (pair? (cdr result)) (cons (cdr result) output) output))))))

(define (main)
  (let* ([cap (read-line)]
         [n (read-line)]
         [commands (build-list (string->number n) read-line)])
    (for-each display (run-lru (string->number cap) commands))
    (newline)))

(main)
