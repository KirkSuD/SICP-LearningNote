#lang racket
;;; SICP ex2.16 List operation: (last)

;; ex2.16 P.93
(define (last x)
  (let ((next (cdr x)))
       (if (null? next)
           (cons (car x) '())
           (last next))))

(define squares (list 1 4 9 16 25))
(last squares)
