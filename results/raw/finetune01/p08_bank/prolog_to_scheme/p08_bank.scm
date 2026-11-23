 
(define bank-account '(balance . 0))
 
(define (bank-deposit amount)
  (set-cdr! bank-account (+ (cdr bank-account) amount)))
 
(define (bank-withdraw amount)
  (if (< amount (cdr bank-account))
      (set-cdr! bank-account (- (cdr bank-account) amount))
      'error))
 
(define (bank-balance)
  (cdr bank-account))
 
