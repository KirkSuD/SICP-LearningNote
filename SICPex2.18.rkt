#lang racket
;;; SICP ex2.18 List operation: (square-list)

;; ex2.18 P.94
(define (square-list x)
  (define (square n) (* n n))
  (if (null? x)
      '()
      (cons (square (car x))
            (square-list (cdr x)) )))

(define 1-through-4 (list 1 2 3 4))
(square-list 1-through-4)
