 
(import (scheme base)
        (scheme read)
        (scheme write))
 
;; A bank account is represented by a list of two elements:
;;   - the first element is the current balance
;;   - the second element is a list of transactions
;;
;; Transactions are represented by lists of two elements:
;;   - the first element is either 'deposit or 'withdraw
;;   - the second element is the amount of money involved in the transaction
;;
;; Example:
;;   '((100 ((deposit . 20) (withdraw . 40))))
;;
;; Note that we use cons cells instead of vectors because it makes it easier
;; to append new transactions at the end of the list.
(define-syntax make-account
  (syntax-rules ()
    ((_ balance ...)
     (list balance ...))))
 
;; Return the current balance of the given account.
(define-syntax get-balance
  (syntax-rules ()
    ((_ account)
     (car account))))
 
;; Append a new transaction to the given account.
(define-syntax record-transaction
  (syntax-rules ()
    ((_ account type amount)
     (set-car! account (+ (get-balance account) (* type amount)))
     (cons (cons type amount) (cdr account)))))
 
;; Process a command and return the updated account.
(define-syntax process-command
  (syntax-rules ()
    ((_ account "deposit" amount)
     (record-transaction account 1 amount))
    ((_ account "withdraw" amount)
     (if (< amount (get-balance account))
       (record-transaction account -1 amount)
       '(error)))))
 
;; Print the current balance of the given account.
(define-syntax print-balance
  (syntax-rules ()
    ((_ account)
     (display (get-balance account)))))
 
;; Process all commands from the given port and print the final balance.
(define-syntax process-input-port
  (syntax-rules ()
    ((_ port)
     (let loop ((line (read-line port)))
       (unless (eof-object? line)
         (let* ((command (string-split line #\space))
                (account (process-command (make-account 0) (cadr command) (string->number (caddr command)))))
           (if (eq? (car account) 'error)
             (display "Error")
             (print-balance account))
           (newline)
           (loop (read-line port)))))))
 
(process-input-port (current-input-port))
 
