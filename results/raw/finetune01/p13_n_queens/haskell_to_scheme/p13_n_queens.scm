 
(define *n* 8)
(define *board-size* (*n* *n*))
(define *board* (make-vector *board-size* #f))
 
;; place queen at position i
(define (place-queen i)
  (let ((j (quotient i *n*)))
    (vector-set! *board* i 'Q)
    (do ((k 0 (+ k 1))) ((>= k *n*))
      (vector-set! *board* (+ j (* k *n*)) 'X))))
 
;; remove queen at position i
(define (remove-queen i)
  (let ((j (quotient i *n*)))
    (vector-set! *board* i #f)
    (do ((k 0 (+ k 1))) ((>= k *n*))
      (vector-set! *board* (+ j (* k *n*)) #f))))
 
;; check if placing queen at position i is valid
(define (valid? i)
  (let ((j (quotient i *n*)))
    (and (not (vector-ref *board* i))
         (do ((k 0 (+ k 1))) ((>= k *n*) #t)
           (if (or (eq? (vector-ref *board* (+ j (* k *n*))) 'X')
                   (eq? (vector-ref *board* (- j (* k *n*))) 'X'))
               #f)))))
 
;; print board
(define (print-board)
  (do ((i 0 (+ i 1))) ((= i *board-size*))
    (cond ((eq? (vector-ref *board* i) 'Q') (display " Q"))
          ((eq? (vector-ref *board* i) 'X') (display " X"))
          (else (display " .")))
    (when (= (modulo (+ i 1) *n*) 0) (newline))))
 
;; solve N Queens problem using backtracking
(define (solve-n-queens i)
  (cond ((= i *board-size*) (print-board) (newline))
        ((valid? i) (place-queen i) (solve-n-queens (+ i 1)) (remove-queen i))
        (else (solve-n-queens (+ i 1)))))
 
(solve-n-queens 0)
 
