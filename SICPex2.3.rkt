#lang racket
;;; SICP ex2.3 Verify an implementation of cons & car works, and write cdr

(define (cons x y)
  (lambda (m) (m x y)) )

(define (car z)
  (z (lambda (p q) p)) )

(define (cdr z)
  (z (lambda (p q) q)) )

;; By the substitution model of section 1.1.5,
;;    (car (cons x y))
;; -> (car (lambda (m) (m x y)))
;; -> ((lambda (m) (m x y)) (lambda (p q) p))
;; -> ((lambda (p q) p) x y)
;; -> x

(displayln (cons 0 1))
(displayln (car (cons 0 1)))
(displayln (cdr (cons 0 1)))
