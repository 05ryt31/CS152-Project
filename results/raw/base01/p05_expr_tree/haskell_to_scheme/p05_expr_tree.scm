(import scheme (chicken base) (chicken io))

(define-record-type tree
  (make-tree value left right)
  tree?
  (value tree-value)
  (left tree-left)
  (right tree-right))

(define (build-tree line)
  (car (foldl step '() (string-split line))))

(define (step stack token)
  (if (member token '("+" "-" "*"))
      (cons (make-tree token (cadr stack) (car stack)) (cddr stack))
      (cons (make-tree token #f #f) stack)))

(define (render tree)
  (cond ((tree? tree)
         (if (and (tree-left tree) (tree-right tree))
             (string-append "(" (render (tree-left tree)) " " (tree-value tree) " " (render (tree-right tree)) ")")
             (tree-value tree)))
        (else
         (error "Invalid tree"))))

(define (main)
  (let ((line (read-line)))
    (display (render (build-tree line)))
    (newline)))

(main)
