:- use_module(library(plunit)).
:- ensure_loaded('../code/45_q1.pl').

:- begin_tests(p1).

test(candidate_assignments_are_distinct) :-
    findall(Solution, candidate_assignment(Solution), Candidates),
    length(Candidates, 13824),
    sort(Candidates, Distinct),
    length(Distinct, 13824).

% Each pattern is completed by candidate_assignment/1 before testing the clue.
clue_examples(1, [p('Alex', design, _, 'AI'), _, _, _],
                 [_, _, _, p('Dana', design, _, 'AI')]).
clue_examples(2, [p('Alex', research, java, _), _, _, _],
                 [p('Alex', development, java, _), _, _, _]).
clue_examples(3, [p('Alex', testing, python, _), _, _, _],
                 [p('Alex', testing, java, _), _, _, _]).
clue_examples(4, [_, p('Ben', design, _, web), _, _],
                 [_, p('Ben', testing, _, web), _, _]).
clue_examples(5, [_, _, p('Carla', design, java, _), _],
                 [_, _, p('Carla', testing, java, _), _]).
clue_examples(6, [_, _, p('Carla', design, _, data), _],
                 [_, _, p('Carla', design, _, embedded), _]).
clue_examples(7, [_, _, _, p('Dana', testing, python, _)],
                 [_, _, _, p('Dana', testing, java, _)]).
clue_examples(8, [p('Alex', research, python, data), _, _, _],
                 [p('Alex', research, javascript, data), _, _, _]).

test(clue_accepts_and_rejects, [forall(clue_examples(Number, Matching, Nonmatching))]) :-
    once(candidate_assignment(Matching)),
    once(candidate_assignment(Nonmatching)),
    assertion(clue(Number, Matching)),
    assertion(\+ clue(Number, Nonmatching)).

test(solution_counts, [forall(member(Active-Expected, [
    []-13824,
    [1]-7776,
    [1,2,3,4,5,6,7,8]-3,
    [1,2,3,4,5,6,7,8,9]-1
]))]) :-
    count_solutions(Active, Actual),
    assertion(Actual == Expected).

test(main_prints_one_valid_assignment) :-
    with_output_to(string(Output), main),
    once((
        Solution = [
            p('Alex', AlexDept, AlexLang, AlexProject),
            p('Ben', BenDept, BenLang, BenProject),
            p('Carla', CarlaDept, CarlaLang, CarlaProject),
            p('Dana', DanaDept, DanaLang, DanaProject)
        ],
        candidate_assignment(Solution),
        forall(between(1, 8, Number), clue(Number, Solution)),
        format(string(Expected),
               'Alex = [~a, ~a, ~a]~nBen = [~a, ~a, ~a]~nCarla = [~a, ~a, ~a]~nDana = [~a, ~a, ~a]~n',
               [AlexDept, AlexLang, AlexProject, BenDept, BenLang, BenProject,
                CarlaDept, CarlaLang, CarlaProject, DanaDept, DanaLang, DanaProject]),
        Output == Expected
    )).

:- end_tests(p1).
