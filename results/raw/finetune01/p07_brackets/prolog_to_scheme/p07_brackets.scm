 
(import (scheme base))
(import (scheme write))
(import (srfi 1))          ;; for fold
(import (srfi 132))        ;; for string-fold
 
;; Return #t if the given string has balanced brackets.
(define (bracket-balanced? str)
  (let loop ((chars (string->list str))
             (stack '()))
    (cond ((null? chars)
           (null? stack))
          ((char=? (car chars) #\()
           (loop (cdr chars) (cons #\) stack)))
          ((char=? (car chars) #\[)
           (loop (cdr chars) (cons #\] stack)))
          ((char=? (car chars) #\{)
           (loop (cdr chars) (cons #\} stack)))
          ((or (eq? (car chars) #\))
               (eq? (car chars) #\])
               (eq? (car chars) #\}))
           (if (null? stack)
               #f
               (loop (cdr chars) (cdr stack))))
          (else
           (loop (cdr chars) stack)))))
 
;; Test cases.
(let ((test-cases '((#() . #t)
                    ("()" . #t)
                    ("([]{})" . #t)
                    ("((()))" . #t)
                    ("({[()]})" . #t)
                    ("((())" . #f)
                    ("({[" . #f)
                    (")(" . #f)
                    ("([)]" . #f)
                    ("([{])" . #f))))
  (for-each
   (lambda (case)
     (display (car case))
     (display " ")
     (display (if (bracket-balanced? (car case)) "yes" "no"))
     (newline))
   test-cases))
 
