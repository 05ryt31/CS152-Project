 
(define (parse-expr str)
  (let ((tokens (string-split str)))
    (if (> (length tokens) 1)
        (let* ((left (car tokens))
               (operator (cadr tokens))
               (right (list-ref tokens 2)))
          (make-node operator (parse-expr left) (parse-expr right)))
        (make-node 'val (parse-val (car tokens)))))
 
(define (parse-val str)
  (cond ((char? (string-ref str 0))
         (make-node 'var (string->symbol str)))
        (else
         (make-node 'num (string->number str)))))
 
(define (make-node type . args)
  (cons type args))
 
(define (node-type node)
  (car node))
 
(define (node-args node)
  (cdr node))
 
(define (tree->infix tree)
  (let ((type (node-type tree)))
    (cond ((eq? type 'val)
           (cond ((eq? (node-type (car (node-args tree))) 'var)
                  (symbol->string (node-args tree)))
                 (else
                  (number->string (node-args tree)))))
          (else
           (let* ((operator (node-args tree))
                  (left (tree->infix (car (node-args operator))))
                  (right (tree->infix (cadr (node-args operator)))))
             (string-append "(" left " " operator " " right ")"))))))
 
