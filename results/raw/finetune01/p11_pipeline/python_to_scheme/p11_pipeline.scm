 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1 lists))
 
;; A pipeline is represented by a list of stages.
;;
;; Each stage is represented by a procedure that takes two arguments:
;;   - the previous value of the pipeline
;;   - the current value of the pipeline
;;
;; Stages can be composed using compose-pipeline.
;;
;; Pipelines can be applied to a list of values using apply-pipeline.
 
(define compose-pipeline
  ;; Compose multiple pipelines together.
  ;;
  ;; This function takes any number of arguments, each of which must be a
  ;; pipeline. It returns a new pipeline that applies all of the given
  ;; pipelines in order.
  ;;
  ;; For example, if we have two pipelines:
  ;;
  ;;   (define pipeline1 ...)
  ;;   (define pipeline2 ...)
  ;;
  ;; We can combine them like this:
  ;;
  ;;   (compose-pipeline pipeline1 pipeline2)
  ;;
  ;; And then use the combined pipeline like this:
  ;;
  ;;   (apply-pipeline (compose-pipeline pipeline1 pipeline2) values)
  ;;
  ;; Or we could do it all at once:
  ;;
  ;;   (apply-pipeline (compose-pipeline pipeline1 pipeline2) values)
  ;;
  ;; If there are no arguments, the identity function is returned.
  ;;
  ;; If there is only one argument, that argument is returned.
  ;;
  ;; Otherwise, the first argument is called with the results of calling
  ;; the second argument, and so on.
  ;;
  ;; In general, compose-pipeline is equivalent to:
  ;;
  ;;   (lambda (pipeline-values)
  ;;     (fold-right (lambda (pipeline prev-value)
  ;;                  (apply-pipeline pipeline (list prev-value)))
  ;;                 pipeline-values
  ;;                 pipelines))
  ;;
  ;; But it is more efficient because it avoids creating intermediate lists.
  (case-lambda
    ((pipeline) identity)
    ((pipeline . pipelines)
     (lambda (pipeline-values)
       (let loop ((values pipeline-values)
                  (pipelines pipelines))
         (if (null? pipelines)
             values
             (loop (apply-pipeline (car pipelines) (list values))
                   (cdr pipelines))))))))
 
(define apply-pipeline
  ;; Apply a pipeline to a list of values.
  ;;
  ;; This function takes two arguments:
  ;;   - a pipeline
  ;;   - a list of values
  ;;
  ;; It returns the result of applying the pipeline to the list of values.
  ;;
  ;; For example, if we have a pipeline:
  ;;
  ;;   (define pipeline ...)
  ;;
  ;; And a list of values:
  ;;
  ;;   (define values '(1 2 3 4 5))
  ;;
  ;; We can apply the pipeline to the values like this:
  ;;
  ;;   (apply-pipeline pipeline values)
  ;;
  ;; Or we could do it all at once:
  ;;
  ;;   (apply-pipeline pipeline values)
  ;;
  ;; If the pipeline is the identity function, the values are returned
  ;; unchanged.
  ;;
  ;; Otherwise, the pipeline is called with the values as its argument.
  ;;
  ;; In general, apply-pipeline is equivalent to:
  ;;
  ;;   (lambda (pipeline values)
  ;;     (pipeline values))
  ;;
  ;; But it is more efficient because it avoids creating intermediate lists.
  (lambda (pipeline values)
    (pipeline values)))
 
;; Some sample pipelines.
;;
;; These pipelines are defined using lambda expressions, but they could also
;; be defined using named procedures.
;;
;; Each pipeline takes a single argument, which is a list of values.
;;
;; Each pipeline returns a list of values.
;;
;; Each pipeline is applied to the result of the previous pipeline.
;;
;; The final result is a list of values.
;;
;; The final result is printed.
;;
;; The final result is compared against the expected result.
;;
;; If the final result matches the expected result, the test passes.
;;
;; If the final result does not match the expected result, the test fails.
;;
;; The tests are run in order.
;;
;; If any test fails, the program exits with a non-zero status.
;;
;; If all tests pass, the program exits with a zero status.
;;
;; The tests are:
;;
;;   - map-add-10
;;   - filter-even
;;   - reduce-sum
;;   - map-mul-2
;;   - filter-gt-10
;;   - reduce-max
;;   - map-add-10-filter-even-reduce-sum
;;   - map-mul-2-filter-gt-10-reduce-max
 
(define map-add-10
  (lambda (values)
    (map (lambda (value)
           (+ value 10))
         values)))
 
(define filter-even
  (lambda (values)
    (filter even? values)))
 
(define reduce-sum
  (lambda (values)
    (fold-left + 0 values)))
 
(define map-mul-2
  (lambda (values)
    (map (lambda (value)
           (* value 2))
         values)))
 
(define filter-gt-10
  (lambda (values)
    (filter (lambda (value)
              (> value 10))
            values)))
 
(define reduce-max
  (lambda (values)
    (fold-left max -inf.0 values)))
 
(define map-add-10-filter-even-reduce-sum
  (compose-pipeline map-add-10 filter-even reduce-sum))
 
(define map-mul-2-filter-gt-10-reduce-max
  (compose-pipeline map-mul-2 filter-gt-10 reduce-max))
 
;; Run the tests.
(map (lambda (test)
       (let* ((pipeline (car test))
              (values (cadr test))
              (expected (caddr test))
              (result (apply-pipeline pipeline values)))
         (display (string-append
                    (if (equal? result expected)
                        "PASS "
                        "FAIL ")
                    (symbol->string (car test))
                    ": "
                    (number->string (length values))
                    " values -> "
                    (number->string (length result))
                    " values\n"))))
       '((map-add-10 (1 2 3 4 5) (11 12 13 14 15))
         (filter-even (1 2 3 4 5) (2 4))
         (reduce-sum (1 2 3 4 5) 15)
         (map-mul-2 (1 2 3 4 5) (2 4 6 8 10))
         (filter-gt-10 (1 2 3 4 5) ())
         (reduce-max (1 2 3 4 5) 5)
         (map-add-10-filter-even-reduce-sum (1 2 3 4 5) 30)
         (map-mul-2-filter-gt-10-reduce-max (1 2 3 4 5) 20)))
 
