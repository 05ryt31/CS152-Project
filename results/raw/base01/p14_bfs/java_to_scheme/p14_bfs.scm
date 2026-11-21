(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((input (read-line))
         (first (string-split input #\space))
         (n (string->number (list-ref first 0)))
         (m (string->number (list-ref first 1)))
         (neighbours (make-vector (+ n 1))))
    
    ;; Initialize neighbors list
    (do ((i 0 (+ i 1))) ((> i n))
      (vector-set! neighbours i '()))
    
    ;; Read edges and build adjacency list
    (do ((i 0 (+ i 1))) ((= i m))
      (let* ((edge (string-split (read-line) #\space))
             (u (string->number (list-ref edge 0)))
             (v (string->number (list-ref edge 1))))
        (push v (vector-ref neighbours u))
        (push u (vector-ref neighbours v))))
    
    ;; Read start and target
    (let* ((last (string-split (read-line) #\space))
           (start (string->number (list-ref last 0)))
           (target (string->number (list-ref last 1)))
           (distance (make-vector (+ n 1) -1)))
      
      ;; BFS initialization
      (define queue (make-queue))
      (enqueue! queue start)
      (vector-set! distance start 0)
      
      ;; BFS loop
      (while (not (queue-empty? queue))
        (let ((node (dequeue! queue)))
          (if (= node target)
              (begin
                (display (vector-ref distance target))
                (newline)
                (return)))
          (for-each (lambda (other)
                      (when (= (vector-ref distance other) -1)
                        (vector-set! distance other (+ (vector-ref distance node) 1))
                        (enqueue! queue other)))
                    (vector-ref neighbours node)))))
    
    (exit 0)))

(main)
