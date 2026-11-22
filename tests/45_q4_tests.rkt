#lang racket/base

(require rackunit
         racket/runtime-path)

(define-runtime-path solution-path "../code/45_q4.rkt")
(dynamic-require solution-path #f)

(define my-length
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'my-length)))

(check-equal? (my-length '()) 0 "empty list")
(check-equal? (my-length '(a b c)) 3 "flat list")
(check-equal? (my-length '(a (b c) ())) 3 "sublists count as one element each")

(define my-map
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'my-map)))

(check-equal? (my-map (lambda (item) item) '()) '() "map over empty list")
(check-equal? (my-map (lambda (number) (+ number 1)) '(1 2 3))
              '(2 3 4)
              "map increments values in order")
(check-equal? (my-map my-length '((a b) () (c)))
              '(2 0 1)
              "map treats nested lists as single elements")
