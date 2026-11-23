(define *n* 8)
 
;; returns #t if queen at (x,y) is under attack by any queen in column x2..xn
(define (under-attack? x y x2 xn)
  (let loop ((x x2))
    (cond ((> x xn) #f)
          ((or (= x y) (= x (- y (* 2 x)))) (loop (+ x 1)))
          (else (loop (+ x 1))))))
 
;; returns #t if queen at (x,y) is under attack by any queen in column 1..xn
(define (under-attack? x y xn)
  (under-attack? x y 1 xn))
 
;; returns list of all possible positions for next queen
(define (next-positions x board)
  (filter (lambda (y) (not (under-attack? x y board))) (iota *n*)))
 
;; returns list of all possible boards for next turn
(define (next-boards board)
  (map (lambda (y) (cons y board)) (next-positions (+ 1 (length board)) board)))
 
;; returns #t if no more queens can be placed
(define (final-board? board)
  (= *n* (length board)))
 
;; returns #t if board is valid
(define (valid-board? board)
  (if (final-board? board)
      #t
      (let ((x (+ 1 (length board))))
        (every (lambda (y) (not (under-attack? x y board))) (next-positions x board)))))
 
;; returns number of solutions
(define (solve-queens board)
  (if (final-board? board)
      (if (valid-board? board) 1 0)
      (apply + (map solve-queens (next-boards board)))))
 
(display (solve-queens '())) (newline)
