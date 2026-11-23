 
(import (scheme base)
        (scheme read)
        (scheme write))
 
;; A simple stack implementation using cons cells.
(define (push item stack)
  (cons item stack))
 
(define (pop stack)
  (let ((pair (cons? stack)))
    (if pair
      (values (car pair) (cdr pair))
      (error "Stack is empty"))))
 
(define (empty-stack? stack)
  (not (cons? stack)))
 
;; Returns #t if the brackets in the string are balanced, otherwise #f.
(define (balanced-brackets str)
  (define open-bracket '(#\( #\[ #\{))
  (define close-bracket '(#\) #\] #\}))
  (define bracket-pairs '((#\) . #\()
                          (#\) . #\[)
                          (#\) . #\{)))
  (let loop ((chars (string->list str))
             (stack '()))
    (cond ((null? chars)
           (empty-stack? stack))
          ((member (car chars) open-bracket)
           (loop (cdr chars)
                 (push (car chars) stack)))
          ((member (car chars) close-bracket)
           (if (empty-stack? stack)
             #f
             (let-values (((top rest) (pop stack)))
               (if (assoc top bracket-pairs)
                 (if (eqv? (cdr (assoc top bracket-pairs)) (car chars))
                   (loop (cdr chars) rest)
                   #f)
                 (loop (cdr chars) rest)))))
          (else
            (loop (cdr chars) stack)))))
 
;; Tests
(display (balanced-brackets "()")) (newline)
(display (balanced-brackets "(())")) (newline)
(display (balanced-brackets "[()]")) (newline)
(display (balanced-brackets "{()}")) (newline)
(display (balanced-brackets "([]{})")) (newline)
(display (balanced-brackets "((()))")) (newline)
(display (balanced-brackets "(()")) (newline)
(display (balanced-brackets "())")) (newline)
(display (balanced-brackets "([)]")) (newline)
(display (balanced-brackets "({})")) (newline)
(display (balanced-brackets "({[}])")) (newline)
(display (balanced-brackets "({[()]}))")) (newline)
 
