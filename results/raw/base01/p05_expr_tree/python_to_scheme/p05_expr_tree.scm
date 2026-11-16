(import scheme (chicken base) (chicken io))

(define-record-type <node>
  (make-node token left right)
  node?
  (token node-token)
  (left node-left)
  (right node-right))

(define (build tokens)
  (define stack '())
  (for-each (lambda (token)
              (if (member token '(+ - *))
                  (let ((right (car stack))
                        (left (cadr stack)))
                    (set! stack (list (make-node token left right))))
                  (set! stack (cons (make-node token) stack))))
            tokens)
  (car stack))

(define (render node)
  (cond
   ((and (node-left node) (node-right node))
    (string-append "(" (render (node-left node)) " "
                   (node-token node) " " (render (node-right node)) ")"))
   (else
    (node-token node))))

(define (main)
  (let* ((tokens (string-split (read-line) #\space))
         (tree (build tokens)))
    (display (render tree))
    (newline)))

(main)
