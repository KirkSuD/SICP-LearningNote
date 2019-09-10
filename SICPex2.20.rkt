#lang racket
;;; SICP ex2.20 List operation: (mapcar) apply a function to a list

;; ex2.20 P.95
(define (mapcar func thelist)
  (if (null? thelist)
      '()
      (cons (func (car thelist))
            (mapcar func (cdr thelist)))))

(define 1-through-4 (list 1 2 3 4))
(define (square n) (* n n))
(define (plus-one n) (+ 1 n))

(mapcar square 1-through-4)
(mapcar plus-one 1-through-4)
