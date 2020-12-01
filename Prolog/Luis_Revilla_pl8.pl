/*
HW_08-Prolog lists

Luis Ortiz
A01022320
['c:/Users/luisr/Documents/7mo Semestre/ProgrammingLanguages/Prolog/Luis_Revilla_pl8.pl'].
*/

/*
 in_list : Take two arguments, a list and an element, and determine if the element can be found inside the list. Example:

 in_list([e, h, s, y, u, c, a, w, h], u).
true
?- in_list([s, f, t, e, h], u).
false.
*/

% Base case
in_list([X|_], X) :- !.
% Recursive rule
in_list([_|Tail], X) :-
    in_list(Tail, X).

/*
 element_at : Take as argument an index and a list, and return the element at index n of the list. Indices start at 0. If the index is negative, then you should start counting from the right side, where the last element in the list has index -1. Examples:

?- element_at(2, [a, b, c, d, e, f], X).
X = c .
?- element_at(-2, [a, b, c, d, e, f], X).
X = e .
*/


element_at(0,[Element|_], Element):- !.
element_at(Index, List, Element):-
    Index < 0,
    length(List, Length),
    NewPos is Length + Index,
    element_at(NewPos, List, Element).
element_at(Index, [_|Tail], Element):-
    Index >= 0,
    NewPos is Index - 1,
    element_at(NewPos, Tail, Element).

/*
range : Take as arguments a starting and ending number, as well as an increment and a list. The list will be a collection of numbers from start to finish, with the increment specified.  The top limit is not inclusive. If it is not possible to get from start to finish with the increment provided, return an empty list. Examples:

?- range(2, 18, 3, L).
L = [2, 5, 8, 11, 14, 17] .
?- range(10, -2, -3, L).
L = [10, 7, 4, 1].
?- range(9, 2, 1, L).
L = [].
*/



/*
 remove_doubles: Take as argument a list, and generate a list without contiguous elements that are duplicated. Example:

?- remove_doubles([1, 1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 7, 8, 8], R).
R = [1, 2, 3, 4, 5, 6, 7, 8]
?- remove_doubles([a, a, b, b, b, c, c, a, a, d, e, e], R).
R = [a, b, c, a, d, e] .
*/
quitar(_,[],[]).
quitar(X,[X|T],R):- 
    quitar(X,T,R).
quitar(X,[H|T],[H|R]) :- 
    quitar(X,T,R).

remove_doubles([],[]).
remove_doubles([H|T], [H|R]) :- 
    in_list(T,H),!,
    quitar(H,T,R1),
    remove_doubles(R1,R).

remove_doubles([H|T],[H|R]):-
    remove_doubles(T,R).

/*
 fibonacci: Take as argument a positive integer, and generate a list containing the numbers in the Fibonacci sequence, starting at index 0 with the value 0. Example:

?- fibonacci(0, R).
R = [0]
?- fibonacci(4, R).
R = [0, 1, 1, 2, 3]
?- fibonacci(8, R).
R = [0, 1, 1, 2, 3, 5, 8, 13, 21].

*/
tec_append([], List2, List2).
tec_append([Head|Tail], List2, [Head|Result]) :-
    tec_append(Tail, List2, Result).

fib(0,0).
fib(1,1).
fib(N,R) :-
    N>1,
    A is N-1,
    B is N-2,
    fib(A,T1),
    fib(B,T2),
    R is T1 + T2.


fibonacci(0, [0]).
fibonacci(1, [0,1]).
fibonacci(N,R) :-
    N > 1,
    K is N - 1,
    fibonacci(K, [Head|Res]),
    Res is fib(N, X).
