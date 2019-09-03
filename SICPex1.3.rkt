#lang racket
;SICP ex1.3 applicative-order eval VS normal-order eval
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
