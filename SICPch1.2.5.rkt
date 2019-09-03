#lang racket
;;; SICP ch1.2.5 Euclid's Algorithm (GCD)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (for_range func current end)
  (cond ((< current end) (display current) (display func) (display (func 6 current)) (display "\n")
                         (for_range func (+ 1 current) end))
        (else (display "for_range finished.\n"))))
(for_range gcd 0 100)
