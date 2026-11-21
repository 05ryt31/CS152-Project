(import scheme (chicken base) (chicken io))

(define (rle str)
  (define (helper lst acc)
    (if (null? lst)
        (reverse acc)
        (let* ((first (car lst))
               (rest (cdr lst))
               (count (length (take-while (lambda (x) (= x first)) rest))))
          (helper (drop count rest) (cons (list first (+ 1 count)) acc)))))
  (map (lambda (g) (string-append (string (car g)) (number->string (cadr g)))) (reverse (helper (string->list str) '()))))

(define (main)
  (let ((line (read-line)))
    (display (rle line))
    (newline)))

(main)
