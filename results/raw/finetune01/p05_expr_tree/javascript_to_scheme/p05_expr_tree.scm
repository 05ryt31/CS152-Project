 
(import (scheme base)
        (scheme read)
        (scheme write))
 
;; A binary tree is either empty or a cons pair where the car is the value
;; and the cdr is a cons pair whose car is the left subtree and whose cdr
;; is the right subtree.
;;
;; For example, the expression "1 + 2 * 3" is represented by the tree:
;;
;;   (+ 1 (* 2 3))
;;
;; which can be printed in this format:
;;
;;   ((+ 1 ((* 2 3))))
;;
;; or in this format:
;;
;;   (+ 1 ((* 2 3)))
;;
;; or in this format:
;;
;;   (+ 1 (2 3))
;;
;; etc.
;;
;; We use the first format here because it makes it easier to print trees
;; without quoting them.
;;
;; Note that we don't need to define a datatype for the tree nodes because
;; they're just regular cons pairs.
 
(define (tree-print tree port)
  ;; Print a tree to PORT.
  ;;
  ;; If TREE is empty, do nothing.
  ;;
  ;; Otherwise, print the value of the root followed by the left subtree
  ;; and then the right subtree.
  (if (not (null? tree))
      (begin
        (display (car tree) port)
        (tree-print (cdr tree) port))))
 
(define (tree-eval tree)
  ;; Evaluate a tree.
  ;;
  ;; If TREE is empty, return 0.
  ;;
  ;; Otherwise, evaluate the left subtree, the right subtree, and then
  ;; apply the function at the root to the results of those evaluations.
  (if (null? tree)
      0
      (let ((left (tree-eval (car (cdr tree)))))
        (let ((right (tree-eval (car (cdr (cdr tree))))))
          (case (car tree)
            ((+) (+ left right))
            ((-) (- left right))
            ((*) (* left right))
            ((/) (/ left right)))))))
 
(define (tokenize string)
  ;; Convert STRING into a list of tokens.
  ;;
  ;; Each token is either a number or a symbol.
  ;;
  ;; For example, the string "(+ 1 (* 2 3))" becomes the list
  ;; ((+ 1 ((* 2 3)))).
  (define (tokenize-helper string index)
    (cond ((>= index (string-length string))
           '())
          ((char-whitespace? (string-ref string index))
           (tokenize-helper string (+ index 1)))
          ((char-numeric? (string-ref string index))
           (let loop ((i index)
                      (token ""))
             (if (or (= i (string-length string))
                     (char-whitespace? (string-ref string i)))
                 (cons (string->number token)
                       (tokenize-helper string (+ i 1)))
                 (loop (+ i 1)
                       (string-append token (string (string-ref string i)))))))
          (else
           (let loop ((i index)
                      (token ""))
             (if (or (= i (string-length string))
                     (char-whitespace? (string-ref string i)))
                 (cons (string->symbol token)
                       (tokenize-helper string (+ i 1)))
                 (loop (+ i 1)
                       (string-append token (string (string-ref string i)))))))))
  (tokenize-helper string 0))
 
(define (parse-tokens tokens)
  ;; Parse TOKENS into a tree.
  ;;
  ;; Each token is either a number or a symbol.
  ;;
  ;; For example, the list ((+ 1 ((* 2 3))) becomes the tree
  ;; ((+ 1 ((* 2 3))))).
  (define (parse-tokens-helper tokens)
    (cond ((null? tokens)
           '())
          ((number? (car tokens))
           (list (car tokens)))
          (else
           (let ((op (car tokens))
                 (args (parse-tokens-helper (cdr tokens))))
             (if (and (pair? args)
                      (= (length args) 2))
                 (list op (car args) (cadr args))
                 (error "Invalid arguments to operator" op args))))))
  (parse-tokens-helper tokens))
 
(define (main)
  (do ((line (read-line) (read-line)))
      ((eof-object? line))
      (let* ((tokens (tokenize line))
             (tree (parse-tokens tokens)))
        (display "Tokens:")
        (display tokens)
        (newline)
        (display "Tree:")
        (tree-print tree (current-output-port))
        (newline)
        (display "Value:")
        (display (tree-eval tree))
        (newline))))
 
(main)
 
