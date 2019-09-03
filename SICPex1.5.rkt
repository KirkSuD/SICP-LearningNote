#lang racket
;SICP ex1.5 good-enough? Improvement
; 
#|
a nice answer: https://sicp.readthedocs.io/en/latest/chp1/7.html

old:
  small number -> wrong answer
  big number -> infinite loop because of precision
new:
  small number -> nice
  big number -> ok, but some answer is worse than the old way
                      because of "fraction"
|#
(define (abs x) (if (< x 0) (- x) x ))
(define (square x) (* x x))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) .001))
(define (average x y)
  (/ (+ x y) 2))
(define (improve guess x)
  (average guess (/ x guess)))
(define (return-next improved guess x)
  (if (< (/ (abs (- improved guess)) guess) .001)
      improved
      (sqrt-iter-new improved x)))
(define (sqrt-iter-new guess x)
  (display guess)(display "\n") ; just display current value
  (return-next (improve guess x) guess x)) ; the new return function
(define (sqrt-iter guess x)
  (display guess)(display "\n") ; just display current value
  (if (good-enough? guess x) ; old way to stop
    guess
    (sqrt-iter (improve guess x)
               x)))
(define (sqrt x)
  (sqrt-iter 1. x))
(define (sqrt-new x)
  (sqrt-iter-new 1. x))

(sqrt 0.00009);123456789123456789)
(sqrt-new 0.00009);900000000000000000000000000000000000000000000000000000000000000000000000000000000000)
