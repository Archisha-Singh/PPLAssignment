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

:- end_tests(p2).
