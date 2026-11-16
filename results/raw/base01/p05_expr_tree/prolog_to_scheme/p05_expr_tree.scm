(import scheme (chicken base) (chicken io))

(define (main)
  (let* ((line (read-line))
         (tokens (string-split line #\space))
         (tree (build tokens '()))
         (text (render tree)))
    (display text)
    (newline)
    (exit 0)))

(define (build tokens stack)
  (if (null? tokens)
      stack
      (let ((token (car tokens)))
        (cond
          ((member token '("+", "-", "*"))
           (build (cdr tokens) (cons (list token (car stack) (cadr stack)) (cddr stack))))
          (else
           (build (cdr tokens) (cons token stack)))))))

(define (render tree)
  (cond
    ((atom tree) tree)
    (else
     (let* ((op (car tree))
            (left (render (cadr tree)))
            (right (render (caddr tree)))
            (lstr (if (atom left) (symbol->string left) left))
            (rstr (if (atom right) (symbol->string right) right))
            (result (string-append "(" lstr " " op " " rstr ")")))
       result))))

(main)
