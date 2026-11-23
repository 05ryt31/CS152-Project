 
(import (scheme base))
(import (scheme read))
(import (scheme write))
(import (srfi 1)) ; lists
(import (srfi 69)) ; hash tables
 
;; A simple LRU cache implementation using a hash table and a list.
;;
;; The hash table maps keys to values. The list is ordered such that
;; the head of the list contains the most recently accessed item.
;;
;; When an item is accessed, it is moved to the front of the list.
;; When an item is added, it is also placed at the front of the list.
;; If the cache exceeds its capacity, the last item in the list is removed
;; from both the list and the hash table.
;;
;; This implementation assumes that all keys are unique.
(define lru-cache?
  (lambda (cache)
    (and (hash-table? (lru-cache-table cache))
         (list? (lru-cache-list cache)))))
 
(define make-lru-cache
  (lambda (capacity)
    (make-hash-table 'equal?)
    (list capacity)))
 
(define lru-cache-capacity
  (lambda (cache)
    (car (cdr cache))))
 
(define lru-cache-table
  (lambda (cache)
    (car cache)))
 
(define lru-cache-list
  (lambda (cache)
    (cdr cache)))
 
(define lru-cache-add!
  (lambda (cache key value)
    (let ((table (lru-cache-table cache))
          (lst (lru-cache-list cache))
          (cap (lru-cache-capacity cache)))
      (if (hash-table-exists? table key)
          ;; Key already exists, move to front of list.
          (begin
            (hash-table-remove! table key)
            (set-car! lst (+ cap 1)))
          ;; Key does not exist, check capacity.
          (when (= cap (length lst))
            (let* ((key-to-delete (last lst))
                   (value-to-delete (hash-table-ref table key-to-delete)))
              (hash-table-remove! table key-to-delete)
              (set-cdr! lst (reverse (butlast (reverse lst)))))))
      ;; Add new key/value pair to front of list and hash table.
      (hash-table-push! table key value)
      (cons key lst))))
 
(define lru-cache-get
  (lambda (cache key)
    (let ((table (lru-cache-table cache))
          (lst (lru-cache-list cache)))
      (if (hash-table-exists? table key)
          ;; Move key/value pair to front of list.
          (let* ((value (hash-table-ref table key))
                 (new-lst (remove key lst)))
            (hash-table-remove! table key)
            (set-car! lst (+ (car lst) 1))
            (hash-table-push! table key value)
            (cons key new-lst))
          ;; Key does not exist.
          (cons #f lst)))))
 
(define lru-cache-print
  (lambda (cache)
    (let loop ((lst (lru-cache-list cache)))
      (unless (null? lst)
        (display (car lst))
        (display ": ")
        (display (hash-table-ref (lru-cache-table cache) (car lst)))
        (newline)
        (loop (cdr lst))))))
 
;; Test cases.
(let ((cache (make-lru-cache 3)))
  (lru-cache-add! cache 1 10)
  (lru-cache-add! cache 2 20)
  (lru-cache-add! cache 3 30)
  (lru-cache-add! cache 4 40)
  (lru-cache-print cache))
 
(let ((cache (make-lru-cache 3)))
  (lru-cache-add! cache 1 10)
  (lru-cache-add! cache 2 20)
  (lru-cache-add! cache 3 30)
  (lru-cache-add! cache 1 100)
  (lru-cache-print cache))
 
(let ((cache (make-lru-cache 3)))
  (lru-cache-add! cache 1 10)
  (lru-cache-add! cache 2 20)
  (lru-cache-add! cache 3 30)
  (lru-cache-add! cache 4 40)
  (lru-cache-add! cache 1 100)
  (lru-cache-print cache))
 
(let ((cache (make-lru-cache 3)))
  (lru-cache-add! cache 1 10)
  (lru-cache-add! cache 2 20)
  (lru-cache-add! cache 3 30)
  (lru-cache-add! cache 4 40)
  (lru-cache-add! cache 5 50)
  (lru-cache-add! cache 6 60)
  (lru-cache-add! cache 7 70)
  (lru-cache-print cache))
 
(let ((cache (make-lru-cache 3)))
  (lru-cache-add! cache 1 10)
  (lru-cache-add! cache 2 20)
  (lru-cache-add! cache 3 30)
  (lru-cache-add! cache 4 40)
  (lru-cache-add! cache 5 50)
  (lru-cache-add! cache 6 60)
  (lru-cache-add! cache 7 70)
  (lru-cache-add! cache 8 80)
  (lru-cache-add! cache 9 90)
  (lru-cache-add! cache 10 100)
  (lru-cache-print cache))
 
