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

:- end_tests(p2).
