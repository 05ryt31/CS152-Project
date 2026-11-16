(import scheme (chicken base) (chicken io))

(define (render node)
  (if (and (not (assoc 'left node)) (not (assoc 'right node)))
      (car node)
      (string-append "(" (render (cdr (assoc 'left node))) " "
                     (car node) " "
                     (render (cdr (assoc 'right node)))))))

(let loop ((tokens (string-split (read-line) #px"[ \t]+"))
           (stack '()))
  (if (null? tokens)
      (display (render (car stack)))
      (let ((token (car tokens)))
        (if (member token '(+ - *))
            (loop (cdr tokens)
                  (cons (list 'token token
                              'left (car stack)
                              'right (cadr stack))
                        (cddr stack)))
            (loop (cdr tokens)
                  (cons (list 'token token) stack)))))))

(newline)
