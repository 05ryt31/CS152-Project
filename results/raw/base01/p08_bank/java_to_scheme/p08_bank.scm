(import scheme (chicken base) (chicken io))

(define (main)
  (let loop ((n (string->number (read-line))))
    (if (> n 0)
        (begin
          (let* ((command (read-line))
                 (parts (string-split command #\space)))
            (cond
              ((string=? (car parts) "deposit")
               (set! balance (+ balance (string->number (cadr parts)))))
              ((string=? (car parts) "withdraw")
               (let ((amount (string->number (cadr parts))))
                 (if (> amount balance)
                     (display "error\n")
                     (set! balance (- balance amount)))))
              ((string=? (car parts) "balance")
               (display balance "\n")))
            (loop (- n 1))))
        (exit 0))))

(let ((balance 0))
  (main))
