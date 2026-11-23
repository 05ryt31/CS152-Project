 
(import (scheme base))
(import (scheme read))
(import (scheme write))
(import (srfi 1)) ; lists
(import (srfi 132)) ; vectors
 
;; Breadth-first search implementation
(define (bfs graph start goal)
  (let loop ((queue (list start))
             (visited '()))
    (cond ((null? queue) #f)
          ((member (car queue) visited)
           (loop (cdr queue) visited))
          ((eq? (car queue) goal)
           (car queue))
          (else
           (let* ((node (car queue))
                  (edges (vector-ref graph (- node 1)))
                  (new-queue (append edges (cdr queue))))
             (loop new-queue (cons node visited)))))))
 
;; Test case
(let* ((graph (make-vector 6))
       (nodes '(1 2 3 4 5 6)))
  ;; Build graph
  (for-each (lambda (n)
              (vector-set! graph (- n 1) (list)))
            nodes)
  ;; Add edges
  (vector-set! graph 0 (list 2 3))
  (vector-set! graph 1 (list 3 4))
  (vector-set! graph 2 (list 5))
  (vector-set! graph 3 (list 4 5))
  (vector-set! graph 4 (list 6))
  (vector-set! graph 5 (list 6))
  ;; Search
  (display "BFS:")
  (for-each (lambda (start end)
              (display " ")
              (display (if (bfs graph start end)
                           "connected"
                           "disconnected")))
            '((1 2) (1 4) (3 5) (4 6)))
  (newline))
 
