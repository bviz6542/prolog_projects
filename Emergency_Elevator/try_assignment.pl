cube:-write('hey: '), read(Number), C is Number*Number/3, print(C).

elev(X,Y):- (X =:= 1, Y =:= 0) -> print(X), print('1-1'), 
    X < 2 -> print('2-1'); print('2-2').

count(A1,A2,A3):-
    (A1 =:= 1 -> (A2 < 1 -> AA6 is 999;!),(A2 > 1 -> AA6 is 777+A3;!),print('ho ');!),
    (A1 =\= 1 -> (A2 < 1 -> AA6 is 666;!),(A2 > 1 -> AA6 is 111+A3;!),print('ho ');!),
    print(AA6),
    read(X),print(X),
    count(A1,A2,AA6).
