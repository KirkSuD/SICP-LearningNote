#lang racket
;SICP ex2.27 Tree operation: data abstract: binary mobile

;; ex2.27 P.99
;; a binary mobile is a list of left branch and right branch
(define (make-mobile left right)
  (list left right)) ;; Part d. use (cons)
;; a branch is a list of length(number) and
;;  structure(number(weight) or another mobile)
(define (make-branch length structure)
  (list length structure)) ;; cons

;; Part a. selectors
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile)) ;; cdr if using (cons) when making
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch)) ;; cdr if using (cons) when making

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

;; Part b. (total-weight)
(define (total-weight mobile)
  (if (atom? mobile)
      mobile
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))) ) ) )

;; Part c. (balanced?)
(define (balanced? mobile)
  (if (atom? mobile)
      #t
      (let ( (left  (branch-structure (left-branch  mobile)))
             (right (branch-structure (right-branch mobile))) )
           (and (= (* (total-weight left)
                      (branch-length (left-branch mobile)))
                   (* (total-weight right)
                      (branch-length (right-branch mobile))) )
                (balanced? left)
                (balanced? right) ))))

;; Test
(define mob1 (make-mobile (make-branch 10 25)
                          (make-branch 5 50)))
(left-branch mob1) ;; '(10 25)
(right-branch mob1) ;; '(5 50)
(branch-length (right-branch mob1)) ;; 5
(branch-structure (right-branch mob1)) ;; 50

(define mob2 (make-mobile (make-branch 10 25)
                          (make-branch 5 mob1)))
(left-branch mob2) ;; '(10 25)
(right-branch mob2) ;; '(5 ((10 25) (5 50)))
(branch-length (right-branch mob2)) ;; 5
(branch-structure (right-branch mob2)) ;; '((10 25) (5 50))

(total-weight mob1) ;; 75
(total-weight mob2) ;; 100

(balanced? mob1) ;; #t
(balanced? mob2) ;; #f
(balanced? (make-mobile (make-branch 15 25)
                        (make-branch 5 mob1))) ;; #t
