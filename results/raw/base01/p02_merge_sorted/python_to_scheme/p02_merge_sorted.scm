(import scheme (chicken base) (chicken io))

(define (parse-line line)
  (map string->number (string-split line)))

(define (merge-sorted a b)
  (let loop ((i 0) (j 0) (merged '()))
    (cond
      ((and (< i (length a)) (< j (length b)))
       (if (<= (list-ref a i) (list-ref b j))
           (loop (+ i 1) j (cons (list-ref a i) merged))
           (loop i (+ j 1) (cons (list-ref b j) merged))))
      ((< i (length a))
       (loop (+ i 1) j (cons (list-ref a i) merged)))
      ((< j (length b))
       (loop i (+ j 1) (cons (list-ref b j) merged)))
      (else
       (reverse merged)))))

(define (main)
  (let* ((lines (string-split (read-all-input) "\n"))
         (a (if (> (length lines) 0) (parse-line (car lines)) '()))
         (b (if (> (length lines) 1) (parse-line (cadr lines)) '()))
         (merged (merge-sorted a b)))
    (when (> (length merged) 0)
      (for-each display merged)
      (newline))))

(main)
