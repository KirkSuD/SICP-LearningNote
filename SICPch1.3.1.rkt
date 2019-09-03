#lang racket
;;; SICP ch1.3.1 ex1.23-1.27,1.29 function as parameter: (sum term a next b)

(define (filtered-accumulate combiner filter null-value term a next b)
  (define (accumulate-iter current res)
    (if (> current b)
        res
        (accumulate-iter
          (next current)
          (if (filter current)
              (combiner res (term current))
              res))))
  (accumulate-iter a null-value))

(define (filtered-accumulate-recur combiner filter null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a) 
          (combiner (term a)
                    (filtered-accumulate-recur combiner filter null-value term (next a) next b))
          (filtered-accumulate-recur combiner filter null-value term (next a) next b))))

(define (accumulate combiner null-value term a next b)
  (define (accumulate-iter current res)
    (if (> current b)
        res
        (accumulate-iter
          (next current)
          (combiner res (term current)))))
  (accumulate-iter a null-value))

(define (accumulate-recur combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate-recur combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (product-it term a next b)
  (define (product-iter current res)
    (if (> current b)
        res
        (product-iter (next current) (* res (term current)))))
  (product-iter a 1))

(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a)
         (product-recur term (next a) next b))))

;; P.55 ex1.24
(define (sum-it term a next b) ;; iterative-process sigma
  (define (sum-iter current res)
    (if (> current b)
        res
        (sum-iter (next current) (+ res (term current)))))
  (sum-iter a 0))

(define (sum-recur term a next b) ;; recursive-process sigma
  (if (> a b)
      0
      (+ (term a)
         (sum-recur term (next a) next b))))

(define (plus1 n) (+ 1 n))
(define (square n) (* n n))
(define (cube n) (* n n n))
(define (identity n) n)
(define (gcd a b) (if (= b 0) a (gcd b (remainder a b))))
(define (prime? n)
  (define (prime?-iter current)
    (if (> (square current) n)
        #t
        (if (= 0 (remainder n current))
            #f
            (prime?-iter (+ 2 current)))))
  (cond ((< n 2) #f)
        ((= n 2) #t)
        ((= 0 (remainder n 2)) #f)
        (else (prime?-iter 3))))

(define (sum-ints a b)
  (sum identity a plus1 b))

(define (sum-cubes a b)
  (sum cube a plus1 b))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1. (* x (+ x 2))))
  (define (pi-next x) (+ x 4))
  (* 8 (sum pi-term a pi-next b)))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2)) add-dx b) dx))

(define (integral-simpson f a b n)
  (define h (/ (- b a) n))
  (define (get-term k)
    (cond ((= k 0) (f a))
          ((= k n) (f b))
          ((= 1 (remainder k 2)) (* 4. (f (+ a (* k h)))))
          (else  (* 2. (f (+ a (* k h)))))))
  (* (/ h 3) (sum get-term 0 plus1 n)))

(define (factorial n)
  (if (= n 0) 1 (product identity 1 plus1 n)))

(define (pi-product n)
  (define (pi-term n)
    (/ (- (+ n 2.) (remainder n 2))
       (+ n 1. (remainder n 2))))
  (* 4 (product pi-term 1 plus1 n)))

(define (prime-square-sum a b)
  (filtered-accumulate + prime? 0 square a plus1 b))

(define (coprime-product n)
  (define (coprime? x) (= 1 (gcd x n)))
  (filtered-accumulate * coprime? 1 identity 1 plus1 n))

(define (for-range-filter func a b)
  (cond ((< a b) (cond ((func a) (display a) (display "\n")))
                 (for-range-filter func (+ 1 a) b))
        (else (display "for-range finished: ")
              (display func) (display ".\n"))))

;; P.67 ex1.29
(define (find-max f a b n)
  (accumulate max (f a) f a
    (lambda (current) (+ current (/ (- b a) n)))
    b ) )
  ;; (accumulate combiner null-value term a next b)

;; P.52
(display "sum:\n")
(sum-ints 1 100)
(sum-cubes 1 10)
(display "\n")

;; P.53
(display "pi sum:\n")
(pi-sum 1 1000)
(pi-sum 1 10000)
(pi-sum 1 100000)
(display "\n")

;; P.55 ex1.23
(display "integral cube:\n")
(integral cube 0 1 .01)
(integral-simpson cube 0 1 100)
(display "\n")

(display "integral cube higher precision:\n")
(integral cube 0 1 .001)
(integral-simpson cube 0 1 1000)
(display "\n")

;; P.56 ex1.25
(display "10!:\n")
(factorial 10)
(display "\n")

;; P.56 ex1.25
(display "pi:")
(pi-product 1000)
(pi-product 10000)
(pi-product 100000)

(display "\nThese are primes:\n")
(for-range-filter prime? -9 99)
(display "\n")

;; P.56 ex1.27
(prime-square-sum -9 99)
(coprime-product 30)

;; P.67 ex1.29
(find-max sin 0 3 100000)
