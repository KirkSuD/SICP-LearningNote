#lang racket
;SICP ex2.23 Pick element using car & cdr

(car (cdr (car (cdr (cdr (car (cdr '(1 (2 3 (5 7) 9)) )))))))
(cadr (cadr (cdr (cadr '(1 (2 3 (5 7) 9)) ))))

(car (car '((7))))

(cadr (cadr (cadr (cadr (cadr (cadr '(1 (2 (3 (4 (5 (6 7)))))) ))))) )

