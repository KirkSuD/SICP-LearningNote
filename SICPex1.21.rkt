#lang racket
;;; SICP ex1.21 expmod-slow: expmod(logn) without square, becomes O(n)

(define (expmod b e m)
  (define (square n) (* n n))
  (cond ((= e 0) 1)
        ((= (remainder e 2) 0) (remainder (square (expmod b (/ e 2) m)) m))
        (else (remainder (* b (expmod b (- e 1) m)) m))))

#|
expmod-slow complexity:
f(n)=2f(n/2)+cn^0
use the master theorem,
a=2, b=2, c=c, d=0
a>b^d (a>1): O(n^(logb(a)))=O(n)
Discrete Math and Its Applications 7e ch8.3 p.532
|#
(define (expmod-slow b e m)
  (cond ((= e 0) 1)
        ((= (remainder e 2) 0) (remainder
                                (* (expmod-slow b (/ e 2) m)
                                   (expmod-slow b (/ e 2) m))
                                m))
        (else (remainder (* b (expmod-slow b (- e 1) m)) m))))

(display "hello\n")
(expmod 1000000000 100000000 3)
(expmod-slow 1000000000 100000000 3)
(display "hello")
