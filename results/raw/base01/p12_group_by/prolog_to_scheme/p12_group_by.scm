(import scheme (chicken base) (chicken io))

(define (p12-group-by)
  (let loop ((groups '()))
    (let* ((line (read-line))
           (n (string->number line)))
      (if (= n 0)
          (begin
            (set! groups (keysort groups))
            (print-groups groups)
            (exit 0))
          (loop (update-groups groups))))))

(define (update-groups groups)
  (let ((line (read-line))
        (split (lambda (str delim) (regexp-split #px" " str))))
        (number-string string->number))
    (let* ((parts (split line))
           (key (car parts))
           (value (number-string (cadr parts))))
      (cons (list key value 1) groups))))

(define (keysort lst)
  (define (compare a b)
    (string<? (car a) (car b)))
  (sort lst compare))

(define (print-groups groups)
  (for-each (lambda (group)
              (format #t "~a ~a ~a\n" (car group) (cadr group) (caddr group)))
            groups))

(p12-group-by)
