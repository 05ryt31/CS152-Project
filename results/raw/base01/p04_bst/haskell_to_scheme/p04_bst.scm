(import scheme (chicken base) (chicken io))

(define-record-type tree
  (make-tree value left right)
  tree?
  (value tree-value)
  (left tree-left)
  (right tree-right))

(define (insert t v)
  (cond ((tree? t)
         (let* ((y (tree-value t))
                (l (tree-left t))
                (r (tree-right t)))
           (if (< v y)
               (make-tree y (insert l v) r)
               (make-tree y l (insert r v)))))
        (else
         (make-tree v '() '()))))

(define (inorder t)
  (if (tree? t)
      (append (inorder (tree-left t))
              (list (tree-value t))
              (inorder (tree-right t)))
      '()))

(define (preorder t)
  (if (tree? t)
      (append (list (tree-value t))
              (preorder (tree-left t))
              (preorder (tree-right t)))
      '()))

(define (height t)
  (if (tree? t)
      (+ 1 (max (height (tree-left t)) (height (tree-right t))))
      0))

(define (show-line xs)
  (string-join (map number->string xs) " "))

(define (safe-get-line)
  (if (eof-object? (peek-char))
      ""
      (read-line)))

(define main
  (let* ((values (map string->number (string-split (safe-get-line) #\space)))
         (tree (foldl insert '() values)))
    (display (show-line (inorder tree)))
    (newline)
    (display (show-line (preorder tree)))
    (newline)
    (display (number->string (height tree)))
    (newline)))

(main)
