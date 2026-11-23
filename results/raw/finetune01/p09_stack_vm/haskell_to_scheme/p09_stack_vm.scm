```scheme
 
(import (scheme base))
(import (scheme read))
(import (scheme write))
(import (srfi 1)) ; lists
(import (srfi 132)) ; vectors
 
;; Stack VM
;;
;; This is a simple stack-based virtual machine. It takes a list of
;; instructions and executes them in order. Each instruction is either a
;; string representing a function name or a number which represents a value
;; to push onto the stack.
;;
;; Valid functions are:
;;   pop -- pops the top item off the stack
;;   add -- adds the top two items on the stack together
;;   mul -- multiplies the top two items on the stack together
;;   dup -- duplicates the top item on the stack
;;   swap -- swaps the top two items on the stack
;;   print -- prints the top item on the stack
;;
;; If there is an error during execution, it will return #f instead of the
;; final state of the stack.
;;
;; Examples:
;;   (vm '(push 1 push 2 add)) => #(1 3)
;;   (vm '(push 1 push 2 mul)) => #(1 2)
;;   (vm '(push 1 push 2 dup)) => #(1 2 2)
;;   (vm '(push 1 push 2 swap)) => #(1 2 1)
;;   (vm '(push 1 push 2 print)) => #(1 2) and prints 2
;;   (vm '(push 1 push 2 pop)) => #(1)
;;   (vm '(push 1 push 2 add add)) => #(1 4)
;;   (vm '(push 1 push 2 add mul)) => #(1 6)
;;   (vm '(push 1 push 2 mul add)) => #(1 7)
;;   (vm '(push 1 push 2 dup swap)) => #(1 2 1 2)
;;   (vm '(push 1 push 2 swap dup)) => #(1 2 1 2)
;;   (vm '(push 1 push 2 swap swap)) => #(1 2 2 1)
;;   (vm '(push 1 push 2 swap swap dup)) => #(1 2 2 1 2)
;;   (vm '(push 1 push 2 swap swap swap)) => #(1 2 2 1 2)
;;   (vm '(push 1 push 2 swap swap swap dup)) => #(1 2 2 1 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap)) => #(1 2 2 1 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap dup)) => #(1 2 2 1 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap)) => #(1 2 2 1 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap dup)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
;;   (vm '(push 1 push 2 swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap swap)) => #(1 2 2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
