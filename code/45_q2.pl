:- use_module(library(lists), [append/3]).

% equation_split(+Numbers, ?Left, ?Right) enumerates nonempty prefixes and
% suffixes in order of increasing prefix length.
equation_split(Numbers, Left, Right) :-
    Left = [_|_],
    append(Left, Right, Numbers),
    Right = [_|_].
