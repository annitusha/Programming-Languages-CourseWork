#!/usr/bin/env -S swipl
%-*- mode: prolog; -*-

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% triples/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #1: 10-points
% triples(List, Triples) should succeed iff Triples matches a list of
% 3-elements lists containing successive triples of List whose length
% must be divisible by 3.  The procedure should fail if the length of
% List is not divisible by 3.
%triples(_List, _Triples) :- 'TODO'.

triples([], []).
    triples([X,Y,Z | Rest],[[X,Y,Z] | Triples]) :-
       triples(Rest, Triples).

triples(_, _) :-
    false.

:-begin_tests(triples).
test(empty, [nondet]) :-
    triples([], []).
test(triples1, [nondet]) :-
    triples([1, 2, 3], [[1, 2, 3]]).
test(triples2, [nondet]) :-
    triples([1, 2, 3, 4, 5, 6], [[1, 2, 3], [4, 5, 6]]).
test(triples4, [nondet]) :- 
    triples([1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c],
	    [[1, 2, 3], [4, 5, 6], [7, 8, 9], [a, b, c]]).
test(triples_var, [nondet, true([A, B] == [2, 5])]) :- 
    triples([1, A, 3, 4, 5, 6], [[1, 2, 3], [4, B, 6]]).
test(triples1, [fail]) :-
    triples([1], _).
test(triples1, [fail]) :-
    triples([1, 2], _).
test(triples1, [fail]) :-
    triples([1, 2, 3, 4], _).
:-end_tests(triples).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% split/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #2: 15-points
% split(List, Prefix, Suffix) should succeed iff Prefix
% matches a non-empty prefix of List with Suffix matching the rest
% of List.
%split(_List, _Prefix, _Suffix) :- 'TODO'.
split([X | Rest], [X | []], Rest).

split([X | Rest], [X | Prefix], Suffix) :-
        split(Rest,Prefix,Suffix).

%split([], [],[]) :-
%   false.
%split([],_,_) :-
%    false.
%split([X | _], [], [X]) :-
%   false.

:-begin_tests(split).
test(prefix1, [nondet]) :-
    split([1, 2, 3, 4], [1], [2, 3, 4]).
test(prefix2, [nondet]) :-
    split([1, 2, 3, 4], [1, 2], [3, 4]).
test(prefix3, [nondet]) :-
    split([1, 2, 3, 4], [1, 2, 3], [4]).
test(prefix4, [nondet]) :-
    split([1, 2, 3, 4], [1, 2, 3, 4], []).
test(full, [nondet]) :-
    split([1, 2, 3, 4], [1, 2, 3, 4], []).
test(prefix3_fail, [fail]) :-
    split([1, 2], [1, 2, 3], _Rest).
test(empty_prefix_fail, [fail]) :-
    split(_List, [], _Rest).
test(empty_list_fail, [fail]) :-
    split([], _Prefix, _Rest).
test(all, [set([Prefix, Suffix] ==
	       [[[1], [2, 3]], [[1, 2], [3]], [[1, 2, 3], []]])]) :-
    split([1, 2, 3], Prefix, Suffix).
:-end_tests(split).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n_tuples/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #3: 15-points
% n_tuples(List, N, NTuples) should succeed iff NTuples matches a list
% of N-element lists containing successive N-tuples of List whose
% length must be divisible by N.  N should be an integer > 0. The
% procedure should fail if the length of List is not divisible by N.
%
% Hint: use split/3 and length/2.
%n_tuples(_List, _N, _NTuples) :- 'TODO'.

n_tuples([], _, []).
n_tuples(List, N, [Prefix |NTuples]) :-
    %integer(N),
    N > 0,
    length(Prefix, N),
    split(List, Prefix, Rest),
    n_tuples(Rest, N, NTuples).

n_tuples(_, _, _) :-
    false.

:-begin_tests(n_tuples).
test(empty1, [nondet]) :-
    n_tuples([], 1, []).
test(empty4, [nondet]) :-
    n_tuples([], 4, []).
test(tuples1, [nondet]) :-
    n_tuples([1, 2, 3, 4], 1, [[1], [2], [3], [4]]).
test(tuples2, [nondet]) :-
    n_tuples([1, 2, 3, 4], 2, [[1, 2], [3, 4]]).
test(tuples3, [nondet]) :-
    n_tuples([1, 2, 3], 3, [[1, 2, 3]]).
test(tuples3_2, [nondet]) :-
    n_tuples([a, b, c, d, e, f], 3, [[a, b, c], [d, e, f]]).
test(tuples2_fail, [fail]) :-
    n_tuples([a, b, c, d, e], 2, _Tuples).
test(tuples3_fail, [fail]) :-
    n_tuples([a, b, c, d, e], 3, _Tuples).
:-end_tests(n_tuples).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% sublist/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #4: 15-points
% sublist(List, SubList) should succeed iff SubList matches a
% non-empty sub-list of List.
%
% Hint: use split/3 to extract prefix of suffixes of list.
%sublist(_List, _SubList) :- 'TODO'.
sublist([X|A], [X|A]).
%sublist([SubList | List], SubList) :-
sublist([X | Xs], SubList) :-
    split([X | Xs], SubList, _).

sublist([ _ | Rest], SubList) :-
    sublist(Rest,SubList).


:-begin_tests(sublist).
test(prefix1, [nondet]) :-
    sublist([1, 2, 3, 4], [1]).
test(prefix3, [nondet]) :-
    sublist([1, 2, 3, 4], [1, 2, 3]).
test(suffix1, [nondet]) :-
    sublist([1, 2, 3, 4], [4]).
test(suffix3, [nondet]) :-
    sublist([1, 2, 3, 4], [2, 3, 4]).
test(mid1, [nondet]) :-
    sublist([1, 2, 3, 4], [2]).
test(mid2, [nondet]) :-
    sublist([1, 2, 3, 4, 5, 6], [3, 4]).
test(mid3, [nondet]) :-
    sublist([1, 2, 3, 4, 5, 6], [3, 4, 5]).
test(empty_list, [fail]) :-
    sublist([], _SubList).
test(empty_sublist, [fail]) :-
    sublist([1, 2], []).
test(skip_element, [fail]) :-
    sublist([1, 2, 3], [1, 3]).
test(unknown_element, [fail]) :-
    sublist([1, 2, 3], [1, 4]).
test(all, [set(Z == [[1], [1, 2], [1, 2, 3], [2], [2, 3], [3]])]) :-
    sublist([1, 2, 3], Z).
:-end_tests(sublist).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% eval_expr1/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #5: 10-points
% An expressions Expr is either a number, add(Expr, Expr), sub(Expr,
% Expr), mul(Expr, Expr) or uminus(Expr).
%
% eval_expr1(Expr, Value) should match Value with the value of Expr
% where a number evaluates to itself and add, sub, mul and uminus
% should be evaluate in the obvious manner.
%
% Hint: use the Prolog predicate number(N) which succeeds iff N is a
% number.
%eval_expr1(_Expr, _Value) :- 'TODO'.
eval_expr1(Expr, Value) :- 
    number(Expr), % If Expr is a number, return its value.
    Value is Expr.

eval_expr1(add(Expr1, Expr2), Value) :-
    eval_expr1(Expr1, Value1), % Recursively evaluate the left subexpression.
    eval_expr1(Expr2, Value2), % Recursively evaluate the right subexpression.
    Value is Value1 + Value2. % Compute the sum.

eval_expr1(sub(Expr1, Expr2), Value) :-
    eval_expr1(Expr1, Value1),
    eval_expr1(Expr2, Value2),
    Value is Value1 - Value2. % Compute the difference.

eval_expr1(mul(Expr1, Expr2), Value) :-
    eval_expr1(Expr1, Value1),
    eval_expr1(Expr2, Value2),
    Value is Value1 * Value2. % Compute the product.

eval_expr1(uminus(Expr), Value) :-
    eval_expr1(Expr, SubValue), % Recursively evaluate the subexpression.
    Value is -SubValue. % Compute the negation.

:-begin_tests(eval_expr1).
test(42, [true(Z == 42)]) :-
    eval_expr1(42, Z).
test(add, [true(Z == 55)]) :-
    eval_expr1(add(33, 22), Z).
test(sub, [true(Z == 11)]) :-
    eval_expr1(sub(33, 22), Z).
test(mul, [true(Z == 124)]) :-
    eval_expr1(mul(31, 4), Z).
test(uminus, [true(Z == -33)]):-
    eval_expr1(uminus(33), Z).
test(compound, [true(Z == -200)]):-
    eval_expr1(mul(4, sub(add(3, uminus(33)), 20)), Z).
:-end_tests(eval_expr1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% eval_expr2/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #6: 15-points
% An Expr is as in the previous exercise, but also allows atoms whose
% values should be looked up in an environment.  An environment Env is
% a list of pairs Atom=Value giving specifying Value as
% the value of atom Atom in Env.
%
% eval_expr2(Expr, Env, Value) should match Value with the value of Expr
% as in the previous exercise with the value of atoms being looked up
% in Env.
%
% Hints: use atom(A) to check if A is an atom and member/2 to lookup
% an atom in an Env.
%eval_expr2(_Expr, _Env, _Value) :- 'TODO'.
eval_expr2(Expr, _Envir, Value) :- 
    number(Expr), % If Expr is a number, return its value.
    Value is Expr.

eval_expr2(Atom, Envir, Value) :-
    atom(Atom), % If Atom is an atom, look it up in the environment.
    member(Atom=Value, Envir), % Use member/2 to find the value of Atom in the environment.
    Value = Value.

eval_expr2(add(Expr1, Expr2), Envir, Value) :-
    eval_expr2(Expr1, Envir, Value1), % Recursively evaluate the left subexpression.
    eval_expr2(Expr2, Envir, Value2), % Recursively evaluate the right subexpression.
    Value is Value1 + Value2. % Compute the sum.

eval_expr2(sub(Expr1, Expr2), Envir, Value) :-
    eval_expr2(Expr1, Envir, Value1),
    eval_expr2(Expr2, Envir, Value2),
    Value is Value1 - Value2. % Compute the difference.

eval_expr2(mul(Expr1, Expr2), Envir, Value) :-
    eval_expr2(Expr1, Envir, Value1),
    eval_expr2(Expr2, Envir, Value2),
    Value is Value1 * Value2. % Compute the product.

eval_expr2(uminus(Expr), Envir, Value) :-
    eval_expr2(Expr, Envir, SubValue), % Recursively evaluate the subexpression.
    Value is -SubValue. % Compute the negation.
:-begin_tests(eval_expr2).
test(42, [nondet, true(Z == 42)]) :-
    eval_expr2(42, [a=10, b=5],  Z).
test(atom, [nondet, true(Z == 10)]) :-
    eval_expr2(a, [a=10, b=5],  Z).
test(add_uminus, [nondet, true(Z == 5)]) :-
    eval_expr2(add(a, uminus(b)), [a=10, b=5],  Z).
test(mul_add_uminus, [nondet, true(Z == 15)]) :-
    eval_expr2(mul(3, add(a, uminus(b))), [a=10, b=5],  Z).
test(sub_mul_add_uminus, [nondet, true(Z == -5)]) :-
    eval_expr2(sub(a, mul(3, add(a, uminus(b)))), [a=10, b=5],  Z).
test(top_fail, [fail]) :-
    eval_expr2(sub(c, mul(3, add(a, uminus(b)))), [a=10, b=5],  _Z).
test(internal_fail, [fail]) :-
    eval_expr2(sub(a, mul(3, add(a, uminus(c)))), [a=10, b=5],  _Z).
:-end_tests(eval_expr2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%% regex_match/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% #7: 20-points
% This exercise should illustrate the use of deep backtracking
% in Prolog for regex matching.  For this exercise, we will
% represent a string as a list of Prolog atom's.
% A regex can be:
%   An atom A which matches A.
%   A list of atoms representing a char class matching one of its elements.
%   cat(RE1, RE2) which matches the concatenation of a match of regex RE1
%                 followed by a match of regex RE2.
%   alt(RE1, RE2) which matches what matches regex RE1 or what matches
%                 regex RE2,
%   closure(RE) which matches 0-or-more repetitions of what matches regex RE.
%
% regex_match(Regex, String): should succeed iff regex Regex matches
% the entire "string" String.
%regex_match(_Regex, _String) :- 'TODO'.

% regex_match/2: wrapper around regex_match/3
regex_match(Regex, String) :- 
    regex_match(Regex, String, []).

% regex_match/3: implement regex_match(Regex, String, Leftover)
% where Leftover represents the leftover suffix of String after a prefix of String matched Regex.
regex_match(Regex, String, Leftover) :- 
    atom(Regex), match_atom(Regex, String, Leftover).

regex_match([Element | Rest], String, Leftover) :- 
    is_char_class([Element | Rest], String, Leftover).

regex_match(cat(Regex1, Regex2), String, Leftover) :- 
    regex_match(Regex1, String, Middle), 
    regex_match(Regex2, Middle, Leftover).

regex_match(alt(Regex1, Regex2), String, Leftover) :- 
    (regex_match(Regex1, String, Leftover) ; regex_match(Regex2, String, Leftover)).

regex_match(closure(Regex), String, Leftover) :- 
    match_closure(Regex, String, Leftover).

match_atom(Atom, [Atom | Rest], Rest).
is_char_class(CharClass, [Head | Tail], Leftover) :- 
    member(Head, CharClass), 
    Leftover = Tail.

match_closure(_, String, String).

match_closure(Regex, String, Leftover) :- 
    regex_match(Regex, String, Middle), 
    match_closure(Regex, Middle, Leftover).



:-begin_tests(regex_match).

% regex /a/ matches "a".
test(atom, [nondet]) :-  
    regex_match(a, [a]).

% regex /[a]/ matches "a".
test(char_class1, [nondet]) :-
    regex_match([a], [a]).

% regex /[abc]/ matches "b".
test(char_class3, [nondet]) :-
    regex_match([a, b, c], [b]).

% regex /[abc]d/ matches "cd".
test(cat, [nondet]) :-
    regex_match(cat([a, b, c], d), [c, d]).

% regex /[abc]|d/ matches "a".
test(alt1, [nondet]) :-
    regex_match(alt([a, b, c], d), [a]).

% regex /[abc]|d/ matches "d".
test(alt2, [nondet]) :-
    regex_match(alt([a, b, c], d), [d]).

% regex /[abc]*/ matches "".
test(closure0, [nondet]) :-
    regex_match(closure([a, b, c]), []).

% regex /[abc]*/ matches "b".
test(closure1, [nondet]) :-
    regex_match(closure([a, b, c]), [b]).

% regex /[abc]*/ matches "cab".
test(closure3, [nondet]) :-
    regex_match(closure([a, b, c]), [c, a, b]).

% regex /[abc]*[def]/ matches "cad".
test(complex1, [nondet]) :-
    regex_match(cat(closure([a, b, c]), [d, e, f]), [c, a, d]).

% regex /[abc]*|[def]/ matches "e".
test(complex2, [nondet]) :-
    regex_match(alt(closure([a, b, c]), [d, e, f]), [e]).

% regex /([abc]|[def])*/ matches "abecd".
test(complex3, [nondet]) :-
    regex_match(closure(alt([a, b, c], [d, e, f])), [a, b, e, c, d]).

% regex /([abc][def])*/ matches "aebdcf".
test(complex4, [nondet]) :-
    regex_match(closure(cat([a, b, c], [d, e, f])), [a, e, b, d, c, f]).

% regex /a/ does not match "b".
test(fail1, [fail]) :-
    regex_match(a, [b]).

% regex /[ab][cd]/ does not match "ba".
test(fail2, [fail]) :-
    regex_match(cat([a, b], [c, d]), [b, a]).

% regex /[ab][cd]/ does not match "bc".
test(fail3, [fail]) :-
    regex_match(alt([a, b], [c, d]), [b, c]).

% regex /([abc][def])*/ does not match "aebdc".
test(fail4, [fail]) :-
    regex_match(closure(cat([a, b, c], [d, e, f])), [a, e, b, d, c]).
:-end_tests(regex_match).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% main/0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main :-
    current_prolog_flag(argv, Argv),
    (length(Argv, 0) -> run_tests ; run_tests(Argv)).

:-initialization(main, main).