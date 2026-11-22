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

;; Recursively transform each original sublist, then insert x when its
;; original outer length is less than n.
(define (insert-if-short x lst n)
  (let ((transformed
         (my-map
          (lambda (element)
            (if (or (pair? element) (null? element))
                (insert-if-short x element n)
                element))
          lst)))
    (if (< (my-length lst) n)
        (cons x transformed)
        transformed)))
