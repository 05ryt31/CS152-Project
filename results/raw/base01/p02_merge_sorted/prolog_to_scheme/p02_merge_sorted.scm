(import scheme (chicken base) (chicken io))

(define (p02_merge_sorted)
  (let* ((ALine (read-line))
         (BLine (read-line))
         (A (nums ALine))
         (B (nums BLine))
         (Result (merge A B)))
    (print_nums Result)))

(define (nums line)
  (cond
    ((eof-object? line) '())
    ((string=? line "") '())
    (else
     (let ((parts (string-split line #\space)))
       (if (null? parts)
           '()
           (map string->number parts))))))

(define (merge xs ys)
  (cond
    ((null? xs) ys)
    ((null? ys) xs)
    ((<= (car xs) (car ys))
     (cons (car xs) (merge (cdr xs) ys)))
    (else
     (cons (car ys) (merge xs (cdr ys))))))

(define (print_nums ns)
  (when (not (null? ns))
    (display (apply string-append (map number->string ns)))
    (display " ")
    (print_nums (cdr ns))))

(p02_merge_sorted)
