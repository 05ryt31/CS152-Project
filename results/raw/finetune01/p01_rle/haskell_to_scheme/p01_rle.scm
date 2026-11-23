(define rle
  (lambda (str)
    (let loop ((chars (string->list str))
               (result '()))
      (if (null? chars)
          (reverse result)
          (loop (cdr chars)
                (cons (cons 1 (car chars)) result))))))

(display (rle "AABBBCCCCDDDDDD"))
(newline)
