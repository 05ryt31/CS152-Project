 
(define (make-tree key left right)
  (list key left right))
 
(define (tree-key tree)
  (car tree))
 
(define (tree-left tree)
  (cadr tree))
 
(define (tree-right tree)
  (caddr tree))
 
(define (empty-tree? tree)
  (null? tree))
 
(define (tree-insert tree key)
  (cond ((empty-tree? tree)
         (make-tree key '() '()))
        ((< key (tree-key tree))
         (make-tree (tree-key tree)
                    (tree-insert (tree-left tree) key)
                    (tree-right tree)))
        (else
         (make-tree (tree-key tree)
                    (tree-left tree)
                    (tree-insert (tree-right tree) key)))))
 
(define (tree-in-order tree)
  (if (not (empty-tree? tree))
      (append (tree-in-order (tree-left tree))
              (list (tree-key tree))
              (tree-in-order (tree-right tree)))
      '()))
 
(define (tree-pre-order tree)
  (if (not (empty-tree? tree))
      (append (list (tree-key tree))
              (tree-pre-order (tree-left tree))
              (tree-pre-order (tree-right tree)))
      '()))
 
(define (tree-post-order tree)
  (if (not (empty-tree? tree))
      (append (tree-post-order (tree-left tree))
              (tree-post-order (tree-right tree))
              (list (tree-key tree)))
      '()))
 
(define (tree-height tree)
  (if (empty-tree? tree)
      0
      (+ 1 (max (tree-height (tree-left tree))
                (tree-height (tree-right tree))))))
 
(define (tree-to-list tree)
  (list (tree-key tree)
        (tree-height tree)
        (tree-in-order tree)
        (tree-pre-order tree)
        (tree-post-order tree)))
 
(define *bst*
  (tree-insert (tree-insert (tree-insert (tree-insert '()
                                                         27)
                                         14)
                           35)
                19))
 
(display (tree-to-list *bst*))(newline)
 
