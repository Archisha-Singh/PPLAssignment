#lang racket/base

;; Return the number of top-level elements in lst.
(define (my-length lst)
  (let count-elements ([remaining lst]
                       [count 0])
    (if (null? remaining)
        count
        (count-elements (cdr remaining) (+ count 1)))))

;; Apply f once to each top-level element, preserving their order.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst)))))

;; Return a function that transforms every list whose length passes len-ok?.
(define (make-inserter x len-ok?)
  (lambda (lst)
    (let ([transformed
           (my-map
            (lambda (element)
              (if (or (pair? element) (null? element))
                  ((make-inserter x len-ok?) element)
                  element))
            lst)])
      (if (len-ok? (my-length lst))
          (cons x transformed)
          transformed))))

;; Insert x into each list whose original length is strictly less than n.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (original-length) (< original-length n))) lst))

;; Read x, lst, and n, then print the transformed list on one line.
(define (print-insert-result)
  (let ([x (read)]
        [lst (read)]
        [n (read)])
    (display (insert-if-short x lst n))
    (newline)))
