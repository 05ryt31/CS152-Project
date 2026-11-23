```scheme
 
(define (calc s)
  (define (tokenize str)
    (let tokenize ((str str)
                   (result '()))
      (cond ((string=? "" str)
             (reverse result))
            ((char-whitespace? (string-ref str 0))
             (tokenize (substring str 1) result))
            ((char-numeric? (string-ref str 0))
             (let tokenize-number ((str str)
                                   (number ""))
               (if (or (= (string-length str) 0)
                       (char-numeric? (string-ref str 0)))
                 (tokenize (if (= (string-length str) 0)
                               ""
                               (substring str 1))
                           (cons (+ (* 10 number) (string->number (substring str 0 1))) result))
                 (tokenize-number (substring str 1) (+ (* 10 number) (string->number (substring str 0 1)))))))
            (else
             (tokenize (substring str 1) (cons (substring str 0 1) result))))))
  (define (eval tokens)
    (if (null? tokens)
      0
      (let eval-term ((term (car tokens))
                      (tokens (cdr tokens))
                      (result 0))
        (if (null? tokens)
          result
          (case term
            ((+) (eval-term (car tokens) (cdr tokens) (+ result (car tokens))))
            ((-) (eval-term (car tokens) (cdr tokens) (- result (car tokens))))
            (else
             (eval-mul (car tokens) (cdr tokens) result)))))))
  (define (eval-mul token tokens result)
    (if (null? tokens)
      result
      (case token
        ((*) (eval-mul (car tokens) (cdr tokens) (* result (car tokens))))
        (else
         (eval-add token tokens result)))))
  (define (eval-add token tokens result)
    (if (null? tokens)
      result
      (case token
        ((+) (eval-add (car tokens) (cdr tokens) (+ result (car tokens))))
        ((-) (eval-add (car tokens) (cdr tokens) (- result (car tokens))))
        (else
         (eval-factor token tokens result)))))
  (define (eval-factor token tokens result)
    (if (null? tokens)
      result
      (case token
        (((+ - * / ^)) (eval-factor (car tokens) (cdr tokens) result))
        ((^) (eval-factor (car tokens) (cdr tokens) (^ result (car tokens))))
        ((/) (eval-factor (car tokens) (cdr tokens) (/ result (car tokens))))
        ((*) (eval-factor (car tokens) (cdr tokens) (* result (car tokens))))
        ((+) (eval-factor (car tokens) (cdr tokens) (+ result (car tokens))))
        ((-) (eval-factor (car tokens) (cdr tokens) (- result (car tokens))))
        (else
         (eval-parentheses token tokens result)))))
  (define (eval-parentheses token tokens result)
    (if (null? tokens)
      result
      (case token
        ((+) (eval-parentheses (car tokens) (cdr tokens) (+ result (car tokens))))
        ((-) (eval-parentheses (car tokens) (cdr tokens) (- result (car tokens))))
        ((*) (eval-parentheses (car tokens) (cdr tokens) (* result (car tokens))))
        ((/) (eval-parentheses (car tokens) (cdr tokens) (/ result (car tokens))))
        ((^) (eval-parentheses (car tokens) (cdr tokens) (^ result (car tokens))))
        ((/)) (eval-parentheses (car tokens) (cdr tokens) (/ result (car tokens))))
        ((*) (eval-parentheses (car tokens) (cdr tokens) (* result (car tokens))))
        ((+) (eval-parentheses (car tokens) (cdr tokens) (+ result (car tokens))))
        ((-) (eval-parentheses (car tokens) (cdr tokens) (- result (car tokens))))
        (else
         (eval-parentheses token tokens result))))))
  (eval (tokenize s)))
 
(calc "2 + 3")
(calc "(2 + 3)")
(calc "(2 + 3) * 4")
(calc "((2 + 3) * 4) / 5")
(calc "((2 + 3) * 4) / 5 ^ 2")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19 ^ 20")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19 ^ 20 ^ 21")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19 ^ 20 ^ 21 ^ 22")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19 ^ 20 ^ 21 ^ 22 ^ 23")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11 ^ 12 ^ 13 ^ 14 ^ 15 ^ 16 ^ 17 ^ 18 ^ 19 ^ 20 ^ 21 ^ 22 ^ 23 ^ 24")
(calc "((2 + 3) * 4) / 5 ^ 2 ^ 3 + 7 * 8 / 9 ^ 10 ^ 11
