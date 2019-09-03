#lang racket
;SICP ex1.8 Ackermann's Function, a non-primitive recursive function

(define (ack x y) ; the Ackermann's Function
  (cond ((= x 0) (+ 1 y))
        ((= y 0) (ack (- x 1) 1))
        (else (ack (- x 1)
                 (ack x (- y 1))))))

(define (A x y) ; in SICP
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
(define (f n) (ack 0 n))
(define (g n) (ack 1 n))
(define (h n) (ack 2 n))
(define (k n) (* 5 n n))

(A 1 10)
(A 2 4)
(A 3 3)

(define (for_range func a b)
  (cond ((< a b) (display a) (display func) (display (func a)) (display "\n")
                 (for_range func (+ 1 a) b))
        (else (display "a>=b, terminated.\n\n"))))
(for_range f 1 10)
(for_range g 1 10)
(for_range h 1 5)
(for_range k 1 10)

#|
2 4
1 2 3
  1 2 2
    1 2 1
      2
    1 2
    4
  1 4
  16
1 16
65536

1 1 1 2
2**(2**(2**2))

3 3
2 3 2
  2 3 1
    2
  2 2
  1 2 1
    2
  1 2
  4
2 4

2 2 2
2 1 2
2 4
1 1 1 2

|#