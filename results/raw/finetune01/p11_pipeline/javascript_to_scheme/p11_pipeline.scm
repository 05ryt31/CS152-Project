 
(import (scheme base)
        (scheme read)
        (scheme write)
        (only (srfi 1) fold))
 
;; A pipeline is represented by a list of functions.
(define-record-type pipeline
  (make-pipeline fns)
  pipeline?
  (fns pipeline-fns))
 
;; Apply a function to each element in a list.
(define map*
  (lambda (fn lst)
    (fold (lambda (x y) (cons (fn x) y)) '() lst)))
 
;; Filter out elements that don't satisfy a predicate.
(define filter*
  (lambda (pred lst)
    (fold (lambda (x y) (if (pred x) (cons x y) y)) '() lst)))
 
;; Return the sum of all elements in a list.
(define sum*
  (lambda (lst)
    (fold (lambda (x y) (+ x y)) 0 lst)))
 
;; Return the maximum value in a list.
(define max*
  (lambda (lst)
    (fold (lambda (x y) (max x y)) -inf.0 lst)))
 
;; Create a pipeline from a list of functions.
(define make-pipeline
  (lambda (fns)
    (make-pipeline fns)))
 
;; Execute a pipeline on a list of arguments.
(define execute-pipeline
  (lambda (pipe args)
    ((pipeline-fns pipe) args)))
 
;; Parse a command string into a function.
(define parse-command
  (lambda (cmd)
    (cond ((string=? "map" cmd) map*)
          ((string=? "filter" cmd) filter*)
          ((string=? "sum" cmd) sum*)
          ((string=? "max" cmd) max*))))
 
;; Parse a pipeline description into a pipeline object.
(define parse-pipeline
  (lambda (desc)
    (make-pipeline
      (map parse-command desc))))
 
;; Parse a list of numbers into a list of integers.
(define parse-numbers
  (lambda (str)
    (map string->number (string-split str #\space))))
 
;; Parse a pipeline description and a list of numbers into a pipeline object.
(define parse-input
  (lambda (input)
    (let* ((parts (string-split input #\newline))
           (desc (car parts))
           (numbers (parse-numbers (cadr parts))))
      (values (parse-pipeline desc) numbers))))
 
;; Print the result of executing a pipeline on a list of numbers.
(define print-result
  (lambda (result)
    (if (null? result)
        (display "none")
        (display (string-join (map number->string result) " ")))))
 
;; Main procedure.
(define main
  (lambda (args)
    (call-with-current-continuation
      (lambda (return)
        (with-input-from-file
          (car args)
          (lambda ()
            (let-values (((pipe nums) (parse-input (read-line)))
              (print-result (execute-pipeline pipe nums)))))))))
 
