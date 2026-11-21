(import scheme (chicken base) (chicken io))

(define (p07-brackets)
  (let ((nline (safe-read-line)))
    (let ((n (string->number nline)))
      (run n))))

(define (safe-read-line)
  (let loop ()
    (let ((line (read-line)))
      (if (eof-object? line)
          ""
          line))))

(define (run n)
  (if (> n 0)
      (begin
        (let ((line (safe-read-line)))
          (if (balanced line)
              (display "yes")
              (display "no"))
          (newline))
        (run (- n 1)))))

(define (balanced line)
  (let ((chars (string->list line)))
    (balanced-chars chars '())))

(define (balanced-chars chars stack)
  (cond
    ((null? chars) (null? stack))
    ((member (car chars) '(#\( #\[ #\{')) 
     (balanced-chars (cdr chars) (cons (car chars) stack)))
    (else
     (let ((open (car stack)))
       (if (and open (matching open (car chars)))
           (balanced-chars (cdr chars) (cdr stack))
           #f)))))

(define (matching open close)
  (case open
    ((#\() (#\)))
    ((#\[]) (#\]))
    ((#\{) (#\}))))
