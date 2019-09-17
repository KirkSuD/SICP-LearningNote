#lang racket
;SICP ex2.25 Tree operation: (deep-reverse)

(define (atom? x)
  (and (not (null? x))
       (not (pair? x)) ) )

(define (reverse x)
  (define (reverse-iter x res)
    (if (null? x)
        res
        (reverse-iter (cdr x) (cons (car x) res))))
  (reverse-iter x '()))

;; ex2.25 P.99
(define (deep-reverse x)
  (define (reverse-inner x res)
    (if (null? x)
        res
        (reverse-inner (cdr x) (cons ( let ( (cur (car x)) )
             (if (atom? cur) cur (deep-reverse cur))
        ) res)) ))
  (reverse-inner x '()))

(define (deep-reverse-simple x)
  (define (reverse-inner x res)
    (if (null? x)
        res
        (reverse-inner (cdr x) (cons (deep-reverse-simple (car x)) res)) ) )
  (if (atom? x) x (reverse-inner x '())) )

(define x (cons (list 1 2) (list 3 4)))
x ;; ((1 2) 3 4)
(reverse x) ;; (4 3 (1 2))
(deep-reverse x) ;; (4 3 (2 1))
(deep-reverse-simple x) ;; (4 3 (2 1))
