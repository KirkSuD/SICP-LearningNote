#lang racket
;SICP ex1.14 Calculate fib by formula

(define (exp b n) ;; time:O(logn) space:O(1) tail-recursive
  (define (even? n)
    (= (remainder n 2) 0))
  (define (exp-inner a b n) ;; a*b^n unchanged
    (cond ((= n 0) a)
          ((= (remainder n 2) 0) (exp-inner a (* b b) (/ n 2)))
          (else (exp-inner (* a b) (* b b) (/ (- n 1) 2)))))
  (exp-inner 1 b n))
(define (sqrt x)
  (define (abs x) (if (< x 0) (- x) x ))
  (define (average x y)
    (/ (+ x y) 2))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (return-next improved guess x)
    (if (< (/ (abs (- improved guess)) guess) .0000001)
        improved
        (sqrt-iter improved x)))
  (define (sqrt-iter guess x)
    (return-next (improve guess x) guess x))
  (sqrt-iter 1. x))

(define sqrt5 (sqrt 5)) ;2.23606797749979
(define fib-const (/ (+ 1 sqrt5) 2)) ;1.618033988749895
(define (fib-formula n)
  (define (myabs n) (if (< n 0) (- n) n))
  (define (myround n) (if (< (- n (floor n)) (- (ceiling n) n)) (floor n) (ceiling n)))
  (myround (/ (exp fib-const n) sqrt5)))

(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range fib-formula 0 100)
(display "\n")
