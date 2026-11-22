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

(define insert-if-short
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'insert-if-short)))

(check-equal? (insert-if-short 'x '() 1) '(x) "insert into short empty list")
(check-equal? (insert-if-short 'x '() 0) '() "do not insert at threshold zero")
(check-equal? (insert-if-short 'x '(a () (b c)) 3)
              '(a (x) (x b c))
              "insert into short nested lists")
(check-equal? (insert-if-short 'x '((a) ()) 3)
              '(x (x a) (x))
              "insert at the outer and nested levels")

(define make-inserter
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'make-inserter)))

(check-equal? ((make-inserter 'x (lambda (length) (= length 2))) '((a b) ()))
              '(x (x a b) ())
              "insert where the list length equals two")
(check-equal? ((make-inserter 'x (lambda (length) (= length 0))) '(() a))
              '((x) a)
              "insert into empty nested lists")
