(import scheme (chicken io) (chicken string))

(define (bank n)
    (let loop ((i 0) (balance 0))
        (unless (= i n)
            (let* ((parts (string-split (read-line)))
                (command (car parts)))
            (cond 
                ((string=? command "deposit")
                    (loop (+ i 1) (+ balance (string->number (cadr parts)))))
                ((string=? command "withdraw")
                    (let ((amount (string->number (cadr parts))))
                    (if (> amount balance)
                        (begin (print "error") (loop (+ i 1) balance))
                        (loop (+ i 1) (- balance amount)))))
                (else (print balance) (loop (+ i 1) balance)))))))

(bank (string->number (read-line)))
