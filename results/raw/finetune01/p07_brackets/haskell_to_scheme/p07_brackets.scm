 
(import (scheme base))
(import (scheme read))
(import (scheme write))
(import (srfi 1)) ; lists
(import (srfi 132)) ; ports
 
;; Return true if the given string is balanced.
(define (balanced? s)
  (let loop ((chars (string->list s)) (stack '()))
    (cond ((null? chars)
           (null? stack))
          ((char=? #\( (car chars))
           (loop (cdr chars) (cons #\) stack)))
          ((char=? #\[ (car chars))
           (loop (cdr chars) (cons #\] stack)))
          ((char=? #\{ (car chars))
           (loop (cdr chars) (cons #\} stack)))
          ((or (null? stack)
               (not (char=? (car chars) (car stack))))
           #f)
          (else
           (loop (cdr chars) (cdr stack)))))))
 
;; Print whether each of the given strings is balanced.
(define (test-balanced strs)
  (for-each (lambda (str)
              (display str)
              (if (balanced? str)
                  (display " is balanced\n")
                  (display " is unbalanced\n")))
            strs))
 
(test-balanced '("([]){}" "(){}[]"))
(test-balanced '("(}{)" "({)}" "([]{})" "([]{)")
                )
 
