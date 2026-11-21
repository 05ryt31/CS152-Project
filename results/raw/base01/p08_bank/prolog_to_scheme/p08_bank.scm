(import scheme (chicken base) (chicken io))

(define (p08_bank)
  (let loop ((nline (read-line)))
    (let* ((n (string->number nline))
           (balance (commands n 0)))
      (halt))))

(define (commands n balance)
  (if (> n 0)
      (let* ((line (read-line))
             (parts (string-split line #\space))
             (new-balance (command parts balance)))
        (commands (- n 1) new-balance))
      balance))

(define (command parts balance)
  (match parts
    (("deposit" amount)
     (let ((value (string->number amount)))
       (+ balance value)))
    (("withdraw" amount)
     (let ((value (string->number amount)))
       (cond ((> value balance)
              (display "error\n")
              balance)
             (else
              (- balance value)))))
    (("balance")
     (begin
       (display balance)
       (newline)
       balance))))
