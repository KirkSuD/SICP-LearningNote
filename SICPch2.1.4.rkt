#lang racket
;;; SICP ch2.1.4 Interval Arithmetic, an example of Data Abstraction

;; ch2.1.4 P.85-86
(define (intadd x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y)) ) )
(define (intmul-basic x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))) )
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4) ) ) )
;; ex2.9 P.86
;; 00 [+a, +b] * [+c, +d] = [ ac,  bd] ;; a < b, c < d ;; ac < ? < bd
;; 01 [+a, +b] * [-c, +d] = [-bc,  bd] ;; a < b, c ? d ;; -bc < -ac, ad < bd
;; 02 [+a, +b] * [-c, -d] = [-bc, -ad] ;; a < b, c > d ;; -bc < ? < -ad
;; 10 [-a, +b] * [+c, +d] = [-ad,  bd]
;; 11 [-a, +b] * [-c, +d] = [min(-ad,-bc), max(ac,bd)]  ;; a ? b, c ? d ;; -ad ? -bc, ac ? bd
;; 12 [-a, +b] * [-c, -d] = [-bc,  ac] ;; a ? b, c > d ;; -bc < -bd, ad < ac
;; 20 [-a, -b] * [+c, +d] = [-ad, -bc]
;; 21 [-a, -b] * [-c, +d] = [-ad,  ac]
;; 22 [-a, -b] * [-c, -d] = [ bd,  ac] ;; a > b, c > d ;; bd < ? < ac
(define (intmul x y) ;; ans
  (define neg (- 1))
  (define (inttype x)
    (cond ((and (>= (lower-bound x) 0) (>= (upper-bound x) 0)) 0)
          ((and (< (lower-bound x) 0) (>= (upper-bound x) 0)) 1)
          ((and (< (lower-bound x) 0) (< (upper-bound x) 0)) 2) ) )
  (let ((a (lower-bound x)) (b (upper-bound x))
        (c (lower-bound y)) (d (upper-bound y)) )
       (cond ((and (= (inttype x) 0) (= (inttype y) 0))
              (make-interval (* a c) (* b d)))
             ((and (= (inttype x) 0) (= (inttype y) 1))
              (make-interval (* neg b c) (* b d)))
             ((and (= (inttype x) 0) (= (inttype y) 2))
              (make-interval (* neg b c) (* neg a d)))
             ((and (= (inttype x) 1) (= (inttype y) 0))
              (make-interval (* neg a d) (* b d)))
             ((and (= (inttype x) 1) (= (inttype y) 1))
              (make-interval (min (* neg a d) (* neg b c))
                             (max (* a c) (* b d)) ) ) ;; !!
             ((and (= (inttype x) 1) (= (inttype y) 2))
              (make-interval (* neg b c) (* a c)))
             ((and (= (inttype x) 2) (= (inttype y) 0))
              (make-interval (* neg a d) (* neg b c)))
             ((and (= (inttype x) 2) (= (inttype y) 1))
              (make-interval (* neg a d) (* a c)))
             ((and (= (inttype x) 2) (= (inttype y) 2))
              (make-interval (* b d) (* a c))) ) ) )
(define (intdiv x y)
  (if (or (and (< (lower-bound y) 0) (< (upper-bound y) 0))
          (and (> (lower-bound y) 0) (> (upper-bound y) 0)) )
      (intmul x
              (make-interval (/ 1 (upper-bound y))
                             (/ 1 (lower-bound y)) ) )
      (error "ZeroDivisionError: (intdiv) division by an interval containing zero:"
             y) ) ) ;; ex2.9 P.86 ;; ans

;; ex2.6 P.86
(define (make-interval a b) (cons a b))
(define (upper-bound n) (cdr n)) ;; ans
(define (lower-bound n) (car n)) ;; ans

;; ex2.7 P.86
(define (intsub x y) ;; ans
  (intadd x (make-interval (- (upper-bound y)) (- (lower-bound y))) ) )

;; ex2.8 P.86
;; interval: [a, b] + [c, d] = [a+c, b+d]
;; width:     b-a   +  d-c   = (b+d)-(a+c)
;; interval: [a, b] - [c, d] = [a-d, b-c]
;; width:     b-a   +  d-c   = (b-c)-(a-d) = (b+(-c))-(a+(-d))
;; interval: [a, b] * [c, d] = [min, max]
;; width:     b-a      d-c   =  max-min (irrelevant to width)
;; interval: [a, b] / [c, d] = [a, b] * [1/d, 1/c] = [min, max]
;; width:     b-a      d-c   =                     =  max-min
(define (int-print n)
  (display "[")
  (display (lower-bound n))
  (display ", ")
  (display (upper-bound n))
  (display "]") )
;; this shows the width of multiplication/division of
;; intervals of different width can be the same
; (int-print (intmul (make-interval -1 1) (make-interval 0 1)))
; (int-print (intmul (make-interval -1 1) (make-interval -1 1)))
; (newline)
; (int-print (intdiv (make-interval -1 1) (make-interval -1 1)))
; (int-print (intdiv (make-interval -1 1) (make-interval -2 1)))

;; ch2.1.4 P.87
(define (center-width c w) ;; another constructor using center and width of interval
  (make-interval (- c w) (+ c w)))
(define (center i) ;; calculate the center of an interval
  (/ (+ (lower-bound i) (upper-bound i)) 2) )
(define (width i) ;; calculate the width of an interval
  (/ (- (upper-bound i) (lower-bound i)) 2) )

;; ex2.11 P.87 ;; another constructor using center and percent of interval
(define (make-center-percent c p) ;; ans
  (center-width c (* c p)) )
(define (percent i) ;; ans
  (/ (width i) (center i)))

;; ex2.12 P.87
;; Interval:   [c1-c1p1, c1+c1p1] * [c2-c2p2, c2+c2p2]
;;          -> [c1c2-c1c2p2-c1c2p1+c1c2p1p2, c1c2+c1c2p2+c1c2p1+c1c2p1p2]
;; Width:      c1p1 * c2p2
;;          -> c1c2(p1+p2)
;; Center:     c1 * c2
;;          -> c1c2+c1c2p1p2 = c1c2(1+p1p2)
;; Percentage: p1 * p2
;;          -> c1c2(p1+p2) / c1c2(1+p1p2) (width/center)
;;           = p1+p2 / 1+p1p2 (Since p1,p2 ~= 0, p1p2 ~= 0)
;;          ~= p1+p2 / 1
;; Ans: p ~= p1+p2 ;; http://cdfrag.cs31415.com/sicp-exercise-2-13/

;; ch2.1.4 P.88
(define (par1 r1 r2)
  (intdiv (intmul r1 r2)
          (intadd r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
       (intdiv one
               (intadd (intdiv one r1)
                       (intdiv one r2) ) ) ) )

;; ex2.13 P.88
(define inta (make-interval 1 1)) ;; (make-center-percent 5 .002)) ;; A
(define intb (make-center-percent 8 .001));; (make-interval 3 4)) ;; B
(define intc (intdiv inta inta))  ;; C=A/A
(define intd (intdiv inta intb))  ;; D=A/B
(define inte (par1 inta intb))
(define intf (par2 inta intb))

(define (int-print-cp n) ;; print an interval in "(center, percent)" form
  (display "(")
  (display (center n))
  (display ", ")
  (display (percent n))
  (display ")") )
(define (int-print-both n) ;; print [lower, upper] then (center, percent) then (newline)
  (int-print n) (display " ") (int-print-cp n) (newline) )

(display "A:        ") (int-print-both inta)
(display "B:        ") (int-print-both intb)
(display "C = A/A:  ") (int-print-both intc)
(display "D = A/B:  ") (int-print-both intd)
(display "E = par1: ") (int-print-both inte)
(display "F = par2: ") (int-print-both intf)

;; ex2.13-2.15 P.88
;; https://blog.csdn.net/zb1030415419/article/details/51397731
;; [a,b] * [c,d] = [ac, bd]
;; [a,b] / [c,d] = [a, b] * [1/d, 1/c] = [a/d, b/c]
;; [a,b] / [a,b] = [a/b, b/a] != [1, 1]
;; [a,b] - [a,b] = [a-b, b-a] != [0, 0]
;; 
;; r1 = [a, b], r2 = [c, d]
;; par1: r1*r2/(r1+r2) = [ac, bd]/[a+c,b+d] = [ac/(a+c), bd/(b+d)]
;; par2: 1 / (1/r1 + 1/r2) = [1,1] / [1/b+1/d, 1/a+1/c]
;; = [bd/(b+d), ac/(a+c)] ;; correct, run a visualization by PIL_visualize2d.py
;; 
;; A = [c-cp, c+cp]
;; A/A = [(c-cp)/(c+cp), (c+cp)/(c-cp)] != [1,1]
;; A/A's center = (1+p^2) / (1-p^2)
;;        width = 2p / (c^2*(1-p^2))
;; Because of A/A != [1,1],
;; and the choose of different lower/upper-bound of r1, r2
;; in r1*r2/(r1+r2), the equivalent algebraic expressions lead to different answers.
;; 
;; https://wiki.drewhess.com/wiki/SICP_exercise_2.16
;; Not sure if it is possible to implement an interval arithmetic package
;; that follows the rules of number arithmetic.
;; I personally think it is nearly impossible.
;; Or a symbolic algebra system should be implemented.
;; Then calculate the min/max of the given formula.
;; For example, what if you write something whose value is not linear?
;; For example, an interval's square? int * int is not the answer.
;; So an algebra system must be implemented to describe x^2 and then calculate,
;; find the min/max in the given domain.
