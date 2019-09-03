#lang racket
;SICP ch1.2.4 Exponentiation: recursive, iterative, O(logn)-recursive

(define (exp-recur b n) ;; time:O(n) space:O(n)
  (if (= n 0)
      1
      (* b (exp-recur b (- n 1)))))
(define (exp-iter b n) ;; time:O(n) space:O(1)
  (define (exp-iter-inner counter product)
    (if (= counter 0)
        product
        (exp-iter-inner (- counter 1) (* b product))))
  (exp-iter-inner n 1))
(define (fast-exp-recur b n) ;; time:O(logn) space:O(logn)
  (define (even? n)
    (= (remainder n 2) 0))
  (define (square x) (* x x))
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp-recur b (/ n 2))))
        (else (* b (fast-exp-recur b (- n 1))))))
(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func 2 current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range exp-recur 0 10)
(for_range exp-iter 0 10)
(for_range fast-exp-recur 0 10)
