 
(import (scheme base))
(import (scheme cxr))
(import (scheme write))
(import (srfi 1))          ; lists
(import (srfi 132))        ; hash tables
 
;; A simple LRU cache implementation using a hash table and a list.
;;
;; The hash table maps keys to values. The list contains pairs of key-value
;; entries in order of recency. Oldest entry at head, newest at tail.
;;
;; When a new value is added, it is placed at the end of the list. If the
;; cache is full, the oldest entry is removed from both the list and the hash
;; table.
;;
;; get-key returns #f if the key does not exist.
;;
;; put-key! updates the value associated with key k, or adds a new key/value
;; pair if key k does not exist.
;;
;; remove-key! removes the key/value pair associated with key k.
;;
;; clear-cache! clears all key/value pairs from the cache.
;;
;; cache-size returns the current size of the cache.
;;
(define lru-cache?
  (lambda (cache)
    (and (list? (lru-cache-list cache))
         (hash-table? (lru-cache-hash-table cache)))))
 
(define make-lru-cache
  (lambda (max-size)
    (make-vector 2 (vector max-size))))
 
(define lru-cache-max-size
  (lambda (cache)
    (vector-ref (lru-cache cache) 0)))
 
(define lru-cache-list
  (lambda (cache)
    (vector-ref (lru-cache cache) 1)))
 
(define lru-cache-hash-table
  (lambda (cache)
    (vector-ref (lru-cache cache) 2)))
 
(define get-key
  (lambda (cache k)
    (let ((ht (lru-cache-hash-table cache)))
      (if (hash-table-exists? ht k)
          (let* ((v (hash-table-get ht k))
                 (lst (lru-cache-list cache)))
            (set-car! lst (cons (cons k v) (car lst)))
            v)
          #f))))
 
(define put-key!
  (lambda (cache k v)
    (let* ((ht (lru-cache-hash-table cache))
           (lst (lru-cache-list cache))
           (max-size (lru-cache-max-size cache)))
      (cond ((hash-table-exists? ht k)
             ;; Update existing key.
             (hash-table-remove! ht k)
             (set-cdr! (assoc k lst) v))
            ((>= (length lst) max-size)
             ;; Cache is full, remove least recently used item.
             (let* ((k-v-pair (car lst))
                    (key (car k-v-pair))
                    (value (cdr k-v-pair)))
               (hash-table-remove! ht key)
               (set-car! lst (cdr lst))))
            (else
             ;; Add new key.
             (hash-table-push! ht k v)))
      ;; Place key at end of list.
      (set-cdr! (assoc k lst) v)
      (set-car! lst (cons (cons k v) (car lst))))))
 
(define remove-key!
  (lambda (cache k)
    (let* ((ht (lru-cache-hash-table cache))
           (lst (lru-cache-list cache)))
      (when (hash-table-exists? ht k)
        (hash-table-remove! ht k)
        (set-car! lst (filter (lambda (x) (not (eq? (car x) k))) (car lst)))))))
 
(define clear-cache!
  (lambda (cache)
    (let* ((ht (lru-cache-hash-table cache))
           (lst (lru-cache-list cache)))
      (hash-table-clear! ht)
      (set-car! lst '()))))
 
(define cache-size
  (lambda (cache)
    (let ((ht (lru-cache-hash-table cache)))
      (hash-table-count ht))))
 
;; Tests
(let ((cache (make-lru-cache 4)))
  (put-key! cache 'a 1)
  (put-key! cache 'b 2)
  (put-key! cache 'c 3)
  (put-key! cache 'd 4)
  (put-key! cache 'e 5)
  (display (get-key cache 'a)) (newline)
  (display (get-key cache 'b)) (newline)
  (display (get-key cache 'c)) (newline)
  (display (get-key cache 'd)) (newline)
  (display (get-key cache 'e')) (newline)
  (display (get-key cache 'f')) (newline)
  (put-key! cache 'f' 6)
  (display (get-key cache 'a')) (newline)
  (display (get-key cache 'b')) (newline)
  (display (get-key cache 'c')) (newline)
  (display (get-key cache 'd')) (newline)
  (display (get-key cache 'e')) (newline)
  (display (get-key cache 'f')) (newline))
 
