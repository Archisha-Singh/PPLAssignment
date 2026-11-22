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
