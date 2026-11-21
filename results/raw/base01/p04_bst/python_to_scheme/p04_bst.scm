(import scheme (chicken base) (chicken io))

(define-record-type node
  (make-node value left right)
  node?
  (value node-value)
  (left node-left set-node-left!)
  (right node-right set-node-right!))

(define (insert root value)
  (let ((node (make-node value #f #f)))
    (if (null? root)
        node
        (let loop ((current root))
          (cond ((< value (node-value current))
                 (if (null? (node-left current))
                     (set-node-left! current node)
                     (loop (node-left current))))
                (else
                 (if (null? (node-right current))
                     (set-node-right! current node)
                     (loop (node-right current)))))))))

(define (inorder node out)
  (when node
    (inorder (node-left node) out)
    (set! out (cons (node-value node) out))
    (inorder (node-right node) out)))

(define (preorder node out)
  (when node
    (set! out (cons (node-value node) out))
    (preorder (node-left node) out)
    (preorder (node-right node) out)))

(define (height node)
  (if (null? node)
      0
      (+ 1 (max (height (node-left node)) (height (node-right node))))))

(define (main)
  (let* ((root #f)
         (tokens (string-split (read-line) " "))
         (values (map string->number tokens)))
    (for-each (lambda (v) (set! root (insert root v))) values)
    (let ((in-values '())
          (pre-values '()))
      (inorder root in-values)
      (preorder root pre-values)
      (display (string-join (reverse in-values) " "))
      (newline)
      (display (string-join (reverse pre-values) " "))
      (newline)
      (display (height root))
      (newline))))

(main)
