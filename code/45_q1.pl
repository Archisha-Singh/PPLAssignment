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
