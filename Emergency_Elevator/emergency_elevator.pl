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
elev([Name,Direction,Now,Uplist,Downlist, Distance]):-
    print(Name),Direction =:= 1 -> printElevU(Now);printElevD(Now),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    Direction =:= 1 -> Distance is Uplist-Now;Distance is Now-Downlist,
    (Distance =:= 0, Direction =:= 1)-> print(' ~open~'),Direction is 0,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (Distance =:= 0, Direction =:= 0)-> print(' ~open~'),Direction is 1,
    (Distance > 0, Direction =:= 1)-> Now is Now+1,
    (Distance > 0, Direction =:= 0)-> Now is Now-1; Now is Now.

printState([A1,A2,A3,A4,A5,A6],[B1,B2,B3,B4,B5,B6],[C1,C2,C3,C4,C5,C6]):-
    print('floor: 1 2 3 4 5 6 7'),nl,
    
    print(A1),(A2 =:= 1 -> printElevU(A3);printElevD(A3)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (A6 =:= 0 -> AA3 is A3, print(' $open$'),
        (A2 =:= 1-> AA2 is 0; AA2 is 1);!),nl,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (A6 > 0 -> AA2 is A2,
        (A2 =:= 1-> AA3 is A3+1; AA3 is A3-1);!),
    (A2 =:= 1 -> AA6 is A4-A3-1; AA6 is A3-A5-1),
    print([A1,AA2,AA3,A4,A5,AA6]),nl,
    
    print(B1),(B2 =:= 1 -> printElevU(B3);printElevD(B3)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (B6 =:= 0 -> BB3 is B3,print(' $open$'),
        (B2 =:= 1-> BB2 is 0; BB2 is 1);!),nl,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (B6 > 0 -> BB2 is B2,
        (B2 =:= 1-> BB3 is B3+1; BB3 is B3-1);!),
    (B2 =:= 1 -> BB6 is B4-B3-1; BB6 is B3-B5-1),
    %print([B1,BB2,BB3,B4,B5,BB6]),nl,
    
    print(C1),(C2 =:= 1 -> printElevU(C3);printElevD(C3)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (C6 =:= 0 -> CC3 is C3, print(' $open$'),
        (C2 =:= 1-> CC2 is 0; CC2 is 1);!),nl,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (C6 > 0 -> CC2 is C2,
        (C2 =:= 1-> CC3 is C3+1; CC3 is C3-1);!),
    (C2 =:= 1 -> CC6 is C4-C3-1; CC6 is C3-C5-1),
    %print([C1,CC2,CC3,C4,C5,CC6]),nl,
    
    write('Type [floor_number,direction] or type keepgoing: '),read(X), process(X),
    %%% 여기서 최적의 엘리베이터 배정해줘야 함
    printState([A1,AA2,AA3,A4,A5,AA6],[B1,BB2,BB3,B4,B5,BB6],[C1,CC2,CC3,C4,C5,CC6]).

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

/*
insert_sort_queue(State, [], [State]).
insert_sort_queue(State, [H | T], [State, H | T]) :- precedes(State, H).
insert_sort_queue(State, [H|T], [H | T_new]) :- insert_sort_queue(State, T, T_new).
remove_sort_queue(First, [First|Rest], Rest).
*/
