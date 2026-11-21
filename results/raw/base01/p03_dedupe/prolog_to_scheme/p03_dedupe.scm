(import scheme (chicken base) (chicken io))

(define (p03-dedupe)
  (let loop ()
    (let ((line (read-line)))
      (if (eof-object? line)
          (exit 0)
          (begin
            (let* ((ns (nums line))
                   (result (unique ns '()))
                   (text (string-join (map number->string result) " ")))
              (display text)
              (newline)
              (loop)))))))

(define (nums line)
  (cond
    ((eof-object? line) '())
    ((null? line) '())
    (else
     (let ((parts (string-split line #\space)))
       (if (null? parts)
           '()
           (map string->number parts))))))

(define (unique lst seen result)
  (cond
    ((null? lst) (reverse result))
    (else
     (let ((x (car lst)))
       (if (member x seen)
           (unique (cdr lst) seen result)
           (unique (cdr lst) (cons x seen) (cons x result)))))))

(p03-dedupe)
