 
(import (scheme base)
        (scheme read)
        (scheme write)
        (only (srfi 1) fold))
 
;; A pipeline is represented by a list of functions.
(define-record-type pipeline
  (make-pipeline fns)
  pipeline?
  (fns pipeline-fns))
 
;; Apply a pipeline to some arguments.
(define apply-pipeline
  (lambda (pipeline . args)
    (apply (fold compose identity (pipeline-fns pipeline)) args)))
 
;; Create a pipeline from a list of functions.
(define make-pipeline
  (lambda (fns)
    (make-pipeline fns)))
 
;; Compose two functions.
(define compose
  (lambda (g f)
    (lambda args
      (apply g (apply f args)))))
 
;; Return a function that adds a given number to its argument.
(define add
  (lambda (n)
    (+ n)))
 
;; Return a function that multiplies its argument by a given number.
(define multiply
  (lambda (n)
    (* n)))
 
;; Return a function that filters out even numbers.
(define filter-even
  (lambda (lst)
    (filter even? lst)))
 
;; Return a function that filters out odd numbers.
(define filter-odd
  (lambda (lst)
    (filter odd? lst)))
 
;; Return a function that filters out numbers greater than a given number.
(define filter-gt
  (lambda (n)
    (lambda (lst)
      (filter (> n) lst))))
 
;; Return a function that returns the sum of its arguments.
(define sum
  (lambda args
    (apply + args)))
 
;; Return a function that returns the maximum of its arguments.
(define max
  (lambda args
    (apply max args)))
 
;; Return a function that returns 'none' if there are no arguments,
;; otherwise return the first argument.
(define none-or-first
  (lambda args
    (if (null? args)
        'none
        (car args))))
 
;; Parse a command string into a function.
(define parse-command
  (lambda (command)
    (let ((tokens (string-split command #\Space)))
      (cond
       ((equal? (car tokens) "add")
        (add (string->number (caddr tokens))))
       ((equal? (car tokens) "multiply")
        (multiply (string->number (caddr tokens))))
       ((equal? (car tokens) "filter")
        (case (cadr tokens)
          ((even) filter-even)
          ((odd) filter-odd)
          ((gt) (filter-gt (string->number (caddr tokens)))))))
       (else
        (case (car tokens)
          ((sum) sum)
          ((max) max)
          ((none) none-or-first)))))))
 
;; Parse a pipeline description into a pipeline object.
(define parse-pipeline
  (lambda (description)
    (make-pipeline (map parse-command (string-split description #\Newline))))))
 
;; Run a pipeline on a list of integers.
(define run-pipeline
  (lambda (pipeline integers)
    (apply-pipeline pipeline integers)))
 
;; Print the result of running a pipeline on a list of integers.
(define print-result
  (lambda (pipeline integers)
    (display (run-pipeline pipeline integers))
    (newline)))
 
;; Test cases.
(print-result (parse-pipeline "add 4\nmultiply 6\nfilter even") '(1 2 3 4 5 6 7 8 9 10))
(print-result (parse-pipeline "add 4\nmultiply 6\nfilter gt 10") '(1 2 3 4 5 6 7 8 9 10))
(print-result (parse-pipeline "add 4\nmultiply 6\nfilter odd") '(1 2 3 4 5 6 7 8 9 10))
(print-result (parse-pipeline "add 4\nmultiply 6\nsum") '(1 2 3 4 5 6 7 8 9 10))
(print-result (parse-pipeline "add 4\nmultiply 6\nmax") '(1 2 3 4 5 6 7 8 9 10))
(print-result (parse-pipeline "add 4\nmultiply 6\nnone") '(1 2 3 4 5 6 7 8 9 10))
 
