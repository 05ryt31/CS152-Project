 
(import (scheme base)
        (scheme write)
        (srfi 1))
 
;; helper functions
(define (string->number s)
  (let ((n (string->number s)))
    (if n
      n
      (error "Invalid number" s))))
 
(define (parse-stage stage)
  (match-case stage
    ((("map" "add") n))
    (("map" "mul" n)))
    (("filter" "even"))
    (("filter" "odd"))
    (("filter" "gt" n))
    (("reduce" "sum")))
    (("reduce" "max"))))
 
(define (apply-map-add n lst)
  (map (+ n) lst))
 
(define (apply-map-mul n lst)
  (map (* n) lst))
 
(define (apply-filter-even lst)
  (filter even? lst))
 
(define (apply-filter-odd lst)
  (filter odd? lst))
 
(define (apply-filter-gt n lst)
  (filter (> n) lst))
 
(define (apply-reduce-sum lst)
  (fold-left + 0 lst))
 
(define (apply-reduce-max lst)
  (if (null? lst)
    #f
    (fold-left max (car lst) (cdr lst))))
 
;; pipeline function
(define (pipeline k-values k-stages)
  (define (helper values stages)
    (cond ((null? stages)
            values)
          ((equal? (caar stages) "map")
           (case (cadar stages)
             ((add) (helper (apply-map-add (cadr (car stages)) values)
                            (cdr stages)))
             ((mul) (helper (apply-map-mul (cadr (car stages)) values)
                            (cdr stages)))))
          ((equal? (caar stages) "filter")
           (case (cadar stages)
             ((even) (helper (apply-filter-even values)
                             (cdr stages)))
             ((odd) (helper (apply-filter-odd values)
                            (cdr stages)))
             ((gt) (helper (apply-filter-gt (cadr (car stages)) values)
                           (cdr stages)))))
          ((equal? (caar stages) "reduce")
           (case (cadar stages)
             ((sum) (helper (apply-reduce-sum values)
                            (cdr stages)))
             ((max) (helper (apply-reduce-max values)
                            (cdr stages)))))))
  (helper k-values k-stages))
 
;; test cases
(let* ((values '(1 2 3 4 5 6 7 8 9 10))
       (stages '((map add 2)
                 (filter gt 5)
                 (reduce sum))))
  (display (pipeline values stages))
  (newline))
 
(let* ((values '(1 2 3 4 5 6 7 8 9 10))
       (stages '((map mul 2)
                 (filter even)
                 (reduce max))))
  (display (pipeline values stages))
  (newline))
 
