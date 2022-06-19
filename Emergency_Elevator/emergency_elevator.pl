/*
엘리베이터 3대인 version.
elev에 담을 속성: 호수, 방향, 현재 층, 방문 리스트
1. 단일 유닛 움직임부터 구현
- priority_queue 붙이는 법 강구
- GUI 개선 필요
2. 방문 리스트 붙이기
?- printState(['elev1',1,3,5,1,2],['elev2',1,4,7,2,3],['elev3',0,6,7,3,3]).
엘리베이터가 윗방향이면 1, 아랫방향이면 0.
*/



%%% 목표 층이 리스트 형태로 존재해야 함
elev([Name,Direction,Now,Uplist,Downlist, Distance],[X1,X2,X3,X4,X5,X6]):-
    print(A1),(A2 =:= 1 -> printElevU(A3);printElevD(A3)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (A6 =:= 0 -> AA3 is A3, print(' $open$'),
        (A2 =:= 1-> AA2 is 0; AA2 is 1);!),nl,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (A6 > 0 -> AA2 is A2,
        (A2 =:= 1-> AA3 is A3+1; AA3 is A3-1);!),
    (A2 =:= 1 -> AA6 is A4-A3-1; AA6 is A3-A5-1),
    print([A1,AA2,AA3,A4,A5,AA6]),nl.

printState([A1,A2,A3,A4,A5,A6],[B1,B2,B3,B4,B5,B6],[C1,C2,C3,C4,C5,C6]):-
    print('floor: 1 2 3 4 5 6 7'),nl,
    
    elev([A1,A2,A3,A4,A5,A6],[NA1,NA2,NA3,NA4,NA5,NA6]),
    elev([B1,B2,B3,B4,B5,B6],[NB1,NB2,NB3,NB4,NB5,NB6]),
    elev([C1,C2,C3,C4,C5,C6],[NC1,NC2,NC3,NC4,NC5,NC6]),
    
    write('Type [floor_number,direction] or type keepgoing: '),read(X), process(X),
    %%% 여기서 최적의 엘리베이터 배정해줘야 함
    printState([NA1,NA2,NA3,NA4,NA5,NA6],[NB1,NB2,NB3,NB4,NB5,NB6],[NC1,NC2,NC3,NC4,NC5,NC6]).

process(keepgoing).
process([X,Y]) :- X is X, Y is Y.

% 엘리베이터 실시간 GUI 구현
printElevD(1):-print(' < 0 0 0 0 0 0').
printElevD(2):-print(' 0 < 0 0 0 0 0').
printElevD(3):-print(' 0 0 < 0 0 0 0').
printElevD(4):-print(' 0 0 0 < 0 0 0').
printElevD(5):-print(' 0 0 0 0 < 0 0').
printElevD(6):-print(' 0 0 0 0 0 < 0').
printElevD(7):-print(' 0 0 0 0 0 0 <').

printElevU(1):-print(' > 0 0 0 0 0 0').
printElevU(2):-print(' 0 > 0 0 0 0 0').
printElevU(3):-print(' 0 0 > 0 0 0 0').
printElevU(4):-print(' 0 0 0 > 0 0 0').
printElevU(5):-print(' 0 0 0 0 > 0 0').
printElevU(6):-print(' 0 0 0 0 0 > 0').
printElevU(7):-print(' 0 0 0 0 0 0 >').

%%%
empty_queue([]).
enqueue(E, [], [E]).
enqueue(E, [H|T], [H|Tnew]) :- enqueue(E, T, Tnew).
dequeue(E, [E|T], T).
dequeue(E, [E|T], _).
member_queue(Element, Queue) :- member(Element, Queue).
add_list_to_queue(List, Queue, Newqueue) :- append(Queue, List, Newqueue).
%%%
%insert_pq(State, [], [State]):- !.
insert_pq(State, [H|Tail], [State, H|Tail]) :- precedes(State, H),!.
insert_pq(State, [H|T], [H|Tnew]) :- insert_pq(State, T, Tnew).
precedes(X, Y) :- X < Y.
insert_list_pq([ ], L, L).
insert_list_pq([State|Tail], L, New_L) :- insert_pq(State, L, L2), insert_list_pq(Tail, L2, New_L).
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
