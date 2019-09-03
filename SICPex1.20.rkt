#lang racket
;;; SICP ex1.20 expmod-slow: expmod first, then take its remainder

(define (fast-exp-iter b n) ;; time:O(logn) space:O(1) ;; from SICPex1.11.rkt
  (define (even? n)
    (= (remainder n 2) 0))
  (define (fast-exp-iter-inner a b n) ;; a*b^n unchanged
    (cond ((= n 0) a)
          ((even? n) (fast-exp-iter-inner a (* b b) (/ n 2)))
          (else (fast-exp-iter-inner (* a b) (* b b) (/ (- n 1) 2)))))
  (fast-exp-iter-inner 1 b n))

(define (expmod b e m)
  (define (square n) (* n n))
  (cond ((= e 0) 1)
        ((= (remainder e 2) 0) (remainder (square (expmod b (/ e 2) m)) m))
        (else (remainder (* b (expmod b (- e 1) m)) m))))

(define (expmod-slow b e m)
  (remainder (fast-exp-iter b e) m))

(display "hello\n")
(expmod 1000000000 100000000 3)
(expmod-slow 1000000000 100000000 3)
(display "hello")
