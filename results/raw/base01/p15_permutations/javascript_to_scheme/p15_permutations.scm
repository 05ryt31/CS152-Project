(import scheme (chicken base) (chicken io))

(define (generate prefix remaining)
  (if (null? remaining)
      (begin
        (display (string-join prefix))
        (newline))
      (for-each (lambda (i)
                  (generate (append prefix (list (list-ref remaining i)))
                             (remove (list-ref remaining i) remaining)))
                (iota (length remaining)))))

(let* ((letters (sort (string->list (read-line)) char<?))
       (output '()))
  (generate '() letters))
