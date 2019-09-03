#lang racket
;;; SICP ex1.31 fixed-point test, take function as input

(define (fixed-point f n)
  (let ((next-n (f n)))
    (if (< (abs (- next-n n)) 0.001)
        next-n
        (fixed-point f next-n) ) ) )

(fixed-point cos 1)
