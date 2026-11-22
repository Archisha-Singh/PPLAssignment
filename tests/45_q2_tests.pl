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

test(generate_equation_single_result) :-
    findall(Equation, generate_equation([2, 4, 8], Equation), Equations),
    assertion(Equations == ["2*4=8"]).

test(generate_equation_expected_result_on_backtracking) :-
    findall(Equation, generate_equation([4, 2, 5, 3], Equation), Equations),
    assertion(memberchk("4*2=5+3", Equations)).

test(generate_equation_empty_list, [fail]) :-
    generate_equation([], _).

test(generate_equation_singleton_list, [fail]) :-
    generate_equation([7], _).

test(generate_equation_no_solution, [fail]) :-
    generate_equation([2, 3, 4], _).

test(all_equations_sorted_results, true(Equations == [
    "4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
    "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"
])) :-
    all_equations([4, 2, 5, 3], Equations).

test(all_equations_single_result, true(Equations == ["2*4=8"])) :-
    all_equations([2, 4, 8], Equations).

test(all_equations_no_solution, true(Equations == [])) :-
    all_equations([2, 3, 4], Equations).

test(count_equations_expected_totals, [forall(member(Numbers-Expected, [
    [4, 2, 5, 3]-7,
    [2, 4, 8]-1,
    [2, 3, 4]-0
]))]) :-
    count_equations(Numbers, Count),
    assertion(Count == Expected).

:- end_tests(p2).
