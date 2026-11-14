(import scheme (chicken io) (chicken string))

(define (build tokens)
    (let loop ((tokens tokens) (stack '()))
        (if (null? tokens)
            (car stack)
            (let ((token (car tokens)))
                (if (member token '("+" "-" "*"))
                    (let ((right (car stack)) (left (cadr stack)))
                        (loop (cdr tokens) (cons (list token left right) (cddr stack))))
                    (loop (cdr tokens) (cons token stack)))))))

(define (render tree)
    (if (string? tree)
        tree
        (string-append "(" (render (cadr tree)) " " (car tree) " " (render (caddr tree)) ")")))

(print (render (build (string-split (read-line)))))
