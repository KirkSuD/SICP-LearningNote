#lang racket
;SICP ex1.11 Exponentiation: O(logn)-iterative

(define (fast-exp-iter b n) ;; time:O(logn) space:O(1)
  (define (even? n)
    (= (remainder n 2) 0))
  (define (fast-exp-iter-inner a b n) ;; a*b^n unchanged
    (cond ((= n 0) a)
          ((even? n) (fast-exp-iter-inner a (* b b) (/ n 2)))
          (else (fast-exp-iter-inner (* a b) (* b b) (/ (- n 1) 2)))))
  (fast-exp-iter-inner 1 b n))

(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func 2 current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range fast-exp-iter 0 10)
(display "\n")

