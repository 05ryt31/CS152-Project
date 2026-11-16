(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((line (read-line))
         (ns (nums line))
         (tree (foldl insert empty ns))
         (in (inorder tree))
         (pre (preorder tree)))
    (print_nums in)
    (print_nums pre)
    (writeln (height tree))))

(define (nums line)
  (cond
    [(eof-object? line) '()]
    [(string=? line "") '()]
    [else (split-string line #\space)]))

(define (insert x tree)
  (cond
    [(empty-tree? tree) (node x empty-tree empty-tree)]
    [(< x (node-value tree)) (node (node-value tree) (insert x (node-left tree)) (node-right tree))]
    [else (node (node-value tree) (node-left tree) (insert x (node-right tree)))]))

(define (inorder tree)
  (inorder-acc tree '()))

(define (inorder-acc tree acc)
  (if (empty-tree? tree)
      acc
      (inorder-acc (node-right tree) (cons (node-value tree) (inorder-acc (node-left tree) acc)))))

(define (preorder tree)
  (preorder-acc tree '()))

(define (preorder-acc tree acc)
  (if (empty-tree? tree)
      acc
      (cons (node-value tree) (append (preorder-acc (node-right tree) acc) (preorder-acc (node-left tree) acc)))))

(define (height tree)
  (if (empty-tree? tree)
      0
      (+ 1 (max (height (node-left tree)) (height (node-right tree))))))

(define (print_nums nums)
  (if (null? nums)
      (newline)
      (begin
        (display (number->string (car nums)))
        (display " ")
        (print_nums (cdr nums)))))

(define-record-type node
  (make-node value left right)
  node?
  (value node-value)
  (left node-left)
  (right node-right))

(define empty-tree? null?)

(define (max a b)
  (if (> a b) a b))

(main)
