 
(define (make-tree op left right)
  (list op left right))
 
(define (op tree)
  (car tree))
 
(define (left tree)
  (cadr tree))
 
(define (right tree)
  (caddr tree))
 
(define (leaf? tree)
  (not (pair? tree)))
 
(define (tree->string tree)
  (if (leaf? tree)
      (number->string (op tree))
      (let ((op (op tree))
	    (left (tree->string (left tree)))
	    (right (tree->string (right tree))))
	(string-append "(" left " " op " " right ")"))))
 
(define (build-tree tokens)
  (cond ((null? tokens)
         '())
        ((or (eq? (car tokens) '+)
             (eq? (car tokens) '-)
             (eq? (car tokens) '*))
         (make-tree (car tokens)
                    (build-tree (build-list (/ (- (length tokens) 1) 2)
                                            (lambda (i)
                                              (list-ref tokens (+ (* i 2) 1)))))
                    (build-tree (build-list (/ (- (length tokens) 1) 2)
                                            (lambda (i)
                                              (list-ref tokens (+ (* i 2) 2)))))))
        (else
         (list (car tokens)))))
 
(define (print-tree tree)
  (display (tree->string tree))
  (newline))
 
(print-tree (build-tree '(+ * 4 7 8 9)))
 
