(import scheme (chicken base) (chicken io))

(define (number-string s)
  (string->number s))

(define (split-string str delim)
  (string-split str #\Space))

(define (maplist proc lst)
  (if (null? lst)
      '()
      (cons (proc (car lst)) (maplist proc (cdr lst)))))

(define (apply-stage parts values)
  (let ((op (car parts))
        (arg (cadr parts)))
    (cond
      [(and (eq? op "map") (eq? arg "add"))
       (let ((n (number-string (caddr parts))))
         (maplist (lambda (x) (+ x n)) values))]
      [(and (eq? op "map") (eq? arg "mul"))
       (let ((n (number-string (caddr parts))))
         (maplist (lambda (x) (* x n)) values))]
      [(and (eq? op "filter") (eq? arg "even"))
       (include even values)]
      [(and (eq? op "filter") (eq? arg "odd"))
       (include odd values)]
      [(and (eq? op "filter") (eq? arg "gt"))
       (let ((n (number-string (caddr parts))))
         (include (lambda (x) (> x n)) values))]
      [(and (eq? op "reduce") (eq? arg "sum"))
       (list (apply + values))]
      [(and (eq? op "reduce") (eq? arg "max"))
       (if (null? values)
           'none
           (list (apply max values)))])))

(define (stages k values)
  (if (= k 0)
      values
      (let* ((line (read-line))
             (parts (split-string line))
             (new-values (apply-stage parts values))
             (k1 (- k 1)))
        (stages k1 new-values))))

(define (output result)
  (cond
    [(eq? result 'none)
     (display "none")
     (newline)]
    [(null? result)
     (void)]
    [else
     (atomic-list-concatenate result " ")
     (newline)]))

(define (main)
  (let* ((line (read-line))
         (parts (split-string line))
         (values (maplist number-string parts))
         (k-line (read-line))
         (k (number-string k-line))
         (result (stages k values)))
    (output result)
    (exit 0)))

(main)
