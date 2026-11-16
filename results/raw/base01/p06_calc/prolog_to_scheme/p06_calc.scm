(import scheme (chicken base) (chicken io))

(define (p06_calc)
  (let ((line (read-line)))
    (let ((expression (read-term-from-string line)))
      (let ((value (eval expression)))
        (display value)
        (newline)
        (exit 0)))))

(p06_calc)
