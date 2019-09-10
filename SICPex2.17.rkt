#lang racket
;;; SICP ex2.17 List operation: (reverse)

;; ex2.17 P.94
(define (reverse x)
  (define (reverse-iter x res) ;; like a stack
    (if (null? x)
        res
        (reverse-iter (cdr x)
                      (cons (car x) res))))
  (reverse-iter x '()))

(define squares (list 1 4 9 16 25))
(reverse squares)
