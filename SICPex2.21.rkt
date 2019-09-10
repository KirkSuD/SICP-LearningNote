#lang racket
;SICP ex2.21 (count-change) using list, modified from SICPch1.2.2.rkt

(define (count-change amount coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (null? coins)) 0)
        (else (+ (count-change (- amount (car coins)) coins)
                 (count-change amount (cdr coins))))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 .5))

(count-change 100 us-coins) ;; 292
(count-change 100 uk-coins) ;; 104561

;; The order of coins doesn't affect the answer
;; because its divide-and-conquer rule doesn't involve anything of orders,
;; nothing would be counted twice or missed.
;; Can be tested (but not proved) by rearrange the order of coins.
