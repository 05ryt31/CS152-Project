 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; A simple LRU cache implementation using a vector of cons cells.
;;
;; Each cell is in the form of (key . value), where key is the item
;; being cached and value is the associated data.
;;
;; The vector is circularly linked so that the first element is always
;; the least recently used item.
;;
;; When an item is accessed, it is moved to the end of the list.
;;
;; When an item is added, it is also placed at the end of the list.
;; If the cache has reached its maximum capacity, then the first item
;; in the list is removed.
;;
;; This implementation assumes that keys are immutable.
(define lru-cache?
  (lambda (cache)
    (and (vector? cache)
         (integer? (vector-ref cache 0)))))
 
(define make-lru-cache
  (lambda (max-size)
    (let ((cache (make-vector (+ max-size 1))))
      (vector-set! cache 0 max-size)
      cache)))
 
(define lru-cache-max-size
  (lambda (cache)
    (vector-ref cache 0)))
 
(define lru-cache-count
  (lambda (cache)
    (- (vector-length cache) 1)))
 
(define lru-cache-get
  (lambda (cache key)
    (let loop ((index 1))
      (if (= index (lru-cache-count cache))
          #f
          (let ((cell (vector-ref cache index)))
            (cond ((eq? key (car cell)) (loop (+ index 1)))
                  ((eq? key (car (vector-ref cache 1))) ; most recently used
                   (begin (vector-copy! cache 1 cache)
                          (vector-set! cache 1 cell)
                          (cdr cell)))
                  (else #f)))))))
 
(define lru-cache-add!
  (lambda (cache key value)
    (let* ((count (lru-cache-count cache))
           (max-size (lru-cache-max-size cache))
           (new-cell (cons key value)))
      (when (> count max-size)
        (vector-copy! cache 1 cache))
      (vector-set! cache (+ count 1) new-cell)
      (vector-set! cache 1 new-cell))))
 
;; Tests
(let ((cache (make-lru-cache 4)))
  (display "Cache size: ") (display (lru-cache-max-size cache)) (newline)
  (display "Initial cache count: ") (display (lru-cache-count cache)) (newline)
  (display "Get 'a': ") (display (lru-cache-get cache 'a')) (newline)
  (lru-cache-add! cache 'a' 1)
  (display "After adding 'a': ") (display (lru-cache-count cache)) (newline)
  (display "Get 'a': ") (display (lru-cache-get cache 'a')) (newline)
  (lru-cache-add! cache 'b' 2)
  (lru-cache-add! cache 'c' 3)
  (lru-cache-add! cache 'd' 4)
  (display "After adding 'b', 'c', 'd': ") (display (lru-cache-count cache)) (newline)
  (display "Get 'a': ") (display (lru-cache-get cache 'a')) (newline)
  (display "Get 'b': ") (display (lru-cache-get cache 'b')) (newline)
  (display "Add 'e': ") (newline)
  (lru-cache-add! cache 'e' 5)
  (display "After adding 'e': ") (display (lru-cache-count cache)) (newline)
  (display "Get 'a': ") (display (lru-cache-get cache 'a')) (newline)
  (display "Get 'b': ") (display (lru-cache-get cache 'b')) (newline)
  (display "Get 'e': ") (display (lru-cache-get cache 'e')) (newline))
 
