 
(import (scheme base)
        (scheme cxr)
        (scheme write)
        (srfi 1))
 
;; helper functions
(define (string->list s)
  (let loop ((chars (string->list s)))
    (if (null? chars)
      '()
      (cons (char->integer (car chars)) (loop (cdr chars))))))
 
(define (list->string l)
  (list->string (map integer->char l)))
 
;; main function
(define (group-by n)
  (define *groups* (make-vector (+ n 1) '()))
  (do ((i 0 (+ i 1)))
    ((>= i n))
    (let* ((line (read-line))
           (key-value (string-split line #\Space))
           (key (string->list (car key-value)))
           (value (string->list (cadr key-value))))
      (vector-set! *groups* (length key)
                   (append (vector-ref *groups* (length key))
                           (list (cons key value))))))
  ;; print results
  (for-each
   (lambda (group)
     (display (list->string (caar group))) (display ": ")
     (display (length (cdar group))) (display " groups of size ")
     (display (length (cadar group))) (newline))
   (vector-sort < *groups*)))
 
(group-by 4)
 
