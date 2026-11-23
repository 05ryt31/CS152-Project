 
(define (make-tree key)
  (list key '() '()))
 
(define (tree-key tree)
  (car tree))
 
(define (tree-left tree)
  (cadr tree))
 
(define (tree-right tree)
  (caddr tree))
 
(define (set-tree-key! tree key)
  (set-car! tree key))
 
(define (set-tree-left! tree subtree)
  (set-car! (cdr tree) subtree))
 
(define (set-tree-right! tree subtree)
  (set-cdr! (cdr tree) subtree))
 
(define (tree-insert tree key)
  (cond ((null? tree)
         (make-tree key))
        ((= key (tree-key tree))
         tree)
        ((< key (tree-key tree))
         (let ((left (tree-left tree)))
           (if (null? left)
               (begin
                 (set-tree-left! tree (make-tree key))
                 tree)
               (tree-insert left key))))
        (else
         (let ((right (tree-right tree)))
           (if (null? right)
               (begin
                 (set-tree-right! tree (make-tree key))
                 tree)
               (tree-insert right key))))))
 
(define (tree-in-order tree)
  (if (null? tree)
      '()
      (append (tree-in-order (tree-left tree))
              (list (tree-key tree))
              (tree-in-order (tree-right tree)))))
 
(define (tree-pre-order tree)
  (if (null? tree)
      '()
      (append (list (tree-key tree))
              (tree-pre-order (tree-left tree))
              (tree-pre-order (tree-right tree)))))
 
(define (tree-post-order tree)
  (if (null? tree)
      '()
      (append (tree-post-order (tree-left tree))
              (tree-post-order (tree-right tree))
              (list (tree-key tree)))))
 
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (tree-left tree))
                (tree-height (tree-right tree))))))
 
(define (tree-print tree)
  (display "In order:")
  (display (tree-in-order tree))
  (newline)
  (display "Pre order:")
  (display (tree-pre-order tree))
  (newline)
  (display "Post order:")
  (display (tree-post-order tree))
  (newline)
  (display "Height:")
  (display (tree-height tree))
  (newline))
 
