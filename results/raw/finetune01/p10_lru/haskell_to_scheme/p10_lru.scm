 
(import (scheme base))
(import (scheme cxr))
(import (scheme write))
(import (srfi 1)) ; lists
(import (srfi 69)) ; hash tables
 
;; A simple LRU cache implementation using a hash table and a list.
;;
;; The hash table maps keys to cons cells whose car is the value and
;; whose cdr is the position of the key in the list.
;;
;; The list contains the keys in order of use, with the most recently
;; used at the head of the list.
;;
;; When a key is accessed, it is moved to the front of the list.
;;
;; When a key is set, it is added to the front of the list. If the key
;; was already present, it is moved to the front of the list. If the
;; cache is full, the least recently used key is removed from both the
;; hash table and the list.
;;
;; This implementation assumes that all keys are unique.
;;
;; Example usage:
;;
;;   (define cache (make-lru-cache 2))
;;
;;   (lru-cache-set! cache 'a 1)
;;   (lru-cache-set! cache 'b 2)
;;   (lru-cache-get cache 'a) ; => 1
;;   (lru-cache-get cache 'c) ; => #f
;;   (lru-cache-set! cache 'd 4)
;;   (lru-cache-get cache 'b) ; => #f
;;
(define-record-type <lru-cache>
  (%make-lru-cache capacity table list)
  lru-cache?
  (capacity lru-cache-capacity)
  (table lru-cache-table)
  (list lru-cache-list))
 
(define make-lru-cache
  (lambda (capacity)
    (%make-lru-cache capacity (make-hash-table) '())))
 
(define lru-cache-set!
  (lambda (cache key value)
    (let* ((table (lru-cache-table cache))
           (list (lru-cache-list cache))
           (entry (hash-table-ref/default table key #f)))
      (cond
       ((not entry)
        ;; Key not found, so add it to the front of the list.
        (hash-table-push! table key (cons value list))
        (set-car! entry value)
        (set-cdr! entry (cons key list)))
       (else
        ;; Key found, so move it to the front of the list.
        (set-car! entry value)
        (set-cdr! entry (cons key (remove key list))))))))
 
(define lru-cache-get
  (lambda (cache key)
    (let* ((table (lru-cache-table cache))
           (list (lru-cache-list cache))
           (entry (hash-table-ref/default table key #f)))
      (if entry
          (begin
            (set-cdr! entry (cons key (remove key list)))
            (car entry))
          #f))))
 
(define lru-cache-size
  (lambda (cache)
    (hash-table-count (lru-cache-table cache))))
 
(define lru-cache-empty?
  (lambda (cache)
    (= 0 (lru-cache-size cache))))
 
(define lru-cache-full?
  (lambda (cache)
    (= (lru-cache-size cache) (lru-cache-capacity cache))))
 
(define lru-cache-clear!
  (lambda (cache)
    (hash-table-clear! (lru-cache-table cache))
    (set-cdr! cache '())))
 
(define lru-cache->list
  (lambda (cache)
    (reverse (lru-cache-list cache))))
 
(define lru-cache-print
  (lambda (cache)
    (display "Cache size: ")
    (display (lru-cache-size cache))
    (newline)
    (display "Cache contents: ")
    (display (lru-cache->list cache))
    (newline)))
 
;; Test cases.
(let ((cache (make-lru-cache 2)))
  (lru-cache-set! cache 'a 1)
  (lru-cache-set! cache 'b 2)
  (display (lru-cache-get cache 'a)) (newline) ; => 1
  (display (lru-cache-get cache 'c)) (newline) ; => #f
  (lru-cache-set! cache 'd 4)
  (display (lru-cache-get cache 'b)) (newline) ; => #f
  (lru-cache-print cache))
 
