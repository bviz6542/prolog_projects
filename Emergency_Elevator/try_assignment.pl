cube:-write('hey: '), read(Number), C is Number*Number/3, print(C).

elev(X,Y):- (X =:= 1, Y =:= 0) -> print(X), print('1-1'), 
    X < 2 -> print('2-1'); print('2-2').

count(C):-
    (C>5 -> print('erwe'),Y is 66; Y is 77),
    print(Y),
    read(X),print(X),
    count(Y).

% ?- count(4)
