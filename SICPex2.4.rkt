#lang racket
;;; SICP ex2.4 Implement nonnegative int pairs using 2^a*3^b

(define (myexp b m)
  (define (myexp-iter a b m)
    (cond ((= m 0) a)
          ((= (remainder m 2) 0) (myexp-iter a (* b b) (/ m 2)) )
          (else (myexp-iter (* a b) (* b b) (/ (- m 1) 2)) ) ) )
  (myexp-iter 1 b m) )

(define (mylog b n) ;; O(n) linear iterative
  (define (mylog-iter b n res)
    (if (= (remainder n b) 0) (mylog-iter b (/ n b) (+ res 1)) res) )
  (mylog-iter b n 0))

(define (mylog-fast b n) ;; O(logn*logn)??? iterative ;; may be improvable
  (define (mylog-iter n a res an)
    ;; n*a*b^res unchanged (a = b^an)
    (cond ((= a 1) (if (= (remainder n b) 0)
                       (mylog-iter (/ n b) b res 1) res))
          ((= (remainder n a) 0) (mylog-iter (/ n a) (* a a) res (* an 2)))
          (else (mylog-iter n 1 (+ res an) 0)) ) )
  (mylog-iter n 1 0 0) )

(define (mycons x y)
  (* (myexp 2 x) (myexp 3 y)) )

(define (mycar z)
  (mylog 2 z) )

(define (mycdr z)
  (mylog 3 z) )

(define mypair (mycons 50000 70000))
; (displayln mypair)
(displayln (mycar mypair))
(displayln (mycdr mypair))
