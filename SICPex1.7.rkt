#lang racket
;SICP ex1.7 Two Recursive Procedures for Adding two N, Recursive and Iterative Process

(define (1+ x) (- x (- 1)))
(define (-1+ x) (- x 1))

;recursive process
#;(define (+ a b)
  ;(display a)(display " ")(display b)(display "\n")
  (if (= a 0)
      b
      (1+ (+ (-1+ a) b))))

;iterative process
(define (+ a b)
  ;(display a)(display " ")(display b)(display "\n")
  (if (= a 0)
      b
      (+ (-1+ a) (1+ b))))

(+ 1000000 3)
