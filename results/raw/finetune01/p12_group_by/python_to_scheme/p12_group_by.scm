 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; A simple hash table implementation using vectors.
(define-record-type <hash-table>
  (%make-hash-table size data)
  hash-table?
  (size hash-table-size)
  (data hash-table-data))
 
(define make-hash-table
  (lambda (size)
    (%make-hash-table size (make-vector size #f))))
 
(define hash-table-ref
  (lambda (table key default)
    (let ((index (modulo (car key) (hash-table-size table))))
      (if (eq? (vector-ref (hash-table-data table) index) #f)
          default
          (cdr key)))))
 
(define hash-table-set!
  (lambda (table key value)
    (let ((index (modulo (car key) (hash-table-size table))))
      (vector-set! (hash-table-data table) index (cons key value)))))
 
(define group-by
  (lambda (proc lst)
    ;; Create a hash table where each key is the result of applying proc to
    ;; an element of lst and each value is a list of elements that produced
    ;; that key.
    ;;
    ;; We use a vector instead of a hash table because we want to avoid
    ;; collisions when computing the hash of the keys.
    (let* ((ht (make-hash-table (length lst)))
           (add-to-group
             (lambda (x)
               (let ((key (proc x)))
                 (hash-table-set! ht key (append (hash-table-ref ht key '()) (list x)))))))
      (for-each add-to-group lst)
      ht)))
 
(define display-groups
  (lambda (groups)
    (define display-key-value-pair
      (lambda (pair)
        (display (car pair))
        (display ": ")
        (display (cdr pair))
        (newline)))
    (for-each display-key-value-pair (vector->list groups))))
 
(define main
  (lambda ()
    (let* ((n (read))
           (lst (do ((i 0 (+ i 1))
                     (result '()))
                    ((= i n) result)
                  (set! result (cons (read) result)))))
      (display-groups (group-by car lst)))))
 
(main)
 
