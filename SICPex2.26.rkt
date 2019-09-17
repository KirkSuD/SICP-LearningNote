#lang racket
;SICP ex2.26 Tree operation: (fringe)

(define (atom? x)
  (and (not (null? x))
       (not (pair? x)) ))

; (define (append x y)
;   (if (null? x)
;       y
;       (cons (car x) (append (cdr x) y)) ))
;; Racket has built-in (append)

;; ex2.26 P.99
(define (fringe x)
  (cond ((atom? x) (list x)) ;; an atom, return a list of it
        ((null? x) x)        ;; empty, return empty
        (else (append (fringe (car x)) (fringe (cdr x)))) ) )
        ;; a pair, combine current and rest

(define x (cons (list 1 2) (list 3 4)))
(append '(1 2) '(3 4)) ;; (1 2 3 4)
x ;; ((1 2) 3 4)
(fringe x) ;; (1 2 3 4)
(list x x) ;; (((1 2) 3 4) ((1 2) 3 4))
(fringe (list x x)) ;; (1 2 3 4 1 2 3 4)
