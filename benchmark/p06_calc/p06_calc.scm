(import scheme (chicken io) (chicken string))

(define (tokenize str)
    (let loop ((cs (string->list str)) (tokens '()))
        (cond
            ((null? cs) (reverse tokens))
            ((char-whitespace? (car cs)) (loop (cdr cs) tokens))
            ((char-numeric? (car cs))
            (let num-loop ((cs cs) (acc '()))
                (if (and (pair? cs) (char-numeric? (car cs)))
                    (num-loop (cdr cs) (cons (car cs) acc))
                    (loop cs (cons (string->number (list->string (reverse acc))) tokens)))))
            (else
                (loop (cdr cs) (cons (string->symbol (string (car cs))) tokens))))))

(define (parse-expr tokens)
    (let loop ((res (parse-term tokens)))
        (let ((val (car res)) (rest (cdr res)))
            (cond
                ((and (pair? rest) (eq? (car rest) '+))
                    (let ((next (parse-term (cdr rest))))
                        (loop (cons (+ val (car next)) (cdr next)))))
                ((and (pair? rest) (eq? (car rest) '-))
                    (let ((next (parse-term (cdr rest))))
                        (loop (cons (- val (car next)) (cdr next)))))
                (else res)))))

(define (parse-term tokens)
    (let loop ((res (parse-factor tokens)))
        (let ((val (car res)) (rest (cdr res)))
            (cond
                ((and (pair? rest) (eq? (car rest) '*))
                    (let ((next (parse-factor (cdr rest))))
                        (loop (cons (* val (car next)) (cdr next)))))
                (else res)))))

(define (parse-factor tokens)
    (cond
        ((number? (car tokens))
            (cons (car tokens) (cdr tokens)))
        (else
            (let ((res (parse-expr (cdr tokens))))
                (cons (car res) (cddr res))))))

(define (calc str)
    (car (parse-expr (tokenize str))))

(display (calc (read-line)))
(newline)
