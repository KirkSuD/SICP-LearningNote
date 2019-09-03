#lang racket
;;; SICP ex1.32-1.33 Procedures as returned values, repeated application of function

(define (repeated f n) ;; Time: O(n) Space: O(1) (iterative)
  (define (repeated-iter current-func n)
    (if (= n 0)
        current-func
        (repeated-iter (lambda (n)
                               (f (current-func n)) )
                       (- n 1) ) ) )
  (repeated-iter f (- n 1)) )

(define (repeated-fast f n) ;; Time: O(logn) Space: O(1) (iterative)
  (define (identity n) n)
  (define (repeated-iter fa fb n) ;; Refer to SICPex1.11.rkt
    (cond ((= n 0) fa)
          ((= (remainder n 2) 0)
            (repeated-iter fa
              (lambda (n) (fb (fb n)))
              (/ n 2)))
          (else
            (repeated-iter (lambda (n) (fa (fb n)))
              (lambda (n) (fb (fb n)))
              (/ (- n 1) 2)))))
  (repeated-iter identity f n))

;; P.70 ex1.33
(define (smooth f dx)
  ;; (define dx 0.0001)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3) ) )
(define (smooth-nth f dx n)
  (repeated (smooth f dx) n))

(define (square n) (* n n))
(define (plus1 n) (+ n 1))

((repeated-fast square 2) 5)
((repeated square 2) 5)

((repeated-fast square 4) 5)
((repeated square 4) 5)

(display "\n")

;; See the difference of speed
(define plusBigFast (repeated-fast plus1 20000000))
(display plusBigFast) (display "\n")

(define plusBig (repeated plus1 20000000))
(display plusBig) (display "\n")

;; Also, the generated functions' speed differs, too.
(plusBigFast 0)
(plusBig 0)
