(define *board-size* 8)
 
;; A position is represented by a pair (x . y)
;; where x and y are integers in the range 0..(*board-size*-1)
;;
;; A board is represented by a list of positions
;; where each position is a queen
 
;; Return true iff no queens threaten each other
(define (valid-board? board)
  (let loop ((remaining board))
    (cond ((null? remaining) #t)
          ((threatened? (car remaining) (cdr remaining)) #f)
          (else (loop (cdr remaining))))))
 
;; Return true iff pos threatens any of the other positions
(define (threatened? pos others)
  (if (null? others)
      #f
      (or (same-row-or-col? pos (car others))
          (same-diagonal? pos (car others))
          (threatened? pos (cdr others)))))
 
;; Return true iff pos and other are in the same row or column
(define (same-row-or-col? pos other)
  (or (= (car pos) (car other))
      (= (cdr pos) (cdr other))))
 
;; Return true iff pos and other are on the same diagonal
(define (same-diagonal? pos other)
  (= (abs (- (* 2 (car pos)) (car other) (+ (cdr pos) (cdr other)))) 0))
 
;; Return all valid boards with n queens
(define (solve-n-queens n)
  (define (choose-queen col)
    (map (lambda (row) (cons col row))
         (iota n)))
  (filter valid-board?
          (apply append (map choose-queen (iota n)))))
 
;; Print all solutions
(let ((solutions (solve-n-queens *board-size*)))
  (for-each (lambda (solution)
              (display solution) (newline))
            solutions))
(display (length solutions)) (newline))
