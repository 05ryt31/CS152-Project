 
(define bank-account '(balance . 0))
 
(define (bank-deposit account amount)
  (set-cdr! account (+ (cdr account) amount)))
 
(define (bank-withdraw account amount)
  (if (< amount (cdr account))
      (begin (set-cdr! account (- (cdr account) amount)) #t)
      #f))
 
(define (bank-balance account)
  (cdr account))
 
