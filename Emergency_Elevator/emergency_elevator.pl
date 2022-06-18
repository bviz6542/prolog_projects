/*
엘리베이터 3대인 version.
elev에 담을 속성: 호수, 방향, 현재 층, 방문 리스트
1. 단일 유닛 움직임부터 구현
- priority_queue 붙이는 법 강구
- GUI 개선 필요
2. 방문 리스트 붙이기
?- printState(['elev1',1,3],['elev2',1,4],['elev3',0,7]).
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
    (A2 =:= 1 -> AA6 is A4-A3,print('ho'), A2 =:= 0 -> AA6 is A3-A5), 
    print('jaja'),
    (A6 =:= 0, A2 =:= 1)-> print(' ~open~'), AA2 is 0, %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (A6 =:= 0, A2 =:= 0)-> print(' ~open~'), AA2 is 1,
    print('hyewfa'),
    (A6 > 0, A2 =:= 1)-> AA4 is A4+1,
    (A6 > 0, A2 =:= 0)-> AA4 is A4-1; AA4 is A4,
    
    print(B1),(B2 =:= 1 -> printElevU(B3);printElevD(B3)),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    (B2 =:= 1 -> BB6 is B4-B3; BB6 is B3-B5),
    (B6 =:= 0, B2 =:= 1)-> print(' ~open~1'), BB2 is 0,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (B6 =:= 0, B2 =:= 0)-> print(' ~open~2'), BB2 is 1,
    (B6 > 0, B2 =:= 1)-> BB4 is B4+1,
    (B6 > 0, B2 =:= 0)-> BB4 is B4-1; BB4 is B4,
    
    print(C1),C2 =:= 1 -> printElevU(C3);printElevD(C3),
    %%% 여기서 우선순위 큐로 순서 재지정해줘야 함
    C2 =:= 1 -> C6 is C4-C3; C6 is C3-C5,
    (C6 =:= 0, C2 =:= 1)-> print(' ~open~'), C2 is 0,
    %%% 큐에서 팝해야 함, 일단은 제일 높은 곳에 멈췄다는 가정
    (C6 =:= 0, C2 =:= 0)-> print(' ~open~'), C2 is 1,
    (C6 > 0, C2 =:= 1)-> C4 is C4+1,
    (C6 > 0, C2 =:= 0)-> B4 is C4-1; C4 is C4,
    
    write('Type [floor_number,direction] or type keepgoing: '),read(X), process(X),
    %%% 여기서 최적의 엘리베이터 배정해줘야 함
    printState([A1,AA2,A3,AA4,A5,AA6],[B1,BB2,B3,BB4,B5,BB6],[C1,C2,C3,C4,C5,C6]).

process(keepgoing).
process([X,Y]) :- X is X, Y is Y.

% 엘리베이터 실시간 GUI 구현
printElevD(1):-print(' < 0 0 0 0 0 0'),nl.
printElevD(2):-print(' 0 < 0 0 0 0 0'),nl.
printElevD(3):-print(' 0 0 < 0 0 0 0'),nl.
printElevD(4):-print(' 0 0 0 < 0 0 0'),nl.
printElevD(5):-print(' 0 0 0 0 < 0 0'),nl.
printElevD(6):-print(' 0 0 0 0 0 < 0'),nl.
printElevD(7):-print(' 0 0 0 0 0 0 <'),nl.

printElevU(1):-print(' > 0 0 0 0 0 0'),nl.
printElevU(2):-print(' 0 > 0 0 0 0 0'),nl.
printElevU(3):-print(' 0 0 > 0 0 0 0'),nl.
printElevU(4):-print(' 0 0 0 > 0 0 0'),nl.
printElevU(5):-print(' 0 0 0 0 > 0 0'),nl.
printElevU(6):-print(' 0 0 0 0 0 > 0'),nl.
printElevU(7):-print(' 0 0 0 0 0 0 >'),nl.

/*
insert_sort_queue(State, [], [State]).
insert_sort_queue(State, [H | T], [State, H | T]) :- precedes(State, H).
insert_sort_queue(State, [H|T], [H | T_new]) :- insert_sort_queue(State, T, T_new).
remove_sort_queue(First, [First|Rest], Rest).
*/
