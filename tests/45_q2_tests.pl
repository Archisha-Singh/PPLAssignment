:- use_module(library(plunit)).
:- ensure_loaded('../code/45_q2.pl').

:- begin_tests(p2).

test(equation_split_three_elements) :-
    findall(Left-Right, equation_split([1, 2, 3], Left, Right), Splits),
    assertion(Splits == [[1]-[2, 3], [1, 2]-[3]]).

test(equation_split_two_elements) :-
    findall(Left-Right, equation_split([1, 2], Left, Right), Splits),
    assertion(Splits == [[1]-[2]]).

test(equation_split_empty_list, [fail]) :-
    equation_split([], _, _).

test(equation_split_singleton_list, [fail]) :-
    equation_split([1], _, _).

test(apply_operator_addition, true(Value == 7)) :-
    apply_operator('+', 3, 4, Value).

test(apply_operator_negative_subtraction, true(Value == -3)) :-
    apply_operator('-', 2, 5, Value).

test(apply_operator_multiplication, true(Value == 12)) :-
    apply_operator('*', 3, 4, Value).

test(apply_operator_exact_negative_division, true(Value == -4)) :-
    apply_operator('/', 12, -3, Value).

test(apply_operator_division_by_zero, [fail]) :-
    apply_operator('/', 12, 0, _).

test(apply_operator_division_with_remainder, [fail]) :-
    apply_operator('/', 7, 3, _).

test(expression_empty_list, [fail]) :-
    expression([], _, _).

test(expression_singleton) :-
    findall(Tree-Value, expression([7], Tree, Value), Expressions),
    assertion(Expressions == [7-7]).

test(expression_distinct_addition_trees, [forall(member(Expected, [
    op('+', op('+', 1, 2), 3),
    op('+', 1, op('+', 2, 3))
]))]) :-
    assertion(expression([1, 2, 3], Expected, 6)).

test(expression_exact_division) :-
    findall(Value, expression([8, 2], op('/', 8, 2), Value), Values),
    assertion(Values == [4]).

test(expression_division_with_remainder, [fail]) :-
    expression([7, 2], op('/', _, _), _).

test(expression_division_by_zero, [fail]) :-
    expression([8, 0], op('/', _, _), _).

test(render_expression_canonical_strings, [forall(member(Tree-Expected, [
    7-"7",
    op('*', op('+', 1, 2), 3)-"(1+2)*3",
    op('+', 1, op('*', 2, 3))-"1+2*3",
    op('+', op('+', 1, 2), 3)-"1+2+3",
    op('-', 1, op('-', 2, 3))-"1-(2-3)"
]))]) :-
    findall(Text, render_expression(Tree, Text, _), Texts),
    assertion(Texts == [Expected]).

:- end_tests(p2).
