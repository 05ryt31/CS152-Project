 
(define (make-tree key)
  (list key '() '()))
 
(define tree-key car)
(define tree-left cadr)
(define tree-right caddr)
 
(define (tree-insert tree key)
  (cond ((null? tree) (make-tree key))
        ((= key (tree-key tree)) tree)
        ((< key (tree-key tree))
         (make-tree (tree-key tree)
                    (tree-insert (tree-left tree) key)
                    (tree-right tree)))
        (else
          (make-tree (tree-key tree)
                     (tree-left tree)
                     (tree-insert (tree-right tree) key)))))
 
(define (tree-inorder tree)
  (if (not (null? tree))
      (append (tree-inorder (tree-left tree))
              (list (tree-key tree))
              (tree-inorder (tree-right tree)))
      '()))
 
(define (tree-preorder tree)
  (if (not (null? tree))
      (append (list (tree-key tree))
              (tree-preorder (tree-left tree))
              (tree-preorder (tree-right tree)))
      '()))
 
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (tree-left tree))
                (tree-height (tree-right tree))))))
 
