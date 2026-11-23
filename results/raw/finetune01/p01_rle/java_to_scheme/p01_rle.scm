(define rle
  (lambda (str)
    (let loop ((chars (string->list str))
               (count 0)
               (char #\nul)
               (result '()))
      (cond ((null? chars)
             (if (= count 0)
                 (reverse result)
                 (cons (cons char (+ count 1)) result)))
            ((eq? char (car chars))
             (loop (cdr chars) (+ count 1) char result))
            (else
             (loop (cdr chars) 1 (car chars)
                   (cons (cons char count) result)))))))
 
(display (rle "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"))
(newline)
