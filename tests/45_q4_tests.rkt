#lang racket/base

(require rackunit
         racket/port
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

(define print-insert-result
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'print-insert-result)))

(check-equal? (with-input-from-string "7 () 3"
                (lambda () (with-output-to-string print-insert-result)))
              "(7)\n"
              "input produces insertion into the empty list")
(check-equal? (with-input-from-string "7 () 0"
                (lambda () (with-output-to-string print-insert-result)))
              "()\n"
              "input with zero threshold leaves the list empty")
(check-equal? (with-input-from-string "42 ((1 2) (3 4 5) (6) ()) 3"
                (lambda () (with-output-to-string print-insert-result)))
              "((42 1 2) (3 4 5) (42 6) (42))\n"
              "input transforms nested lists and outer list")
(check-equal? (with-input-from-string "0 (((1) 2) (3) ((4 5 6) ())) 3"
                (lambda () (with-output-to-string print-insert-result)))
              "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n"
              "input transforms multiple nesting levels")

(define (nest-empty depth)
  (if (= depth 0)
      '()
      (list (nest-empty (- depth 1)))))

(define (check-innermost-inserted tree depth)
  (if (= depth 0)
      (check-equal? tree '(x) "innermost empty list receives insertion")
      (check-innermost-inserted (car tree) (- depth 1))))

(check-innermost-inserted (insert-if-short 'x (nest-empty 100) 1) 100)

(define (make-sequence start end)
  (if (= start end)
      '()
      (cons start (make-sequence (+ start 1) end))))

(check-equal? (insert-if-short 'x (make-sequence 0 10000) 10001)
              (cons 'x (make-sequence 0 10000))
              "prepend to 10000 elements and preserve their order")
