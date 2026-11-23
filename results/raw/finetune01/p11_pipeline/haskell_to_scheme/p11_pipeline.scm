 
(import (scheme base)
        (scheme write)
        (only (srfi 1) fold))
 
;; A pipeline is represented by a list of functions.
(define-record-type <pipeline>
  make-pipeline
  pipeline?
  (stages pipeline-stages))
 
;; Apply a pipeline to some arguments.
(define (run-pipeline pipeline args)
  (fold compose identity args (pipeline-stages pipeline)))
 
;; Create a pipeline from a list of strings describing the operations.
(define (make-pipeline-from-spec spec)
  (define (parse-op op)
    (cond ((string=? op "add") +)
          ((string=? op "mul") *)
          ((string=? op "even") even?)
          ((string=? op "odd") odd?)
          ((string=? op "gt") >)
          ((string=? op "sum") (lambda (x y) (+ x y)))
          ((string=? op "max") max)
          (else (error "Unknown operation" op))))
  (define (parse-args op)
    (if (eq? op 'gt)
        (list (string->number (car (reverse spec))))
        '()))
  (make-pipeline
   (map (lambda (op)
          (let* ((fn (parse-op op))
                 (args (parse-args op)))
            (lambda (lst)
              (case fn
                ((+ * even? odd? > max)
                 (filter fn lst))
                ((sum)
                 (apply fn lst)))))
          (reverse (cdr (reverse (assoc op '(("map" . ("add" "mul"))
                                              ("filter" . ("even" "odd" "gt")))))))))
     spec)))
 
;; Parse a string of numbers into a list of integers.
(define (parse-numbers str)
  (map (lambda (s) (string->number s))
       (string-split str #\space)))
 
;; Print out the results of running a pipeline on a list of numbers.
(define (print-results pipeline nums)
  (for-each (lambda (n) (display n) (display " ")) (run-pipeline pipeline nums))
  (newline))
 
;; Test cases.
(print-results (make-pipeline-from-spec '("map" "add" "2")) (parse-numbers "1 2 3"))
(print-results (make-pipeline-from-spec '("map" "mul" "4")) (parse-numbers "1 2 3"))
(print-results (make-pipeline-from-spec '("filter" "even")) (parse-numbers "1 2 3"))
(print-results (make-pipeline-from-spec '("filter" "gt" "1")) (parse-numbers "1 2 3"))
(print-results (make-pipeline-from-spec '("reduce" "sum")) (parse-numbers "1 2 3"))
(print-results (make-pipeline-from-spec '("reduce" "max")) (parse-numbers "1 2 3"))
 
