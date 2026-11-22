:- use_module(library(lists), [append/3]).

% Expression generation and evaluation

% equation_split(+Numbers, ?Left, ?Right) enumerates splits into a nonempty
% prefix and suffix, starting with the shortest prefix.
equation_split(Numbers, Left, Right) :-
    Left = [_|_],
    append(Left, Right, Numbers),
    Right = [_|_].

% apply_operator(+Op, +Left, +Right, ?Value) evaluates integer operands.
% Division fails for a zero divisor or a nonzero remainder.
apply_operator('+', Left, Right, Value) :-
    Value is Left + Right.

apply_operator('-', Left, Right, Value) :-
    Value is Left - Right.

apply_operator('*', Left, Right, Value) :-
    Value is Left * Right.

apply_operator('/', Left, Right, Value) :-
    Right =\= 0,
    0 =:= Left rem Right,
    Value is Left // Right.

% expression(+Numbers, ?Tree, ?Value) enumerates expression trees in input
% order and evaluates each tree. A singleton becomes an integer leaf.
expression([Number], Number, Number).

expression(Numbers, op(Operator, LeftTree, RightTree), Value) :-
    equation_split(Numbers, Left, Right),
    expression(Left, LeftTree, LeftValue),
    expression(Right, RightTree, RightValue),
    apply_operator(Operator, LeftValue, RightValue, Value).

% Canonical rendering

% render_expression(+Tree, ?Text, ?Precedence) produces a canonical string.
% Precedence is 1 for + and -, 2 for * and /, and 3 for integer leaves.
% Right operands of equal precedence need parentheses because operators
% associate to the left.
render_expression(Number, Text, 3) :-
    integer(Number),
    format(string(Text), '~d', [Number]).

render_expression(op(Operator, LeftTree, RightTree), Text, Precedence) :-
    (   memberchk(Operator, ['+', '-'])
    ->  Precedence = 1
    ;   memberchk(Operator, ['*', '/']),
        Precedence = 2
    ),
    render_expression(LeftTree, LeftText, LeftPrecedence),
    render_expression(RightTree, RightText, RightPrecedence),
    (   LeftPrecedence < Precedence
    ->  format(string(LeftOperand), '(~s)', [LeftText])
    ;   LeftOperand = LeftText
    ),
    (   RightPrecedence =< Precedence
    ->  format(string(RightOperand), '(~s)', [RightText])
    ;   RightOperand = RightText
    ),
    format(
        string(Text),
        '~s~a~s',
        [LeftOperand, Operator, RightOperand]
    ).

% Equation queries

% generate_equation(+Numbers, ?Equation) renders each split whose left and
% right expression trees evaluate to the same integer.
generate_equation(Numbers, Equation) :-
    equation_split(Numbers, Left, Right),
    expression(Left, LeftTree, Value),
    expression(Right, RightTree, Value),
    render_expression(LeftTree, LeftText, _),
    render_expression(RightTree, RightText, _),
    format(string(Equation), '~s=~s', [LeftText, RightText]).

% all_equations(+Numbers, ?Equations) returns sorted, unique equation strings.
all_equations(Numbers, Equations) :-
    findall(Equation, generate_equation(Numbers, Equation), Generated),
    sort(Generated, Equations).

% count_equations(+Numbers, ?N) counts distinct equation strings.
count_equations(Numbers, N) :-
    all_equations(Numbers, Equations),
    length(Equations, N).
