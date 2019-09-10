#lang racket
;;; SICP ex2.19 List operation: (square-list-iter) not working

;; ex2.19 P.94
(define (square-list x)
  (define (square n) (* n n))
  (define (iter list answer)
    (if (null? list)
        answer
        (iter (cdr list)
              (cons (square (car list)) ;; reversed: '(16 9 4 1)
                    answer )))) ;; swapping args doesn't help: '((((() . 1) . 4) . 9) . 16)
  (iter x '()))

(define 1-through-4 (list 1 2 3 4))
(square-list 1-through-4)

;; Why this doesn't work?
;; Because this "cdr then cons its car" action is first-in-last-out(reversed).
;; example: '(1 2 3) '() -> '(2 3) '(1) -> '(3) '(2 1) -> '() '(3 2 1)

;; Why swapping args doesn't work?
;; Swapping args only reverses the "pair tree", not the order.
;;     '(3 2 1)    ->  '(((() . 1) . 2) . 3)
;; 3 - *                        * - 3
;;     |                        |
;;     2 - *       ->       * - 2
;;         |                |
;;         1 - nil    nil - 1
