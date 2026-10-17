(import scheme (chicken io))

(for-each
  (lambda (line) (display line) (newline))
  (reverse (read-lines)))
