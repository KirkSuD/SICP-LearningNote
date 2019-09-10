#lang racket
;;; SICP ch2.2.2 Recursion for trees: (countatoms)

;; ch2.2.2 P.98
(define (countatoms x)
  (cond ((null? x) 0)
        ((atom? x) 1) ;; order matters, '() satisfies both null? and atom?
        (else (+ (countatoms (car x))
                 (countatoms (cdr x)) )) ))

(define x (cons (list 1 2) (list 3 4)))
x
(length x)
(countatoms x)
(newline)

(list x x)
(length (list x x))
(countatoms (list x x))
