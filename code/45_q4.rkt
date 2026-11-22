#lang racket/base

;; Count the outer elements of lst, adding one per step along its spine.
(define (my-length lst)
  (let count-elements ([remaining lst]
                       [count 0])
    (if (null? remaining)
        count
        (count-elements (cdr remaining) (+ count 1)))))
