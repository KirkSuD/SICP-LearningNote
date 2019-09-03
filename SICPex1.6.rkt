#lang racket
;SICP ex1.6 cube root & Newton's method abstraction(function as arguemant)
;
(define (abs x) (if (< x 0) (- x) x ))

(define (good-enough? compare-func guess stop-diff x)
  (< (abs (- (compare-func guess) x)) stop-diff))
(define (newtons improve-func compare-func guess stop-diff x)
  (display guess)(display "\n") ; just display current value
  (if (good-enough? compare-func guess stop-diff x) ; old way to stop
    guess
    (newtons improve-func compare-func (improve-func guess x) stop-diff x)))

(define (return-next improve-func improved guess stop-fraction x)
  (if (< (/ (abs (- improved guess)) guess) stop-fraction)
      improved
      (newtons-new improve-func improved stop-fraction x)))
(define (newtons-new improve-func guess stop-fraction x)
  (display guess)(display "\n") ; just display current value
  (return-next improve-func (improve-func guess x) guess stop-fraction x)) ; the new return function

(define (square x) (* x x))
(define (average x y)
  (/ (+ x y) 2))
(define (improve-sqrt guess x)
  (average guess (/ x guess)))

(define (cube x) (* x x x))
(define (improve-cuberoot guess x)
  (/ (+ (/ x guess guess) (* 2 guess)) 3))

(newtons improve-sqrt square 1. 0.01 10000)
(newtons-new improve-sqrt 1. 0.01 10000)

(newtons improve-cuberoot cube 1. 0.01 1000000)
(newtons-new improve-cuberoot 1. 0.01 1000000)
