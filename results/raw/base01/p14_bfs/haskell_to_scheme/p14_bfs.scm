(import scheme (chicken base) (chicken io))

(define (read-numbers str)
  (map string->number (string-split str)))

(define (bfs graph start target)
  (define (helper queue seen)
    (if (null? queue)
        -1
        (let* ([node (caar queue)]
               [distance (cdar queue)]
               [neighbors (hash-table-ref/default graph node '())])
          (if (= node target)
              distance
              (let loop ([next-neighbors '()])
                  (cond
                    [(null? neighbors) (helper (cdr queue) seen)]
                    [(member (car neighbors) seen) (loop (cdr neighbors))]
                    [else
                     (helper (append queue (list (cons (car neighbors) (+ distance 1))))
                             (cons (car neighbors) seen))
                     (loop (cdr neighbors))])))))))
  (helper (list (cons start 0)) (list start)))

(define (main)
  (let* ([input (read-line)]
         [nm (read-numbers input)]
         [edges (build-list (cadr nm) (lambda (_) (read-numbers (read-line))))])
    (let* ([graph (make-hash-table)]
           [start (car (last edges))]
           [target (cadr (last edges))]
           [add-edge! (lambda (u v)
                        (hash-table-set! graph u (cons v (hash-table-ref/default graph u '())))
                        (hash-table-set! graph v (cons u (hash-table-ref/default graph v '()))))]
           [result (apply min (filter (lambda (edge) (or (= (car edge) start) (= (cadr edge) start)))
                                      (map (lambda (edge) (min (car edge) (cadr edge))) edges)))]
           [bfs-result (bfs graph start target)])
      (display bfs-result)
      (newline))))

(main)
