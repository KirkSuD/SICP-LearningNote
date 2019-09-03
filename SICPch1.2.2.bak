#lang racket
;SICP ch1.2.1 Factorial, recursive and iterative

(define (factorial-recursive n)
  (if (= n 0)
      1
      (* n (factorial-recursive (- n 1)))))
(define (factorial n)
  (define (factorial-iterative res current)
    (if (> current n)
        res
        (factorial-iterative (* res current) (+ current 1))))
  (factorial-iterative 1 1))

(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range factorial-recursive 0 10)
(for_range factorial 0 10)

