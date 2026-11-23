 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; Return a list of lists where each sublist is a pair of a key and a list of values.
(define (group-by proc lst)
  (fold-left
   ;; Fold function.
   (lambda (result item)
     (let ((key (proc item)))
       (if (assoc key result)
           (cons (cons key (cons item (cdr (assoc key result))))
                 (remove (lambda (x) (eq? (car x) key)) result))
           (cons (cons key (list item)) result))))
   ;; Initial value.
   '()
   ;; List to fold over.
   lst))
 
;; Print out the grouped data in the format specified by the problem.
(define (print-grouped-data grouped-data)
  (define (print-key-value-pair key-values)
    (display (car key-values))
    (display ": ")
    (display (length (cdr key-values)))
    (display " entries")
    (newline))
  (for-each print-key-value-pair grouped-data))
 
;; Main procedure.
(define (main args)
  (with-input-from-file
      (cadr args)
    (lambda ()
      (let* ((num-lines (read))
             (data (do ((index num-lines (- index 1))
                        (data-list '()))
                       ((zero? index) data-list)
                     (set! data-list (cons (read) data-list)))))
        (print-grouped-data (group-by car data))))))
 
(main (command-line))
 
