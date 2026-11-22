#lang racket/base

;; Count the outer elements of lst, adding one per step along its spine.
(define (my-length lst)
  (let count-elements ([remaining lst]
                       [count 0])
    (if (null? remaining)
        count
        (count-elements (cdr remaining) (+ count 1)))))

;; Apply f to each outer element of lst, preserving order.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst)))))
