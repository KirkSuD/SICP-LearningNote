#lang racket
;;; SICP ch2.2.1 List operations: (nth), (length), (append)

;; ch2.2.1 P.90
(define 1-through-3
  (cons 1
        (cons 2
              (cons 3 '())))) ;; nil: unbound identifier
;; https://stackoverflow.com/questions/9115703/null-value-in-mit-scheme
;; https://stackoverflow.com/questions/43026963/drracket-v6-8-nil-unbound
1-through-3
(newline)

;; ch2.2.1 P.91
(define 1-through-4 (list 1 2 3 4))
1-through-4
(car 1-through-4)
(cdr 1-through-4)
(car (cdr 1-through-4))
(cons 10 1-through-4)
(newline)

;; ch2.2.1 P.92
(define (nth n x)
  (if (= n 0)
      (car x)
      (nth (- n 1) (cdr x))))

(define squares (list 1 4 9 16 25))
(nth 3 squares)
(newline)

;; ch2.2.1 P.92
(define (length-recur x)
  (if (null? x)
      0
      (+ 1 (length (cdr x)))))

(define odds (list 1 3 5 7))
(length-recur odds)

;; ch2.2.1 P.93
(define (length-my x)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter x 0))
(length-my odds)
(newline)

;; ch2.2.1 P.93
(define (append x y)
  (if (null? x)
      y
      (cons (car x)
            (append (cdr x) y))))
(append squares odds)
(append odds squares)
