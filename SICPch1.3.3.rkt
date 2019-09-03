#lang racket
;;; SICP ch1.3.3 Procedures as General Methods, find root and maximum

(define (close-enough? x y) (< (abs (- x y)) 0.01))
(define (abs n) (if (< n 0) (- n) n))

(define (half-interval-method f a b)
  (define (positive? n) (> n 0))
  (define (negative? n) (< n 0))
  (define (average a b) (/ (+ a b) 2.))
  (define (search f neg-point pos-point)
    ;;(display neg-point) (display ",") (display pos-point) (display "\n")
    (let ((midpoint (average neg-point pos-point)))
      (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                  (search f neg-point midpoint))
                 ((negative? test-value)
                  (search f midpoint pos-point))
                 (else midpoint))))))
  (let ((a-value (f a))
         (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign:" a b)))))
(define (golden-max f a b)
  (define golden-ratio (/ (- (sqrt 5) 1) 2))
  ;; (display golden-ratio) (display "\n")
  (define golden-ratio-squared (* golden-ratio golden-ratio))
  (define (x-point a b)
    (+ a (* golden-ratio-squared (- b a))))
  (define (y-point a b)
    (+ a (* golden-ratio (- b a))))
  (define (reduce f a x y b fx fy)
    ;; (display "hey\n") ;; for counting eval times, remember to -1
    (cond ((close-enough? a b) x)
          ((> fx fy)
           (let ((new (x-point a y)))
             (reduce f a new x y (f new) fx)))
          (else
           (let ((new (y-point x b)))
             (reduce f x y new b fy (f new))))))
  (let ((x (x-point a b))
        (y (y-point a b)))
    (reduce f a x y b (f x) (f y))))
(half-interval-method sin 2 4)
(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3)) 1 2)
(* 2 (golden-max sin 0 3))