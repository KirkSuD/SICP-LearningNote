#lang racket
;SICP ch1.2.2 Fib, fib-iter, recursive(divide-and-conquer) count-change

(define (fib-recur n)
  (if (> n 1) (+ (fib-recur (- n 1)) (fib-recur (- n 2))) n))
(define (fib n)
  (define (fib-iter a b current)
    (if (= current n)
        a
        (fib-iter b (+ a b) (+ current 1))))
  (fib-iter 0 1 0))
(define (count-change amount)
  (define (count-change-recur amount current-coin)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (< current-coin 0)) 0)
          (else (+ (count-change-recur (- amount (coin-list current-coin)) current-coin)
                   (count-change-recur amount (- current-coin 1))))))
  (define (coin-list coin-index)
    (cond ((= coin-index 0) 1)
          ((= coin-index 1) 5)
          ((= coin-index 2) 10)
          ((= coin-index 3) 25)
          ((= coin-index 4) 50)))
  (count-change-recur amount 4))


(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range fib-recur 0 10)
(for_range fib 0 10)
(for_range count-change 0 101)
