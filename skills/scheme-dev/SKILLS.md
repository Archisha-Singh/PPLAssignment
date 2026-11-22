---
name: scheme-dev
description: Develop, test, and review Scheme functions for PPL Assignment 2 using Racket 8.x.
---

# Scheme development

Use Racket 8.x with `#lang racket/base`. Work on one function, one test file, or one review per prompt.

## Coding conventions

- Use descriptive names. Adhere to the rules of naming (lowercase, dashes).
- Explain what each function takes, what it returns or prints, and how its base case and recursive step work.
- Check every built-in against the assignment's allowlist. Use `read` only for S2. Write your own helpers where needed.
- Pass state through function arguments. Keep submitted files silent when loaded and put test calls in separate test files.

## Running and testing

Run `racket code/45_q3.rkt` or`racket code/45_q4.rkt` to check that the file loads silently.
Test the function separately with the assignment examples and a relevant edge case. Report which tests ran and their results. If a test fails to run, highlight the issue.

## Self-review before answering

- Check the exact function names, arguments, output order, and newlines.
- For S1, check traversal order and test empty, single-node, and one-sided trees.
- For S2, check the original length of each list, including the outer list and empty sublists. Test a length equal to the threshold.
- Check that the final `insert-if-short` has one definition and uses `make-inserter`.

## Common AI mistakes

- Using forbidden built-ins such as `length`, `map`, `append`, or `reverse`.
- Applying `car` or `cdr` before checking for an empty list.
- Treating a sublist's contents as separate elements of its parent.
- Measuring a list after inserting an element or skipping the outer list.
- Leaving test calls or extra output in a submitted file.



