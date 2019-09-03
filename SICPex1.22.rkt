#lang racket
;;; SICP ex1.22 fermat-test-jacobi, cannot be fooled

(define (gcd a b)
  (if (= b 0) a (gcd b (remainder a b))))

(define (exp b e) ;; recursive process O(logn)
  (define (square n) (* n n))
  (cond ((= e 0) 1)
        ((= (remainder e 2) 0) (square (exp b (/ e 2))) )
        (else (* b (exp b (- e 1) ) ) )))

(define (fermat-test-jacobi n)
  (define (find-a)
    (define a (+ 1 (random (- n 1))))
    (if (= 1 (gcd a n)) a (find-a)))
  (define (jacobi a n) ;; f(a) = f(a/2) + const => O(logn)
    (define (exp-1 n)
      (if (= 0 (remainder n 2)) 1 -1))
    (cond ((= a 1) 1)
          ((= 0 (remainder a 2))
           (* (jacobi (/ a 2) n)
              (exp-1 (/ (- (* n n) 1) 8))))
          (else (* (jacobi (remainder n a) a)
                   (exp-1 (/ (* (- a 1) (- n 1)) 4))))
    )
  )
  (define a (find-a))
  (define (mymod a b)
    (if (< a 0) (+ (remainder a b) b) (remainder a b)))
  (= (mymod (jacobi a n) n) ;; in Racket, (remainder -1 2) is -1
     (remainder (exp a (/ (- n 1) 2)) n))
)

(define (fast-prime? n times)
  (cond ((< n 2) #f)
        ((= n 2) #t)
        ((= 0 (remainder n 2)) #f) ;; jacobi's n on the book should be odd
        ((= times 0) #t)
        ((fermat-test-jacobi n)
         (fast-prime? n (- times 1)))
        (else #f)))

(define (for-prime current finish)
  (cond ((< current finish)
         (cond ((fast-prime? current 100)
                (display current) (display "\n"))
               ;(else (display ""))
         )
         (for-prime (+ 1 current) finish))
        (else (display "for-prime finished."))
  )
)
;(fermat-test-jacobi 2)
(for-prime -9 99)