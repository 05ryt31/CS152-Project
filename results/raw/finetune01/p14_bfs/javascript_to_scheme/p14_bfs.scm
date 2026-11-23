 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; Breadth-first search implementation
(define (bfs start goal? neighbors)
  (define (search frontier explored)
    (cond ((null? frontier) #f)
          ((goal? (car frontier))
           (list (car frontier) (append explored frontier)))
          (else
           (search (append (neighbors (car frontier))
                           (cdr frontier))
                   (cons (car frontier) explored)))))
  (search (list start) '()))
 
;; Example usage
(let* ((graph '((1 (2 3 4))
                 (2 (1 5 6))
                 (3 (1 7 8))
                 (4 (1 9 10))
                 (5 (2))
                 (6 (2))
                 (7 (3))
                 (8 (3))
                 (9 (4))
                 (10 (4))))
       (find-path (lambda (path goal)
                    (if (= (last path) goal)
                        path
                        #f))))
  ;; Find all paths from 1 to 6
  (let loop ((paths (list (list 1))))
    (if (null? paths)
        '()
        (let* ((path (car paths))
               (next-nodes (cadr (assoc (last path) graph)))
               (new-paths (filter find-path (map (lambda (x) (cons x path))
                                                next-nodes))))
          (if (null? new-paths)
              (loop (cdr paths))
              (append new-paths (loop (cdr paths))))))))
 
