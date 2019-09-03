#lang racket
;SICP ex1.12 O(logn) "multiply"

(define (mymultiply-recur a b)
  (if (= b 0)
      0
      (+ a (mymultiply-recur a (- b 1)))))
(define (mymultiply-iter a b)
  (define (mymultiply-iter-inner b res)
    (if (= b 0)
        res
        (mymultiply-iter-inner (- b 1) (+ a res))))
  (mymultiply-iter-inner b 0))
(define (fast-mymultiply-recur-simple a b)
  (define (double n) (+ n n))
  (define (halve n) (/ n 2))
  (cond ((= b 0) 0)
        ((= (remainder b 2) 0) (double (fast-mymultiply-recur-simple a (halve b))))
        (else (+ a (fast-mymultiply-recur-simple a (- b 1))))))
(define (fast-mymultiply-recur a b)
  (define (double n) (+ n n))
  (define (halve n) (/ n 2))
  (cond ((= b 0) 0)
        ((= (remainder b 2) 0) (fast-mymultiply-recur (double a) (halve b)))
        (else (+ a (fast-mymultiply-recur (double a) (halve (- b 1)))))))
(define (fast-mymultiply-iter a b)
  (define (double n) (* n 2))
  (define (halve n) (/ n 2))
  (define (fast-mymultiply-iter-inner a b c)
    (cond ((= b 0) c)
          ((= (remainder b 2) 0) (fast-mymultiply-iter-inner (double a) (halve b) c))
          (else (fast-mymultiply-iter-inner (double a) (halve (- b 1)) (+ c a)))))
  (fast-mymultiply-iter-inner a b 0))
(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func 7 current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range mymultiply-recur 0 10)
(display "\n")
(for_range mymultiply-iter 0 10)
(display "\n")
(for_range fast-mymultiply-recur-simple 0 10)
(display "\n")
(for_range fast-mymultiply-recur 0 10)
(display "\n")
(for_range fast-mymultiply-iter 0 10)
(display "\n")
