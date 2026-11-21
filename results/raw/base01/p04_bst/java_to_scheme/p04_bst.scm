(import scheme (chicken base) (chicken io))

(define-record-type node
  (make-node value left right)
  node?
  (value node-value)
  (left node-left set-node-left!)
  (right node-right set-node-right!))

(define (insert root value)
  (if (null? root)
      (make-node value #f #f)
      (let loop ((current root))
        (cond ((< value (node-value current))
               (if (null? (node-left current))
                   (begin
                     (set-node-left! current (make-node value #f #f))
                     root)
                   (loop (node-left current))))
              ((> value (node-value current))
               (if (null? (node-right current))
                   (begin
                     (set-node-right! current (make-node value #f #f))
                     root)
                   (loop (node-right current))))))))

(define (inorder node out)
  (when node
    (inorder (node-left node) out)
    (when (> (string-length out) 0) (display " " out))
    (display (number->string (node-value node)) out)
    (inorder (node-right node) out)))

(define (preorder node out)
  (when node
    (when (> (string-length out) 0) (display " " out))
    (display (number->string (node-value node)) out)
    (preorder (node-left node) out)
    (preorder (node-right node) out)))

(define (height node)
  (if (null? node)
      0
      (+ 1 (max (height (node-left node)) (height (node-right node))))))

(define (main)
  (define line (read-line))
  (define root #f)
  (for-each (lambda (token)
              (when (not (string=? token ""))
                (set! root (insert root (string->number token)))))
            (string-split line #px"[\\s]+"))

  (define in (open-output-string))
  (define pre (open-output-string))
  (inorder root in)
  (preorder root pre)

  (display (get-output-string in))
  (newline)
  (display (get-output-string pre))
  (newline)
  (display (number->string (height root)))
  (newline))

(main)
