:- use_module(library(lists), [member/2, permutation/2]).

% candidate_assignment(?Solution) succeeds for each assignment that uses
% every department, language, and project once, before checking any clues.
candidate_assignment([
    p('Alex', AlexDept, AlexLang, AlexProject),
    p('Ben', BenDept, BenLang, BenProject),
    p('Carla', CarlaDept, CarlaLang, CarlaProject),
    p('Dana', DanaDept, DanaLang, DanaProject)
]) :-
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]).

% clue(1, +Solution) checks that the AI project belongs to someone other than
% Dana who works outside research.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Name \= 'Dana',
    Dept \= research.

% clue(2, +Solution) checks Alex's department and favorite language.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

% clue(3, +Solution) checks that the friend in testing prefers Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% clue(4, +Solution) checks that Ben prefers web and works outside testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

% clue(5, +Solution) checks that the friend who prefers Java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% clue(6, +Solution) checks Carla's department and project preference.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

% clue(7, +Solution) checks Dana's department and favorite language.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    member(Dept, [research, testing]).

% clue(8, +Solution) checks the department and language of the data fan.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.

% count_solutions(+Active, ?N) counts candidates satisfying every listed clue.
count_solutions(Active, N) :-
    findall(Solution,
            ( candidate_assignment(Solution),
              forall(member(Number, Active), clue(Number, Solution))
            ),
            Solutions),
    length(Solutions, N).
