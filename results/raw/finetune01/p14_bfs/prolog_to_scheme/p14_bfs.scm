 
(import (scheme base)
        (scheme cxr)
        (scheme write)
        (srfi 1))
 
;; Breadth-first search implementation
(define (bfs graph start goal)
  (let loop ((queue '((. . ,start)))
             (visited '()))
    (if (null? queue)
      #f
      (let* ((node-edges (assoc (caar queue) graph))
             (node (caar queue))
             (edges (cdar queue)))
        (if (= node goal)
          edges
          (loop (append (filter (lambda (v) (not (member v visited)))
                                (map car node-edges))
                        (cdr queue))
                (cons node visited)))))))
 
;; Example usage
(let* ((graph '((1 (2 3))
                 (2 (1 3 4))
                 (3 (1 2 4))
                 (4 (2 3))))
       (result (bfs graph 1 4)))
  (if result
    (display "Path found: ")
    (display "No path found"))
  (display result)
  (newline))
 
