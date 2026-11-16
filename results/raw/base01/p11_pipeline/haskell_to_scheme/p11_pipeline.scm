(import scheme (chicken base) (chicken io))

(define (apply xs stage)
  (let* ((tokens (string-split stage))
         (op (car tokens))
         (arg (cadr tokens))
         (n (string->number arg)))
    (cond
      ((and (= (length tokens) 3) (string=? op "map") (string=? arg "add")) (map (lambda (x) (+ x n)) xs))
      ((and (= (length tokens) 3) (string=? op "map") (string=? arg "mul")) (map (lambda (x) (* x n)) xs))
      ((and (= (length tokens) 2) (string=? op "filter") (string=? arg "even")) (filter even? xs))
      ((and (= (length tokens) 2) (string=? op "filter") (string=? arg "odd")) (filter odd? xs))
      ((and (= (length tokens) 3) (string=? op "filter") (string=? arg "gt")) (filter (lambda (x) (> x n)) xs))
      ((and (= (length tokens) 2) (string=? op "reduce") (string=? arg "sum")) (list (apply + xs)))
      ((and (= (length tokens) 2) (string=? op "reduce") (string=? arg "max"))
       (if (null? xs) '() (list (apply max xs)))))))

(define (read-numbers s)
  (map string->number (string-split s)))

(define (main)
  (let* ((values (read-line))
         (k (string->number (read-line)))
         (stages (build-list k read-line))
         (result (foldl apply (read-numbers values) stages)))
    (cond
      ((and (null? result) (> k 0) (member "reduce" stages)) (displayln "none"))
      ((null? result) (void))
      (else (displayln (string-join (map number->string result) " "))))))

(main)
