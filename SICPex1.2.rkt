#lang racket
;SICP ex1.2 TwoBiggestSquareSum
(define (SquareSum a b) (+ (* a a) (* b b)))
(define (TwoBiggestSquareSum a b c)
  (cond ((and (> b a) (> c a)) (SquareSum b c))
        ((and (> a b) (> c b)) (SquareSum a c))
        ((and (> a c) (> b c)) (SquareSum a b))))
(SquareSum 1 3)
(TwoBiggestSquareSum 1 2 3)