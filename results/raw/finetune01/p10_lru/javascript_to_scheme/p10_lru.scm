 
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
      (let loop ((bucket (vector-ref (hash-table-data table) index)))
        (cond ((not bucket) default)
              ((eq? (caar bucket) key) (cdar bucket))
              (else (loop (cdr bucket))))))))
 
(define hash-table-set!
  (lambda (table key value)
    (let ((index (modulo (car key) (hash-table-size table))))
      (let loop ((bucket (vector-ref (hash-table-data table) index)))
        (cond ((not bucket)
               (vector-set! (hash-table-data table) index
                            (list (cons key value))))
              ((eq? (caar bucket) key)
               (set-cdr! (car bucket) value))
              (else (loop (cdr bucket))))))))
 
(define hash-table-delete!
  (lambda (table key)
    (let ((index (modulo (car key) (hash-table-size table))))
      (let loop ((prev #f) (bucket (vector-ref (hash-table-data table) index)))
        (cond ((not bucket))
              ((eq? (caar bucket) key)
               (if prev
                   (set-cdr! prev (cdr bucket))
                   (vector-set! (hash-table-data table) index (cdr bucket))))
              (else (loop bucket (cdr bucket))))))))
 
;; LRU cache implementation.
(define lru-cache
  (lambda (capacity)
    (let* ((cache (make-hash-table capacity))
           (queue '()))
      (define get
        (lambda (key)
          (let ((value (hash-table-ref cache key -1)))
            (when (> value -1)
                  (set! queue (delete key queue))
                  (push! key queue))
            value)))
      (define set
        (lambda (key value)
          (unless (hash-table-ref cache key #f)
                  (when (= (length queue) capacity)
                        (hash-table-delete! cache (pop! queue))))
          (hash-table-set! cache key value)
          (push! key queue)))
      (lambda (command . args)
        (case command
          ((get) (apply get args))
          ((set) (apply set args)))))))
 
;; Test the cache.
(let ((cache (lru-cache 2)))
  (display "LRU Cache:\n")
  (display "  get 1: ") (display (cache 'get 1)) (newline)
  (display "  set 1 1: ") (cache 'set 1 1) (newline)
  (display "  get 1: ") (display (cache 'get 1)) (newline)
  (display "  get 2: ") (display (cache 'get 2)) (newline)
  (display "  set 2 2: ") (cache 'set 2 2) (newline)
  (display "  get 1: ") (display (cache 'get 1)) (newline)
  (display "  get 2: ") (display (cache 'get 2)) (newline)
  (display "  set 3 3: ") (cache 'set 3 3) (newline)
  (display "  get 1: ") (display (cache 'get 1)) (newline)
  (display "  get 2: ") (display (cache 'get 2)) (newline)
  (display "  get 3: ") (display (cache 'get 3)) (newline))
 
