(import scheme (chicken base) (chicken io))

(define (main args)
  (let ((input (read-line)))
    (permutations input)))

(define (permutations str)
  (define chars (string->list str))
  (define sorted-chars (sort chars char<?))
  (define ordered-pelems
    (remove-duplicates
     (map list->string
          (permutations-helper sorted-chars))))
  (for-each displayln ordered-pelems))

(define (permutations-helper lst)
  (cond
   ((null? lst) (list '()))
   (else (append-map (lambda (perm)
                       (map (lambda (i)
                              (cons (car lst) (insert i perm)))
                            (iota (length perm + 1))))
                     (permutations-helper (cdr lst))))))

(define (insert x lst)
  (if (null? lst)
      (list x)
      (cons (car lst) (insert x (cdr lst)))))

(define (remove-duplicates lst)
  (cond
   ((null? lst) '())
   (else (let ((head (car lst))
                (tail (cdr lst)))
           (if (member head tail)
               (remove-duplicates tail)
               (cons head (remove-duplicates tail))))))

(define (displayln . args)
  (apply display args)
  (newline))

(main (command-line-arguments))
