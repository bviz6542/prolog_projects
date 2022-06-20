/*
엘리베이터 3대인 version.
elev에 담을 속성: 호수, 방향, 현재 층, 방문 리스트
1. 단일 유닛 움직임부터 구현
- priority_queue 붙이는 법 강구
- GUI 개선 필요
2. 방문 리스트 붙이기
?- runElevator(['elev1',1,3,[[2,4],[4,5],[6,7]],[[5,4],[5,1]],2],['elev2',1,4,[[2,4],[4,5]],[[7,6],[5,1]],3],['elev3',0,6,[[7,6],[5,1]],[],3]).
엘리베이터가 윗방향이면 1, 아랫방향이면 0.
*/

elev([Name,Direction,Now,Uplist,Downlist, Distance],[X1,X2,X3,X4,X5,X6]):-
    X1 is Name, print(X1),
    
    (Direction =:= 1,not(empty_queue(Uplist))-> 
    printElevU(Now),print('pause'),X2 is Direction,X3 is Now,X4 is Uplist,X5 is Downlist,X6 is Distance;!),
    
    (Direction =:= 1 -> printElevU(Now);printElevD(Now)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (A6 =:= 0 -> AA3 is A3, print(' $open$'),
        (A2 =:= 1-> AA2 is 0; AA2 is 1);!),nl,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (A6 > 0 -> AA2 is A2,
        (A2 =:= 1-> AA3 is A3+1; AA3 is A3-1);!),
    (A2 =:= 1 -> AA6 is A4-A3-1; AA6 is A3-A5-1),
    
    (empty_queue(Uplist),empty_queue(Downlist) -> 
    printElevU(Now),print('pause'),X2 is Direction,X3 is Now,X4 is Uplist,X5 is Downlist,X6 is Distance;!),
    (Direction =:= 1,empty_queue(Uplist),not(empty_queue(Downlist)) -> 
    printElevD(Now-1),X2 is 0,insert_list_pqD(Downlist,[],PQ),dequeue(H,PQ,_),
        X3 is Now-1,X4 is Uplist,X5 is PQ,X6 is Now-H;!),
    (Direction =:= 0,not(empty_queue(Uplist)),empty_queue(Uplist) -> 
    printElevU(Now+1),X2 is 0,insert_list_pqD(Downlist,[],PQ),dequeue(H,PQ,_),
        X3 is Now-1,X4 is Uplist,X5 is PQ,X6 is Now-H;!),
    (Direction =:= 0,not(empty_queue(Uplist)),empty_queue(Downlist) -> 
    printElevU(Now),X2 is 1,X3 is Now,X4 is Uplist,X5 is Downlist,X6 is Distance;!),
    
    print([X1,X2,X3,X4,X5,X6]),nl.

runElevator([A1,A2,A3,A4,A5,A6],[B1,B2,B3,B4,B5,B6],[C1,C2,C3,C4,C5,C6]):-
    print('floor: 1 2 3 4 5 6 7 8 9'),nl,
    
    elev([A1,A2,A3,A4,A5,A6],[NA1,NA2,NA3,NA4,NA5,NA6]),
    elev([B1,B2,B3,B4,B5,B6],[NB1,NB2,NB3,NB4,NB5,NB6]),
    elev([C1,C2,C3,C4,C5,C6],[NC1,NC2,NC3,NC4,NC5,NC6]),
    
    %무한루프 방지용
    write('Shall I continue? Type y or n: '),read(X), continue_or_not(X),
    runElevator([NA1,NA2,NA3,NA4,NA5,NA6],[NB1,NB2,NB3,NB4,NB5,NB6],[NC1,NC2,NC3,NC4,NC5,NC6]).

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
