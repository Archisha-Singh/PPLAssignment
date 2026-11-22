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
