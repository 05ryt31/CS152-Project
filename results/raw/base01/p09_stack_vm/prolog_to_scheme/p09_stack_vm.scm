(import scheme (chicken base) (chicken io))

(define (p09-stack-vm)
  (let loop ((n (string->number (read-line))))
    (if (> n 0)
        (begin
          (let* ((line (read-line))
                 (parts (string-split line #\space))
                 (stack (execute parts '())))
            (loop (- n 1)))
          (exit 0))
        (exit 1))))

(define (execute parts stack)
  (cond
    [(equal? (car parts) "push")
     (let ((value (string->number (cadr parts))))
       (cons value stack))]
    [(equal? (car parts) "pop")
     (if (null? stack)
         (begin
           (display "error\n")
           '())
         (cdr stack))]
    [(member (car parts) '("add" "mul"))
     (if (< (length stack) 2)
         (begin
           (display "error\n")
           stack)
         (let* ((b (car stack))
                (a (cadr stack))
                (result (if (equal? (car parts) "add") (+ a b) (* a b))))
           (cons result (cddr stack)))))]
    [(equal? (car parts) "dup")
     (if (null? stack)
         (begin
           (display "error\n")
           '())
         (cons (car stack) stack))]
    [(equal? (car parts) "swap")
     (if (< (length stack) 2)
         (begin
           (display "error\n")
           stack)
         (let ((a (car stack))
               (b (cadr stack)))
           (cons b (cons a (cddr stack)))))]
    [(equal? (car parts) "print")
     (if (null? stack)
         (begin
           (display "error\n")
           '())
         (begin
           (display (car stack))
           (newline)
           stack))]
    [else stack]))

(p09-stack-vm)
