 
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
 
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (tree-left tree))
                (tree-height (tree-right tree))))))
 
