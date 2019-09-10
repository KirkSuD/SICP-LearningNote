#lang racket
;SICP ex2.24 Comparison of append, cons, list

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y) ;; '(1 2 3 4 5 6)
;; fully expand, recursively (cons (car x) (append (cdr x) y))
(cons x y)   ;; '((1 2 3) 4 5 6)
;; simply form a pair of x, y
(list x y)   ;; '((1 2 3) (4 5 6))
;; form a list containing 2 lists: x, y
