(import scheme (chicken base) (chicken io))

(define (main args)
  (define lines (string-split (read-all-input) #\newline))
  (define n (string->number (car lines)))
  
  (define stack '())
  (define output '())
  
  (define (process-op op)
    (cond
      ((string=? op "push") (push-stack! (string->number (cadr parts))))
      ((string=? op "pop") (pop-stack!))
      ((or (string=? op "add") (string=? op "mul")) (binary-op! op))
      ((string=? op "dup") (duplicate-top!))
      ((string=? op "swap") (swap-tops!))
      (else (push-output! (if (null? stack) "error" (number->string (car (reverse stack))))))))
  
  (define (push-stack! value)
    (set! stack (cons value stack)))
  
  (define (pop-stack!)
    (when (> (length stack) 0)
      (set! stack (cdr stack))))
  
  (define (binary-op! op)
    (when (> (length stack) 1)
      (let* ((b (car stack))
             (a (cadr stack))
             (result (if (string=? op "add") (+ a b) (* a b))))
        (pop-stack!)
        (pop-stack!)
        (push-stack! result))))
  
  (define (duplicate-top!)
    (when (> (length stack) 0)
      (push-stack! (car stack))))
  
  (define (swap-tops!)
    (when (> (length stack) 1)
      (let* ((top (car stack))
             (second-top (cadr stack)))
        (pop-stack!)
        (pop-stack!)
        (push-stack! second-top)
        (push-stack! top))))
  
  (define (push-output! value)
    (set! output (append output (list value))))
  
  (define (read-all-input)
    (let loop ()
      (let ((line (read-line)))
        (if (eof-object? line)
            ""
            (string-append line "\n" (loop))))))
  
  (define (string-split str delimiter)
    (let loop ((chars (string->list str))
               (current "")
               (result '()))
      (cond
        ((null? chars)
         (if (string=? current "")
             (reverse result)
             (reverse (cons current result))))
        ((char=? (car chars) delimiter)
         (loop (cdr chars) "" (cons current result)))
        (else
         (loop (cdr chars) (string-append current (string (car chars))) result)))))
  
  (do ((i 0 (+ i 1)))
      ((>= i n))
    (let ((parts (string-split (list-ref lines (+ i 1)) #\space)))
      (process-op (car parts))))
  
  (when (> (length output) 0)
    (display (string-join output "\n"))
    (newline))
  
  (exit 0))

(main (command-line-arguments))
