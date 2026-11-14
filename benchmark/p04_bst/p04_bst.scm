(import scheme (chicken io) (chicken string))

(define (insert tree value)
    (if (null? tree)
        (list value '() '())
        (let ((root (car tree)))
            (if (< value root)
                (list root (insert (cadr tree) value) (caddr tree))
                (list root (cadr tree) (insert (caddr tree) value))))))

(define (inorder tree)
    (if (null? tree) 
        '()
        (append (inorder (cadr tree))
                (list (car tree))
                (inorder (caddr tree)))))

(define (preorder tree)
    (if (null? tree) 
        '()
        (cons (car tree) (append (preorder (cadr tree)) (preorder (caddr tree))))))

(define (height tree)
    (if (null? tree) 
        0
        (+ 1 (max (height (cadr tree)) (height (caddr tree))))))

(define (print-list values)
    (unless (null? values)
        (display (car values))
        (for-each (lambda (value) (display (string-append " " (number->string value))))
                  (cdr values)))
    (newline))

(define (numbers line)
    (if (string=? line "") 
        '() 
        (map string->number (string-split line))))

(define (safe-read-line)
    (let ((line (read-line)))
        (if (eof-object? line)
            ""
            line)))

(define (build-tree values)
    (let loop ((loop-values values) (tree '()))
        (if (null? loop-values)
            tree
            (loop (cdr loop-values) (insert tree (car loop-values))))))

(define tree (build-tree (numbers (safe-read-line))))
(print-list (inorder tree))
(print-list (preorder tree))
(print (height tree))
