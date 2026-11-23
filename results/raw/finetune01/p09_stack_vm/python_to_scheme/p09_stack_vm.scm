 
(import (scheme base))
(import (scheme read))
(import (scheme write))
(import (srfi 1)) ; list functions
 
(define (stack-machine instructions)
  (define (helper instructions stack)
    (if (null? instructions)
      (list (car stack))
      (let* ((op (caar instructions))
             (args (cdar instructions)))
        (cond ((eq? op 'push) (helper (cdr instructions) (cons args stack)))
              ((eq? op 'pop) (helper (cdr instructions) (cdr stack)))
              ((eq? op 'add) (helper (cdr instructions) (cons (+ (cadr stack) (car stack)) (cddr stack))))
              ((eq? op 'mul) (helper (cdr instructions) (cons (* (cadr stack) (car stack)) (cddr stack))))
              ((eq? op 'dup) (helper (cdr instructions) (cons (car stack) stack)))
              ((eq? op 'swap) (helper (cdr instructions) (cons (cadr stack) (cons (car stack) (cddr stack)))))
              ((eq? op 'print) (begin (display (car stack)) (newline) (helper (cdr instructions) (cdr stack))))))))
  (helper instructions '()))
 
(display (stack-machine '((push 1) (push 2) (add) (print)))) (newline)
(display (stack-machine '((push 1) (push 2) (mul) (print)))) (newline)
(display (stack-machine '((push 1) (push 2) (dup) (print)))) (newline)
(display (stack-machine '((push 1) (push 2) (swap) (print)))) (newline)
(display (stack-machine '((push 1) (push 2) (pop) (print)))) (newline)
(display (stack-machine '((push 1) (push 2) (pop) (pop) (print)))) (newline)
 
