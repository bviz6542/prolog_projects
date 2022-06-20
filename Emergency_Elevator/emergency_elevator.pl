/*
엘리베이터 3대인 version.
elev에 담을 속성: 호수, 방향, 현재 층, 방문 리스트
1. 단일 유닛 움직임부터 구현
- priority_queue 붙이는 법 강구
- GUI 개선 필요
2. 방문 리스트 붙이기
?- runElevator(['elev1',1,3,[[2,4],[4,5],[6,7]],[[5,4],[5,1]],2],['elev2',1,4,[[2,4],[4,5]],[[7,6],[5,1]],3],['elev3',0,6,[[7,6],[5,1]],[],3]).
?-runElevator(['elev1',1,3,[4,5,6,7,5,4,1,3]],['elev2',1,4,[5,7,6,5,1,2,4]],['elev3',0,6,[7,6,5,1]]).
엘리베이터가 윗방향이면 1, 아랫방향이면 0.
*/

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).

nmin_list([[H1|_]|T], Min) :-
    nmin_list(T, H1, Min).
nmin_list([], Min, Min).
nmin_list([[H1|_]|T], Min0, Min) :-
    Min1 is min(H1, Min0),
    nmin_list(T, Min1, Min).

nmax_list([[H1|_]|T], Max) :-
    nmax_list(T, H1, Max).
nmax_list([], Max, Max).
nmax_list([[H1|_]|T], Max0, Max) :-
    Max1 is max(H1, Max0),
    nmax_list(T, Max1, Max).

elev([Name,Direction,Now,List],[X1,X2,X3,X4]):-
    X1 is Name, print('elev'),print(X1),
    (empty_queue(List)->printElevS(Now),print('pause'),nl,X2 is Direction, X3 is Now, clone(List,X4);!),
    
    ((not(empty_queue(List)),dequeue(E, List, T),Now-E > 0)->
    X3 is Now+1,printElevU(Now),nl,X2 is 1, clone(T,X4);!),
    
    ((not(empty_queue(List)),dequeue(E, List, T),Now-E < 0)->
    X3 is Now-1,printElevD(Now),nl,X2 is 0,clone(T,X4);!),
    
    ((not(empty_queue(List)),dequeue(E, List, T),Now-E =:= 0,empty_queue(T))->
    printElevS(Now),print('open'),X2 is Direction,X3 is Now,clone(T,X4);!),
    
    ((not(empty_queue(List)),dequeue(E, List, T),Now-E =:= 0,dequeue(E2, T, T2), E>E2)->
    X3 is Now+1,printElevU(Now),print('open'),nl,X2 is 1,clone(T,X4);!),
    
    ((not(empty_queue(List)),dequeue(E, List, T),Now-E =:= 0,dequeue(E2, T, T2), E<E2)->
    X3 is Now-1,printElevD(Now),print('open'),nl,X2 is 0,clone(T,X4);!),
    
    print([X1,X2,X3,X4]),nl.

runElevator([A1,A2,A3,A4],[B1,B2,B3,B4],[C1,C2,C3,C4]):-
    print('floor: 1 2 3 4 5 6 7 8 9'),nl,
    
    elev([A1,A2,A3,A4],[NA1,NA2,NA3,NA4]),
    elev([B1,B2,B3,B4],[NB1,NB2,NB3,NB4]),
    elev([C1,C2,C3,C4],[NC1,NC2,NC3,NC4]),
    
    %무한루프 방지용
    write('Shall I continue? Type y or n: '),read(X), continue_or_not(X),
    runElevator([NA1,NA2,NA3,NA4],[NB1,NB2,NB3,NB4],[NC1,NC2,NC3,NC4]).

continue_or_not(y).

% 엘리베이터 실시간 GUI 구현
printElevD(1):-print(' < 0 0 0 0 0 0 0 0').
printElevD(2):-print(' 0 < 0 0 0 0 0 0 0').
printElevD(3):-print(' 0 0 < 0 0 0 0 0 0').
printElevD(4):-print(' 0 0 0 < 0 0 0 0 0').
printElevD(5):-print(' 0 0 0 0 < 0 0 0 0').
printElevD(6):-print(' 0 0 0 0 0 < 0 0 0').
printElevD(7):-print(' 0 0 0 0 0 0 < 0 0').
printElevD(8):-print(' 0 0 0 0 0 0 0 < 0').
printElevD(9):-print(' 0 0 0 0 0 0 0 0 <').

printElevU(1):-print(' > 0 0 0 0 0 0 0 0').
printElevU(2):-print(' 0 > 0 0 0 0 0 0 0').
printElevU(3):-print(' 0 0 > 0 0 0 0 0 0').
printElevU(4):-print(' 0 0 0 > 0 0 0 0 0').
printElevU(5):-print(' 0 0 0 0 > 0 0 0 0').
printElevU(6):-print(' 0 0 0 0 0 > 0 0 0').
printElevU(7):-print(' 0 0 0 0 0 0 > 0 0').
printElevU(8):-print(' 0 0 0 0 0 0 0 > 0').
printElevU(9):-print(' 0 0 0 0 0 0 0 0 >').
    
printElevS(1):-print(' x 0 0 0 0 0 0 0 0').
printElevS(2):-print(' 0 x 0 0 0 0 0 0 0').
printElevS(3):-print(' 0 0 x 0 0 0 0 0 0').
printElevS(4):-print(' 0 0 0 x 0 0 0 0 0').
printElevS(5):-print(' 0 0 0 0 x 0 0 0 0').
printElevS(6):-print(' 0 0 0 0 0 x 0 0 0').
printElevS(7):-print(' 0 0 0 0 0 0 x 0 0').
printElevS(8):-print(' 0 0 0 0 0 0 0 x 0').
printElevS(9):-print(' 0 0 0 0 0 0 0 0 x').
%%%
empty_queue([]).
enqueue(E, [], [E]).
enqueue(E, [H|T], [H|Tnew]) :- enqueue(E, T, Tnew).
dequeue(E, [E|T], T).
dequeue(E, [E|_], _).
member_queue(Element, Queue) :- member(Element, Queue).
add_list_to_queue(List, Queue, Newqueue) :- append(Queue, List, Newqueue).
%%%
insert_pqU(State, [], [State]):- !.
insert_pqU(State, [H|Tail], [State, H|Tail]) :- precedesU(State, H),!.
insert_pqU(State, [H|T], [H|Tnew]) :- insert_pqU(State, T, Tnew).
precedesU(X, Y) :- X > Y.
insert_list_pqU([ ], L, L).
insert_list_pqU([State|Tail], L, New_L) :- insert_pqU(State, L, L2), insert_list_pqU(Tail, L2, New_L).
%%%
insert_pqD(State, [], [State]):- !.
insert_pqD(State, [H|Tail], [State, H|Tail]) :- precedesD(State, H),!.
insert_pqD(State, [H|T], [H|Tnew]) :- insert_pqD(State, T, Tnew).
precedesD(X, Y) :- X < Y.
insert_list_pqD([ ], L, L).
insert_list_pqD([State|Tail], L, New_L) :- insert_pqD(State, L, L2), insert_list_pqD(Tail, L2, New_L).
%%%
empty_set([]).
member_set(E, S) :- member(E, S).
delete_if_in_set(_, [], []).
delete_if_in_set(E, [E|T], T):- !.
delete_if_in_set(E, [H|T], [H|T_new]) :- delete_if_in_set(E, T, T_new), !.
add_if_not_in_set(X, S, S) :- member(X, S), !.
add_if_not_in_set(X, S, [X|S]).
union([], S, S).
union([H|T], S, S_new) :- union(T, S, S2),
		       add_if_not_in_set(H, S2, S_new), !.
subset([], _).
subset([H|T], S) :- member_set(H, S), subset(T, S).
intersection([], _, []).
intersection([H|T], S, [H|S_new]) :- member_set(H, S),
	intersection(T, S, S_new), !.
intersection([_|T], S, S_new) :- intersection(T, S, S_new), !.
set_difference([], _, []).
set_difference([H|T], S, T_new) :- member_set(H, S),
	set_difference(T, S, T_new), !.
set_difference([H|T], S, [H|T_new]) :- set_difference(T, S, T_new), !.
equal_set(S1, S2) :- subset(S1, S2), subset(S2, S1).
