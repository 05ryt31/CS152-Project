(define *n* 8)
 
;; returns #t if queen at (x,y) is under attack by any queen in list-of-queens
(define (under-attack? x y list-of-queens)
  (define (helper q)
    (cond ((null? q) #f)
          ((or (= x (caar q))
               (= y (cadar q))
               (= (abs (- x (caar q))) (abs (- y (cadar q)))))
           #t)
          (else (helper (cdr q)))))
  (helper list-of-queens))
 
;; returns #t if placing a queen at (x,y) is legal given list-of-queens
(define (legal-queen? x y list-of-queens)
  (not (under-attack? x y list-of-queens)))
 
;; returns list of all legal placements of queens given list-of-queens
(define (find-legal-places x list-of-queens)
  (filter (lambda (y) (legal-queen? x y list-of-queens)) (iota *n*)))
 
;; returns list of all possible board configurations given list-of-queens
(define (find-configurations list-of-queens)
  (if (= (length list-of-queens) *n*)
      (list list-of-queens)
      (apply append (map (lambda (x) (map (lambda (y) (cons (cons x y) list-of-queens))
                                          (find-legal-places x list-of-queens)))
                         (iota *n*)))))
 
;; prints out board configuration
(define (print-board config)
  (do ((i 0 (+ i 1)))
      ((= i *n*) (newline))
      (do ((j 0 (+ j 1)))
          ((= j *n*))
          (if (member (cons i j) config)
              (display "* ")
              (display ". ")))))
 
;; prints out all board configurations
(define (print-all-configs configs)
  (if (null? configs)
      (display "No solutions")
      (begin (print-board (car configs))
             (print-all-configs (cdr configs)))))
 
(print-all-configs (find-configurations '()))
