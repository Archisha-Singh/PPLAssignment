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

;; Return a list transformer that inserts x when len-ok? accepts its length.
(define (make-inserter x len-ok?)
  (lambda (lst)
    (let ((transformed
           (my-map
            (lambda (element)
              (if (or (pair? element) (null? element))
                  ((make-inserter x len-ok?) element)
                  element))
            lst)))
      (if (len-ok? (my-length lst))
          (cons x transformed)
          transformed))))

;; Insert x into every list whose original outer length is less than n.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (original-length) (< original-length n))) lst))
