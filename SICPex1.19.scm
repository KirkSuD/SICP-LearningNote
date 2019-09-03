;#lang racket
;;; SICP ex1.19 prime test with fast-prime (similar to ch1.2.6)

(define (square n) (* n n))

(define (smallest-divisor n)
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (define (find-divisor current-test)
    (cond ((> (square current-test) n) n)
          ((= (remainder n current-test) 0) current-test)
          (else (find-divisor (next current-test)))))
  (find-divisor 2))

(define (prime? n)
  (if (< n 2) #f (= n (smallest-divisor n)))) ;; nil is not in Scheme anymore, using #f in racket

(define (expmod b e m)
  (cond ((= e 0) 1)
        ((= (remainder e 2) 0) (remainder (square (expmod b (/ e 2) m)) m))
        (else (remainder (* b (expmod b (- e 1) m)) m))))

(define (fermat-test n)
  (define a (+ 2 (random (- n 2)))) ;; 0~n-3 -> 2~n-1
  (= (expmod a n n) a))

(define (fast-prime? n times)
  (cond ((< n 2) #f)
        ((= n 2) #t) ;; (random (- 2 2)) is an error
        ((= times 0) #t) ;; t is not working, using #t in racket
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f) ;; if is prime, pass fermat-test -> if not pass, not a prime
        ))

#;(define (print-prime prime-check-func current end)
  (cond ((< current end) (prime-check-func current)
                         ;(cond ((prime-check-func current) (display current) (display "\n")) (else (display "")))
                         (print-prime prime-check-func (+ 1 current) end))
        (else (display "print-prime finished.\n"))))

(define (timed-prime-test n prime-test-func)
  (define start-time (real-time-clock)) ;; (runtime) is not in racket
  (define found-prime? (prime-test-func n 100))
  (define elapsed-time (- (real-time-clock) start-time))
  (cond (found-prime? (display n) (display " t:") (display elapsed-time) (display "\n")))
  0) ;; return something for find-larger-prime

(define (search-for-primes prime-test-func current rest)
  (define (next-odd n)
    (if (= (remainder n 2) 0) (+ n 1) (+ n 2)))
  (cond ((> rest 0) (cond ((prime-test-func (next-odd current) 100)
                           (timed-prime-test (next-odd current) prime-test-func)
                           (search-for-primes prime-test-func (next-odd current) (- rest 1)))
                          (else (search-for-primes prime-test-func (next-odd current) rest))))
        (else (display "find-larger-prime finished.\n"))))

(define (main)
  ;(print-prime timed-prime-test -10 100)
  ;(print-prime fast-prime? -10 100)
  (smallest-divisor 199)
  (smallest-divisor 1999)
  (smallest-divisor 19999)
  (search-for-primes fast-prime? 1000 3)
  (search-for-primes fast-prime? 10000 3)
  (search-for-primes fast-prime? 100000 3)
  (search-for-primes fast-prime? 1000000 3)
  (search-for-primes fast-prime? 10000000 3)
  (search-for-primes fast-prime? 100000000 3)
  0
)
