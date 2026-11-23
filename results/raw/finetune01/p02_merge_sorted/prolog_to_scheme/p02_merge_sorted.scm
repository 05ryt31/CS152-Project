(define merge-sorted-lists
  (lambda (l1 l2)
    (cond ((null? l1) l2)
          ((null? l2) l1)
          ((<= (car l1) (car l2))
           (cons (car l1) (merge-sorted-lists (cdr l1) l2)))
          (else
           (cons (car l2) (merge-sorted-lists l1 (cdr l2)))))))
 
(merge-sorted-lists '(1 3 5 7 9) '(2 4 6 8 10))
