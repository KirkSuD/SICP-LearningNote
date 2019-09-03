#lang racket
;;; SICP ch2.1.3 Implement pairs using only procedures

(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m)) ) )
  dispatch )
(define (car z) (z 0))
(define (cdr z) (z 1))

(displayln (cons 0 1))
(displayln (car (cons 0 1)))
(displayln (cdr (cons 0 1)))
