 
(import (scheme base)
        (scheme read)
        (scheme write))
 
;; Stack VM interpreter
(define (run-stack-vm instructions)
  ;; Create a stack and a list of results
  (let ((stack '())
        (results '()))
    ;; Process each instruction in order
    (for-each
      (lambda (instruction)
        ;; Pushes just push onto the stack
        (if (eq? (car instruction) 'push)
          (set! stack (cons (cadr instruction) stack))
          ;; All other operations pop the top two elements off the stack,
          ;; perform the operation, then push the result back on the stack
          (let* ((a (car stack))
                 (b (cadr stack)))
            (set! stack (list (car instruction) a b))
            (case (car instruction)
              ((add) (set-car! stack (+ a b)))
              ((mul) (set-car! stack (* a b)))
              ((dup) (set-car! stack a))
              ((swap) (set-car! stack b)))
            ;; If there is a print operation, append the result to the list
            (when (eq? (car instruction) 'print)
              (set! results (cons (car stack) results)))))
      instructions)
    ;; Return the final state of the stack and the list of results
    (values stack results)))
 
;; Test cases
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(add)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(mul)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(dup)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(swap)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(pop)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
(let-values (((final-state results)
              (run-stack-vm '((push 1)(push 2)(pop)(pop)(print)))))
  (display "Final state: ") (display final-state) (newline)
  (display "Results: ") (display results) (newline))
 
