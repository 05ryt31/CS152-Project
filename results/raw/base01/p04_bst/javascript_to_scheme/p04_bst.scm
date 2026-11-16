(import scheme (chicken base) (chicken io))

(define-record-type node
  (make-node value left right)
  node?
  (value node-value)
  (left node-left)
  (right node-right))

(define (insert root value)
  (if (not root)
      (make-node value #f #f)
      (let loop ((current root))
        (cond ((< value (node-value current))
               (if (node-left current)
                   (loop (node-left current))
                   (begin
                     (set-node-left! current (make-node value #f #f))
                     root)))
              ((> value (node-value current))
               (if (node-right current)
                   (loop (node-right current))
                   (begin
                     (set-node-right! current (make-node value #f #f))
                     root)))
              (else current))))))

(define (inorder root out)
  (when root
    (inorder (node-left root) out)
    (push! out (node-value root))
    (inorder (node-right root) out)))

(define (preorder root out)
  (when root
    (push! out (node-value root))
    (preorder (node-left root) out)
    (preorder (node-right root) out)))

(define (height root)
  (if root
      (+ 1 (max (height (node-left root)) (height (node-right root))))
      0))

(let* ((line (read-line))
       (trimmed (string-trim line))
       (values (if (string=? trimmed "")
                    '()
                    (map string->number (string-split trimmed))))
       (root (foldl insert #f values))
       (in-order (list))
       (pre-order (list)))
  (inorder root in-order)
  (preorder root pre-order)
  (display (string-join (map number->string in-order) " "))
  (newline)
  (display (string-join (map number->string pre-order) " "))
  (newline)
  (display (number->string (height root)))
  (newline))
