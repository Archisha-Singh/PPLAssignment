---
name: prolog-dev
description: Develop predicates in SWI-Prolog, check that the code loads correctly, and test and review its behavior.
---

# Prolog development

Use SWI-Prolog 9.x. Work on one predicate, one test file, or one review per prompt.

## Coding conventions

- Use descriptive predicate names and meaningful variable names.
- Describe when each predicate succeeds and which arguments should be supplied.
- Use only the permitted libraries: `lists`, `apply`, `yall`, and `aggregate`.
- Do not use `assert`, `retract`, or global variables such as `b_setval/2` and `nb_setval/2`.
- Omit initialization directives and calls to `halt/0` in submitted code.
- Keep submitted files silent on load. Print only the output specified by the assignment.

## Running and testing

Run P1 with:

    swipl -q -f code/45_q1.pl -g main -t halt

To test an individual predicate, pass its goal with `-g 'GOAL'` and select the corresponding `.pl` file with `-f`. Check the assignment examples and relevant edge cases. Report which tests were run and what they returned.

## Self-review before answering

- Check exact predicate names, argument counts, and output formats.
- Check that P1 clues use the specified atoms and that omitted clues are ignored.
- Check that P2 preserves input order and uses parentheses that preserve the expression tree.
- Check that every division has a nonzero divisor and an integer result.
- Check that `generate_equation/2` fails when no equation exists and that `all_equations/2` returns a sorted list of unique strings, or `[]` when none exist.

## Common AI mistakes

- Using an uppercase word as an atom without quoting it, such as `'AI'`.
- Checking inequality before the relevant variables are bound.
- Using floating-point division or allowing division with a remainder.
- Returning atoms instead of strings or printing extra debug output.
- Adding a cut that prevents valid answers from being found on backtracking.
