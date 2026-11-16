(import scheme (chicken base) (chicken io))

(define (parse-token str)
  (cond ((string=? "" str) #f)
        ((char-whitespace? (string-ref str 0))
         (parse-token (substring str 1)))
        ((char-numeric? (string-ref str 0))
         (let loop ((i 0) (acc ""))
           (if (< i (string-length str))
               (loop (+ i 1)
                     (string-append acc (string (string-ref str i))))
               (string->number acc))))
        (else
         (substring str 0 1))))

(define (parser text)
  (define tokens '())
  (define pos 0)

  (define (add-token token)
    (set! tokens (cons token tokens)))

  (define (next-token)
    (when (< pos (string-length text))
      (let ((token (parse-token (substring text pos))))
        (set! pos (+ pos (string-length token)))
        token)))

  (define (expression)
    (let ((value (term)))
      (loop)))

  (define (loop)
    (let ((op (next-token)))
      (if (or (string=? "+" op) (string=? "-" op))
          (let ((right (term)))
            (set! value (if (string=? "+" op) (+ value right) (- value right)))
            (loop))
          value)))

  (define (term)
    (let ((value (factor)))
      (loop)))

  (define (loop)
    (let ((op (next-token)))
      (if (string=? "*" op)
          (begin
            (next-token)
            (set! value (* value (factor)))
            (loop))
          value)))

  (define (factor)
    (let ((token (next-token)))
      (if (string=? "(" token)
          (let ((value (expression)))
            (next-token)
            value)
          (string->number token))))

  (lambda ()
    (let loop ()
      (let ((token (next-token)))
        (when token
          (add-token token)
          (loop))))
    (expression)))

(define (main)
  (let ((text (read-line)))
    (display (parser text))
    (newline)))

(main)
