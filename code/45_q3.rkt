#lang racket/base

;; Return the node values in left–root–right order.
(define (inorder tree)
  ;; An empty subtree leaves the suffix unchanged.
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
  (let restore-order ((remaining (walk tree '()))
                      (values '()))
    (if (null? remaining)
        values
        (restore-order (cdr remaining) (cons (car remaining) values)))))

;; Return the values of tree in left, right, root order.
(define (postorder tree)
  ;; Accumulate both subtrees left first, then prepend the root value.
  (define (walk subtree reversed-values)
    (if (null? subtree)
        reversed-values
        (cons (car subtree)
              (walk (caddr subtree)
                    (walk (cadr subtree) reversed-values)))))
  (let restore-order ((remaining (walk tree '()))
                      (values '()))
    (if (null? remaining)
        values
        (restore-order (cdr remaining) (cons (car remaining) values)))))

;; Print inorder, preorder, and postorder on separate lines.
(define (print-all-traversals tree)
  (print-inorder tree)
  (display (preorder tree))
  (newline)
  (display (postorder tree))
  (newline))

;; An empty tree has height 0. A node adds one level to its taller subtree.
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1
         (max (tree-height (cadr tree))
              (tree-height (caddr tree))))))

;; An empty tree contributes zero, a leaf contributes one, and an internal
;; node contributes the sum of its subtree counts.
(define (leaf-count tree)
  (if (null? tree)
      0
      (let ((left (cadr tree))
            (right (caddr tree)))
        (if (and (null? left) (null? right))
            1
            (+ (leaf-count left) (leaf-count right))))))

;; Print the tree height and leaf count as a two-element list.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree) (leaf-count tree)))
  (newline))
