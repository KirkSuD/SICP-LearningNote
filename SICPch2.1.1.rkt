#lang racket
;;; SICP ch2.1.1 ex2.1 Arithmetic Operators for Rational Numbers (using pairs)

(define (make-rat-primitive n d) (cons n d)) ;; make-rat-primitive ;; no gcd
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (mygcd a b)
  (if (= b 0)
      a
      (mygcd b (remainder a b))))

;; P.79 ex2.1
(define (make-rat n d)
  (let ((g (mygcd n d))) ;; by using mygcd, this solves ex2.1
       (cons (/ n g) (/ d g)) ) )

(define (+rat x y) 
  (make-rat (+ (* (numer x) (denom y))
               (* (denom x) (numer y)) )
            (* (denom x) (denom y)) ) )

(define (-rat x y) 
  (make-rat (- (* (numer x) (denom y))
               (* (denom x) (numer y)) )
            (* (denom x) (denom y)) ) )

(define (*rat x y) 
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y)) ) )

(define (/rat x y) 
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y)) ) )

(define (=rat x y)
  (= (* (numer x) (denom y))
     (* (denom x) (numer y)) ) )

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))


(define one-half (make-rat 1 2))
(print-rat one-half)

(define one-third (make-rat 1 3))
(print-rat one-third)

(newline)

(print-rat (+rat one-half one-third))
(print-rat (-rat one-half one-third))
(print-rat (*rat one-half one-third))
(print-rat (/rat one-half one-third))

(newline)

(print-rat (+rat one-half one-half))
(print-rat (+rat one-third one-third))

(newline)

(=rat one-half (make-rat 2 4))
(=rat one-third (make-rat 2 4))

(newline)

(remainder 6 8)  (mygcd 6 8)  (print-rat (make-rat 6 8))  (newline)
(remainder -6 8) (mygcd -6 8) (print-rat (make-rat -6 8)) (newline)
(remainder 6 -8) (mygcd 6 -8) (print-rat (make-rat 6 -8)) (newline)
(remainder -6 -8)(mygcd -6 -8)(print-rat (make-rat -6 -8))(newline)
