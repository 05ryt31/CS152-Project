(import scheme (chicken base) (chicken io))

(define (p10_lru)
  (let* ((c-line (read-line))
         (n-line (read-line))
         (c (string->number c-line))
         (n (string->number n-line)))
    (run n c '())))

(define (run n c cache)
  (if (= n 0)
      (halt)
      (let* ((line (read-line))
             (parts (string-split line #\space))
             (next-cache (operation parts c cache)))
        (run (- n 1) c next-cache))))

(define (operation parts c cache)
  (match parts
    (("get" k)
     (let ((key (string->number k)))
       (cond ((assoc key cache)
              (let ((value (cdr (assoc key cache))))
                (display value)
                (newline)
                (cons (cons key value) (remove-assoc key cache))))
             (else
              (display -1)
              (newline)
              cache))))
    (("put" k v)
     (let ((key (string->number k))
           (value (string->number v)))
       (if (> c 0)
           (if (assoc key cache)
               (cons (cons key value) (remove-assoc key cache))
               (let ((len (length cache)))
                 (if (>= len c)
                     (let ((front (butlast cache)))
                       (cons (cons key value) front))
                     (cons (cons key value) cache)))))))))
    (_ cache)))

(define (halt)
  (exit 0))

(define (string-split str delimiter)
  (define (split-helper s acc)
    (let ((pos (string-index s delimiter)))
      (if pos
          (split-helper (substring s (+ pos 1)) (cons (substring s 0 pos) acc))
          (reverse (cons s acc)))))
  (split-helper str '()))

(define (string->number str)
  (string->number str))

(define (assoc key alist)
  (car (member key alist)))

(define (remove-assoc key alist)
  (filter (lambda (pair) (not (= (car pair) key))) alist))

(define (butlast lst)
  (reverse (cdr (reverse lst))))

(p10_lru)
