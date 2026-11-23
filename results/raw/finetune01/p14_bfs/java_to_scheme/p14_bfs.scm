 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1))
 
;; Breadth-first search implementation
(define (bfs graph start goal)
  (let loop ((frontier (list start))
             (explored '()))
    (cond ((null? frontier) #f)
          ((member goal frontier) (length (list-ec (: x frontier) x)))
          (else
           (loop (append (filter (lambda (x) (not (member x explored))) (graph (car frontier)))
                         (cdr frontier))
                 (cons (car frontier) explored))))))
 
;; Graph representation is a list of pairs where each pair represents a vertex and its neighbors
;; Example graph: ((1 (2 3)) (2 (1 4)) (3 (1 4)) (4 (2 3)))
(define *graph* '((1 (2 3)) (2 (1 4)) (3 (1 4)) (4 (2 3))))
 
(display (bfs *graph* 1 4))(newline)
 
