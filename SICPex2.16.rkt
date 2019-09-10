#lang racket
;;; SICP ex2.16 List operation: (append), (last), (reverse)

;; ch2.2.1 P.93
;; should be moved to SICPch2.2.1.rkt
(define (append x y)
  (if (null? x)
      y
      (cons (car x)
            (append (cdr x) y))))

;; ex2.16 P.93
(define (last x)
  (let (cdrx (cdr x))
       (if (null? cdrx)
           (cons (car x) '())
           (last cdrx))))
