(import scheme (chicken base) (chicken io))

(define (read-lines)
  (let loop ((lines '()))
    (let ((line (read-line)))
      (if (eof-object? line)
          (reverse lines)
          (loop (cons line lines))))))

(let* ([lines (read-lines)]
       [inputs (map string->number (string-split (car lines) #\space))]
       [n (car inputs)]
       [m (cadr inputs)]
       [graph (make-vector (+ n 1) '())]
       [add-edge (lambda (u v)
                   (vector-set! graph u (cons v (vector-ref graph u)))
                   (vector-set! graph v (cons u (vector-ref graph v))))])
  (do ([i 0 (+ i 1)])
      ((= i m))
    (let* ([edge (string-split (list-ref lines (+ i 1)) #\space)]
           [u (string->number (car edge))]
           [v (string->number (cadr edge))])
      (add-edge u v))))
  
  (let* ([targets (string-split (list-ref lines (+ m 1)) #\space)]
         [start (string->number (car targets))]
         [target (string->number (cadr targets))]
         [distance (make-vector (+ n 1) -1)]
         [queue (list start)])
    (vector-set! distance start 0)
    
    (define (bfs)
      (if (null? queue)
          '()
          (let* ([node (car queue)]
                 [rest (cdr queue)])
            (when (= node target)
              (return-from bfs node))
            (for-each (lambda (next)
                        (when (= (vector-ref distance next) -1)
                          (vector-set! distance next (+ (vector-ref distance node) 1))
                          (set! queue (append rest (list next)))))
                      (vector-ref graph node))
            (bfs))))
    
    (display (bfs))
    (newline)))
