#lang racket
;;; SICP ex2.5 Church numerals

;; Church numerals
;; Implemented zero and adding one
;; Question: define one and two directly(without zero and 1+)
;;   by using substitution to eval (1+ zero);
;;   give a direct definition of adding operator +
;;   without auxiliary procedures.

(define zero
  (lambda (f)
    (lambda (x) x ) ) )

(define (1+ n)
  (lambda (f)
    (lambda (x) (f
                 ((n f) x) ) ) ) )

;; ans
(define one
  (lambda (f)
    (lambda (x) (f x) ) ) )
;; ans
(define two
  (lambda (f)
    (lambda (x) (f (f x) ) ) ) )
;; wrong-ans ;; found it wrong when seeing https://sicp.readthedocs.io/en/latest/chp2/6.html
(define (church-plus-wrong a b)
  (lambda (f)
    (lambda (x)
            (a (b x)) ) ) ) ;; wrong!!
;; ans
(define (church-plus a b) ;; correct
  (lambda (f)
    (lambda (x)
            ((a f) ((b f) x)) ) ) )
(church-plus two one)
(displayln "hey")

(define readthedocs ;; wrong!! ;; github issue: https://github.com/huangz1990/SICP-answers/issues/8
    (lambda (m)
        (lambda (n)
            (lambda (f)
                (lambda (x)
                    (m f (n f x)))))))
(readthedocs two one) ;; the expected number of arguments does not match the given number
;; zero is g(f) = (h(x)=x)
;; 1+(n) is g(f) = (h(x)=f( (n(f))(x) ))
;; one is 1+(zero) = (g(f) = (h(x)=f( (zero(f))(x) ) ) )
;;                 = (g(f) = (h(x)=f( (i(x)=x)(x) ) ) )
;;                 = (g(f) = (h(x)=f(x) ) )
;; two is 1+(one) = (g(f) = (h(x)=f( (one(f))(x) ) ) )
;;                = (g(f) = (h(x)=f( (h(x)=f(x))(x) ) ) )
;;                = (g(f) = (h(x)=f(f(x)) ) )
;; a+b is (g(f) = (h(x)=a(b(x)) ) )

;; one is (1+ zero) is (lambda (f) (lambda (x) (f x) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  ((zero
;;                    f) x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  (( (lambda (f) (lambda (x) x ))
;;                    f) x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  ( (lambda (x) x )
;;                    x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f x) ) )

;; two is (1+ one) is (lambda (f) (lambda (x) (f (f x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  ((one
;;                    f) x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  (( (lambda (f) (lambda (x) (f x) ) )
;;                    f) x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f
;;                  ( (lambda (x) (f x) ) x) ) ) )
;; -> (lambda (f)
;;     (lambda (x) (f (f x) ) ) )

