#lang racket/base

;; Return the values of tree in left, root, right order.
(define (inorder tree)
  ;; Return the subtree's values followed by the given suffix.
  (define (walk subtree suffix)
    (if (null? subtree)
        suffix
        (walk (car (cdr subtree))
              (cons (car subtree)
                    (walk (car (cdr (cdr subtree))) suffix)))))
  (walk tree '()))

;; Print the inorder values on one line, including () for an empty tree.
(define (print-inorder tree)
  (display (inorder tree))
  (newline))

;; Return the values of tree in root, left, right order.
(define (preorder tree)
  ;; Collect values in reverse order while visiting each left subtree first.
  (define (walk subtree reversed-values)
    (if (null? subtree)
        reversed-values
        (walk (caddr subtree)
              (walk (cadr subtree)
                    (cons (car subtree) reversed-values)))))
  (let restore-order ((remaining (walk tree '())) (values '()))
    (if (null? remaining)
        values
        (restore-order (cdr remaining) (cons (car remaining) values)))))
