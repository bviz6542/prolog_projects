/*
엘리베이터 3대인 version.
elev에 담을 속성: 호수, 방향, 방문 리스트
1. 단일 유닛 움직임부터 구현
- priority_queue 붙이는 법 강구
- GUI 개선 필요
2. 방문 리스트 붙이기
?- printState(['elev1',1,3],['elev2',1,4],['elev3',0,7]).
엘리베이터가 윗방향이면 1, 아랫방향이면 0.
*/


elev([X,Y,Z]):-print(X),Y =:= 1 -> printElevU(Z);printElevD(Z).

printState(A,B,C):-print('floor: 1 2 3 4 5 6 7'),nl,elev(A),elev(B),elev(C),
    write('Type the number of floor you are in or type no: '),read(Floor), process(Floor).

process(no) :- !.
process(Floor) :-
   printState(A,B,C).

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
