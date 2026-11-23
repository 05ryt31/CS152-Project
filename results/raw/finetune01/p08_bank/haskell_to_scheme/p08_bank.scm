 
(import (scheme base)
        (scheme read)
        (scheme write)
        (srfi 1 ; list functions
          (only (srfi 132) fold)))
 
;; parse command string into a procedure
(define (parse-command str)
  (let ((words (string-tokenize str)))
    (cond ((equal? "deposit" (car words))
           (lambda (balance)
             (+ balance (string->number (cadr words)))))
          ((equal? "withdraw" (car words))
           (lambda (balance)
             (if (< balance (string->number (cadr words)))
                 'error
                 (- balance (string->number (cadr words))))))
          ((equal? "balance" (car words))
           (lambda (balance)
             balance)))))
 
;; process a list of commands
(define (process-commands cmds)
  (fold (lambda (cmd balance)
          (let ((new-balance (cmd balance)))
            (if (eq? new-balance 'error)
                'error
                new-balance)))
        0
        cmds))
 
;; read a list of commands from standard input
(define (read-commands)
  (do ((line (read-line) (read-line))
       (cmds '() (cons (parse-command line) cmds)))
      ((eof-object? line) (reverse cmds))))
 
;; main function
(define (bank)
  (let ((cmds (read-commands)))
    (if (eq? 'error (process-commands cmds))
        (display "Error\n")
        (display (process-commands cmds)))))
 
