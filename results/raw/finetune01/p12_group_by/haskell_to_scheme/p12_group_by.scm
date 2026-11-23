 
(import (scheme base)
        (scheme write)
        (srfi 1)) ; for fold
 
;; split string by whitespace
(define (split str)
  (string-tokenize str #f #t))
 
;; parse line into key and value
(define (parse-line line)
  (let ((tokens (split line)))
    (list (car tokens) (string->number (cadr tokens)))))
 
;; accumulate totals for each key
(define (accumulate-totals lines)
  (fold (lambda (line acc)
          (let* ((kv-pair (parse-line line))
                 (key   (car kv-pair))
                 (val   (cadr kv-pair)))
            (if (assoc key acc)
              (cons (cons key (+ val (cdr (assoc key acc)))) acc)
              (cons (cons key val) acc))))
        '()
        lines))
 
;; format totals for each key
(define (format-totals totals)
  (map (lambda (pair)
         (let ((key (car pair))
               (val (cdr pair)))
           (string-append key " "
                          (number->string val)
                          " "
                          (number->string (length (filter (lambda (x) (= x key)) totals))))))
        totals))
 
;; main function
(define (group-by-key lines)
  (format-totals (accumulate-totals lines)))
 
;; test cases
(display (group-by-key '("a 1" "b 2" "a 3" "b 4" "c 5"))) (newline)
(display (group-by-key '("a 1" "b 2" "a 3" "b 4" "c 5" "a 6" "d 7" "e 8" "d 9" "e 10" "e 11"))) (newline))
 
