 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; Return a list of lists where each sublist is a group of lines
;; with the same first element.
(define (group-by-first lst)
  (let loop ((lst lst)
             (groups '()))
    (if (null? lst)
      groups
      (let* ((key (caar lst))
             (rest (cdr lst)))
        (loop rest
              (cons (list-ec (: x (filter (lambda (y) (= (car y) key)) rest))
                             x)
                    (cond ((any (lambda (g) (= (car g) key)) groups)
                           groups)
                          (else
                            (cons (list key 0 0) groups)))))))))
 
;; Print out the grouped data in the format specified.
(define (print-groups groups)
  (for-each (lambda (g)
              (display (car g))
              (display ": ")
              (display (cadr g))
              (display " ")
              (display (caddr g))
              (newline))
            groups))
 
;; Process the input file and print out the results.
(let* ((filename (command-line-arg 0))
       (file (open-input-file filename))
       (lines (read-lines file)))
  (close-input-port file)
  (print-groups (group-by-first lines)))
 
