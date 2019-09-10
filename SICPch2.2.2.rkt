#lang racket
;;; SICP ch2.2.2 Recursion for trees: (countatoms)

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))
;; There's no atom? in Racket: https://stackoverflow.com/questions/24173903/drracket-atom-symbol-undefined-what-is-wrong

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
