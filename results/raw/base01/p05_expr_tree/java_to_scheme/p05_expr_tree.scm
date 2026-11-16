(import scheme (chicken base) (chicken io))

(define-record-type <node>
  (make-node token left right)
  node?
  (token node-token)
  (left node-left)
  (right node-right))

(define (render node)
  (if (and (not (node-left node))
           (not (node-right node)))
      (node-token node)
      (string-append "(" (render (node-left node))
                     " " (node-token node)
                     " " (render (node-right node)) ")")))

(define (main)
  (let* ((tokens (string-split (read-line) #px"[\\s]+"))
         (stack '()))
    (for-each (lambda (token)
                 (cond ((member token '("+ "-" "*"))
                        (let* ((right (car stack))
                               (left (cadr stack))
                               (parent (make-node token left right)))
                          (set! stack (list parent))))
                       (else
                        (push! (make-node token #f #f) stack))))
               tokens)
    (displayln (render (car stack)))))
