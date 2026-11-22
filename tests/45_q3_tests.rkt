#lang racket/base

(require rackunit
         racket/port
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

(define print-inorder
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'print-inorder)))

(check-equal? (with-output-to-string (lambda () (print-inorder '())))
              "()\n"
              "empty tree output")
(check-equal? (with-output-to-string
                (lambda () (print-inorder '(4 (2 () (3 () ())) (6 () ())))))
              "(2 3 4 6)\n"
              "tree with both subtrees output")

(define preorder
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'preorder)))

(check-equal? (preorder '()) '() "preorder empty tree")
(check-equal? (preorder '(7 () ())) '(7) "preorder single node")
(check-equal? (preorder '(4 (2 () (3 () ())) (6 () ())))
              '(4 2 3 6)
              "preorder tree with both subtrees")

(define postorder
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'postorder)))

(check-equal? (postorder '()) '() "postorder empty tree")
(check-equal? (postorder '(7 () ())) '(7) "postorder single node")
(check-equal? (postorder '(4 (2 () (3 () ())) (6 () ())))
              '(3 2 6 4)
              "postorder tree with both subtrees")

(define print-all-traversals
  (parameterize ([current-namespace (module->namespace solution-path)])
    (eval 'print-all-traversals)))

(check-equal? (with-output-to-string
                (lambda ()
                  (print-all-traversals '(4 (2 () (3 () ())) (6 () ())))))
              "(2 3 4 6)\n(4 2 3 6)\n(3 2 6 4)\n"
              "all traversals for a tree with both subtrees")
(check-equal? (with-output-to-string (lambda () (print-all-traversals '())))
              "()\n()\n()\n"
              "all traversals for an empty tree")
