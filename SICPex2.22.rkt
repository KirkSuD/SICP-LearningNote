#lang racket
;SICP ex2.22 (list 1 (list 2 (list 3 4)))

(cons 1 (cons 2 (cons 3 4))) ;; '(1 2 3 . 4)
(list 1 (list 2 (list 3 4))) ;; '(1 (2 (3 4)))

;; Box-and-pointer

;; **-**-**
;; 1  2  34

;; **-*/
;; 1  |
;;    **-*/
;;    2  |
;;       **-*/
;;       3  4

;; Tree

;; |
;; ---
;; | |
;; 1 ---
;;   | |
;;   2 ---
;;     | |
;;     3 4

;; Github issue: https://github.com/huangz1990/SICP-answers/issues/35
;; Image: http://jots-jottings.blogspot.com/2011/09/sicp-exercise-224-lists-boxes-pointers.html
