#lang racket
;;; SICP ch1.3.4 ex1.34 Procedures as Returned Values, derivative, newton's method

(define (newton f guess)
  (define (good-enough? guess f)
    (< (abs (f guess)) 0.001))
  (define (deriv f dx)
    (lambda (x)
      (/ (- (f (+ x dx))
            (f x))
         dx))) ;; using the definition of derivative
  (define (improve guess f)
    (- guess (/ (f guess) ;; improve by y - (f(y)/Df(y))
                ((deriv f 0.001) guess))))
  (if (good-enough? guess f)
      guess
      (newton f (improve guess f)) ) )

(newton (lambda (x) (- x (cos x))) 1) ;; cosx = x

(display "\n")

;; P.70 ex1.34
(define (cubic a b c)
  (lambda (x)
    (+ (* x x x) (* a x x) (* b x) c) ) )

(define x3-36x (cubic 0 -36 0))
(newton x3-36x 500) ;; 6
(newton x3-36x 2)   ;; 0
(newton x3-36x -500);; -6
