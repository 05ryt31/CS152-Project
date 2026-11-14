(import scheme (chicken io) (chicken string))

(define line (read-line))

(define (encode chars)
    (if (null? chars)
        ""
        (let loop ((rest (cdr chars)) (current (car chars)) (count 1) (out ""))
            (if (null? rest)
                (string-append out (string current) (number->string count))
                (if (char=? current (car rest))
                    (loop (cdr rest) current (+ count 1) out)
                    (loop (cdr rest) (car rest) 1
                        (string-append out (string current) (number->string count))))))))

(display (encode (string->list line)))
(newline)
