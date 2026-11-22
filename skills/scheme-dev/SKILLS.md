---
name: scheme-dev
description: Develop, test, and review Scheme functions for PPL Assignment 2 using Racket 8.x.
---

# Scheme development

Use Racket 8.x with `#lang racket/base`. Work on one function, one test file, or one review per prompt.

## Coding conventions

- Use descriptive names. Adhere to the rules of naming (lowercase, dashes).
- Explain what each function takes, what it returns or prints, and how its base case and recursive step work.
- Pass state through function arguments. Keep submitted files silent when loaded and put test calls in separate test files.

## Built-in allowlist for S1 and S2

- Forms: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` with `else`, `and`, `or`, `not`, `begin`, and quote written as `'`.
- Lists and predicates: `cons`, `car`, `cdr`, `list`, all `car`/`cdr` compositions through four levels, `null?`, `pair?`, `eq?`, `assq`, and `assoc`.
- Numbers and output: `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`, `display`, and `newline`. Only S2 may use `read`.
- Use only these forms and built-ins in submission code. Implement required list helpers yourself. Mutation, vectors, hash tables, strings, `do`, `for`, and built-in `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, and `list-tail` are forbidden.

## S2 nested-list insertion

- In `code/45_q4.rkt`, implement `my-length`, `my-map`, `make-inserter`, `insert-if-short`, and `print-insert-result`.
- `make-inserter` takes an atom `x` and a unary length predicate `len-ok?` and returns a unary list transformer. Use `my-length` to measure the original list and `my-map` to transform its sublists while preserving element order. Each sublist occupies one element of its parent. Keep original atoms unchanged and do not revisit inserted atoms.
- Apply the predicate to every list, including the outer list and empty sublists. An element is a sublist if it is a pair or `null?`, since inputs contain no dotted pairs.
- Define `insert-if-short` once, using `make-inserter` with a predicate that compares the original length strictly below `n`. `n` is a nonnegative integer, so `n = 0` leaves all lists unchanged.
- `print-insert-result` takes no arguments. Read `x`, `lst`, and `n` in that order from standard input, then use `display` and `newline` to print only the resulting list.
- Test both nested assignment examples, empty outer lists at positive and zero thresholds, a list whose length equals the threshold, and a length predicate other than `< n`. Check depth 100 and lists of 10,000 elements. Avoid repeatedly scanning the same list spine.

## Running and testing

Run `racket code/45_q3.rkt` or `racket code/45_q4.rkt` to check that the file loads silently.
Test the function separately with the assignment examples and a relevant edge case. Report which tests ran and their results. If a test fails to run, highlight the issue.

## Self-review before answering

- Check the exact function names, arguments, output order, and newlines.
- For S1, check traversal order and test empty, single-node, and one-sided trees.

## Common AI mistakes

- Using forbidden built-ins such as `length`, `map`, `append`, or `reverse`.
- Applying `car` or `cdr` before checking for an empty list.
- Treating a sublist's contents as separate elements of its parent.
- Measuring a list after inserting an element or skipping the outer list.
- Leaving test calls or extra output in a submitted file.



