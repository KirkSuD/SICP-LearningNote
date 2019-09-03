#lang racket
;;; SICP ex1.35 Procedures as returned values, iterative-improve, last ex of ch1

(define (iterative-improve good-enough? improve)
  (define (res guess)
    (if (good-enough? guess)
        guess
        (res (improve guess)) ) )
  res)

(define (newton f guess) ;; newton's method, refer to SICPch1.3.4.rkt
  ;; some constants defined first
  (define error-tolerance 0.001) ;; for good-enough?
  (define dx 0.001) ;; dx for derivative
  ( (iterative-improve
      (lambda (guess) ;; good-enough?
        (< (abs (f guess)) error-tolerance) ) ;; f(guess) is close enough to 0
      (lambda (guess) ;; improve
        (define (df x) ;; derivative
          (/ (- (f (+ x dx)) (f x)) dx))
        (- guess (/ (f guess) (df guess))) ) )
    guess ) ) ;; improve by y - (f(y)/Df(y))

(define (fixed-point f guess) ;; locate fixed-point, refer to SICPex1.31.rkt
  ( (iterative-improve
      (lambda (guess)
        (< (abs (- guess (f guess))) 0.001))
      f )
    guess ) )

(newton (lambda (x) (- x (cos x))) 1) ;; cosx = x
(fixed-point cos 1)
