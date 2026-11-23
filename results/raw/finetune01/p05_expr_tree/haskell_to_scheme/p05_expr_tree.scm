 
(define (make-tree op left right)
  (list op left right))
 
(define (tree-op tree)
  (car tree))
 
(define (tree-left tree)
  (cadr tree))
 
(define (tree-right tree)
  (caddr tree))
 
(define (tree-leaf? tree)
  (string? tree))
 
(define (tree-eval tree)
  (if (tree-leaf? tree)
      (string->number tree)
      (* (tree-eval (tree-left tree))
         (tree-eval (tree-right tree)))))
 
(define (tree-print tree)
  (cond ((tree-leaf? tree)
         (display tree))
        (else
         (display "(")
         (tree-print (tree-left tree))
         (display " ")
         (display (tree-op tree))
         (display " ")
         (tree-print (tree-right tree))
         (display ")"))))
 
(define (parse-tree str)
  (let loop ((chars (string->list str))
             (stack '()))
    (cond ((null? chars)
           (car stack))
          ((char=? #\* (car chars))
           (loop (cdr chars)
                 (cons (make-tree (string #\*) (car stack) (cadr stack))
                       (cddr stack))))
          ((char=? #\+ (car chars))
           (loop (cdr chars)
                 (cons (make-tree (string #\+) (car stack) (cadr stack))
                       (cddr stack))))
          (else
           (loop (cdr chars)
                 (cons (string (car chars))
                       stack))))))
 
(parse-tree "12 * 4 + 7")
 
