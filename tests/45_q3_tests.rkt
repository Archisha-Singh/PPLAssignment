#lang racket/base

(require rackunit
         racket/runtime-path)

(define-runtime-path solution-path "../code/45_q3.rkt")
(dynamic-require solution-path #f)

(define inorder
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'inorder)))

(check-equal? (inorder '()) '() "empty tree")
(check-equal? (inorder '(7 () ())) '(7) "single node")
(check-equal? (inorder '(4 (2 () (3 () ())) (6 () ())))
              '(2 3 4 6)
              "tree with both subtrees")
