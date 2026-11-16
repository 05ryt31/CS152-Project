(import scheme (chicken base) (chicken io))

(define (step stack cmd)
  (cond
    [(string=? cmd "pop") (if (null? stack) (values stack '("error")) (values (cdr stack) #f))]
    [(string=? cmd "add") (if (< (length stack) 2) (values stack '("error")) (let* ((a (car stack)) (b (cadr stack))) (values (cons (+ a b) (cddr stack)) #f)))]
    [(string=? cmd "mul") (if (< (length stack) 2) (values stack '("error")) (let* ((a (car stack)) (b (cadr stack))) (values (cons (* a b) (cddr stack)) #f)))]
    [(string=? cmd "dup") (if (null? stack) (values stack '("error")) (let ((top (car stack))) (values (append stack (list top)) #f)))]
    [(string=? cmd "swap") (if (< (length stack) 2) (values stack '("error")) (let* ((a (car stack)) (b (cadr stack))) (values (cons b (cons a (cddr stack)))))]
    [(string=? cmd "print") (if (null? stack) (values stack '("error")) (let ((top (car stack))) (values stack (list (number->string top)))))]
    [else (values stack #f)]))

(define (apply stack cmds)
  (define-values (new-stack maybe-error) (step stack (car cmds)))
  (if maybe-error
      (values new-stack (cons maybe-error (apply new-stack (cdr cmds))))
      (apply new-stack (cdr cmds))))

(define (run-stack cmds)
  (let loop ((stack '()) (cmds cmds) (outputs '()))
    (if (null? cmds)
        outputs
        (let-values (((new-stack new-outputs) (apply stack (car cmds))))
          (loop new-stack (cdr cmds) (append outputs new-outputs))))))

(define (main)
  (let* ((n (string->number (read-line)))
         (commands (build-list n read-line))
         (results (run-stack commands)))
    (for-each display results)
    (newline)))

(main)
