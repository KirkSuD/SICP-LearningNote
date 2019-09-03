#lang racket
;;; SICP ex2.2 Segment, point data abstraction, midpoint operator using pairs.

(define (make-point x y) (cons x y))
(define (x-coord point) (car point))
(define (y-coord point) (cdr point))
(define (print-point point)
  (display "(")
  (display (x-coord point))
  (display ", ")
  (display (y-coord point))
  (display ")") )

(define (make-segment start end) (cons start end))
(define (start-point seg) (car seg))
(define (end-point seg) (cdr seg))
(define (print-segment seg)
  (display "[")
  (print-point (start-point seg))
  (display " - ")
  (print-point (end-point seg))
  (display "]") )

(define (midpoint seg)
  (make-point (/ (+ (x-coord (start-point seg))
                    (x-coord (end-point seg)) ) 2)
              (/ (+ (y-coord (start-point seg))
                    (y-coord (end-point seg)) ) 2) ) )

(define pa (make-point 1 2))
(print-point pa) (newline)
(define pb (make-point 3 5))
(print-point pb) (newline)

(newline)

(define sa (make-segment pa pb))
(print-segment sa) (newline)

(define mab (midpoint sa))
(print-point mab) (newline)

(newline)

(define sb (make-segment (make-point 1 2) (make-point -1 -2)))
(print-segment sb) (newline)
(print-point (midpoint sb)) (newline)

(define sc (make-segment (make-point 1 2) (make-point 1 -2)))
(print-segment sc) (newline)
(print-point (midpoint sc)) (newline)

(newline)

(display (cons 0 1))
(display (cons 0 (cons 1 2)))
(display (cons (cons 0 1) (cons 2 3)))
