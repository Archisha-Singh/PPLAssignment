:- use_module(library(lists), [append/3]).

% equation_split(+Numbers, ?Left, ?Right) enumerates nonempty prefixes and
% suffixes in order of increasing prefix length.
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

% expression(+Numbers, ?Tree, ?Value) enumerates ordered expression trees
% and their integer values. A single number is a leaf.
expression([Number], Number, Number).
expression(Numbers, op(Operator, LeftTree, RightTree), Value) :-
    equation_split(Numbers, Left, Right),
    expression(Left, LeftTree, LeftValue),
    expression(Right, RightTree, RightValue),
    apply_operator(Operator, LeftValue, RightValue, Value).

% render_expression(+Tree, ?Text, ?Precedence) renders a tree as a string.
% Precedence is 1 for + and -, 2 for * and /, and 3 for integer leaves.
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
    format(string(Text), '~s~a~s', [LeftOperand, Operator, RightOperand]).
