(import scheme (chicken io) (chicken string))

(define (read-graph m)
    (let loop ((i 0) (graph '()))
        (if (= i m)
            graph
            (let* ((uv (map string->number (string-split (read-line))))
                (u (car uv))
                (v (cadr uv)))
            (loop (+ i 1) (cons (cons u v) (cons (cons v u) graph)))))))

(define (get-neighbors node graph)
    (let ((entry (assoc node graph)))
        (if entry
            (cdr entry)
            '())))

(define (expand-layer layer graph visited)
    (let outer ((nodes layer) (vis visited) (next '()))
        (if (null? nodes)
            (cons next vis)
            (let ((u (car nodes)))
                (let inner ((gs graph) (v vis) (acc next))
                    (if (null? gs)
                        (outer (cdr nodes) v acc)
                        (let* ((edge (car gs))
                            (a (car edge))
                            (b (cdr edge)))
                        (if (and (= a u) (not (member b v)))
                            (inner (cdr gs) (cons b v) (cons b acc))
                            (inner (cdr gs) v acc)))))))))

(define (bfs start target graph)
    (let loop ((layer (list start)) (visited (list start)) (dist 0))
        (cond 
            ((null? layer) -1)
            ((member target layer) dist)
            (else
                (let ((next-layer (expand-layer layer graph visited)))
                    (loop (car next-layer)
                        (cdr next-layer)
                        (+ dist 1)))))))

(define nm (map string->number (string-split (read-line))))
(define n (car nm))
(define m (cadr nm))
(define graph (read-graph m))
(define st (map string->number (string-split (read-line))))
(define s (car st))
(define t (cadr st))

(print (bfs s t graph))
