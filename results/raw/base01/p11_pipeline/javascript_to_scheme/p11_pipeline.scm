(import scheme (chicken base) (chicken io))

(define (main args)
  (define lines (string-split (read-string) #\newline))
  (define first (and (not (null? lines)) (string-trim (car lines))))
  (define-values (values k)
    (if first
        (let* ((first-values (string-split first #px"[ \t]+"))
               (num-values (map string->number first-values)))
          (values num-values (string->number (cadr lines))))
        (values '() 0)))
  (define (process-result result)
    (cond
      ((and (list? result) (null? result)) "none")
      ((and (list? result) (pair? result)) (apply string-append (map number->string result) "\n"))
      (else (number->string result))))
  (define (process-command command)
    (match command
      (("map" "add" n) (map (lambda (x) (+ x (string->number n))) values))
      (("map" "mul" n) (map (lambda (x) (* x (string->number n))) values))
      (("filter" "even") (filter even? values))
      (("filter" "odd") (filter odd? values))
      (("filter" n) (filter (lambda (x) (> x (string->number n))) values))
      (("sum") (apply + values))
      (("max") (if (null? values) "none" (number->string (apply max values)))))
  (define result
    (foldl (lambda (command acc)
             (process-command (string-split command #px"[ \t]+")))
           values
           (drop lines (+ 2 k))))
  (display (process-result result))
  (newline)
  (exit 0))

(main (command-line-arguments))
