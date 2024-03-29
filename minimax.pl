minimax(X,R):-
        algoritm(-100,200,[0,X],[_,R],_).

minimax_secund(X,R):-
        algoritm(-100,200,[2,X],[_,R],_).

stareVictorie(P, X) :-
    P == 2,
    pozitii1(X,1,R)
    ,victorii(V)
    ,compara(V,R),!
    ;
    P == 0,
    pozitii2(X,1,R1)
    ,victorii(V1)
    ,compara(V1,R1),!.


stareEgalitate(_,X) :-
    numarare(X,R),R is 0.

pozitii1([],_,[]).
pozitii1([X|T],I,[I|O]):-
    X == 2,
    I1 is I+1,
    pozitii1(T,I1,O),!.
pozitii1([_|T],I,O):-
    I1 is I+1,
    pozitii1(T,I1,O),!.

pozitii2([],_,[]).
pozitii2([X|T],I,[I|O]):-
    X == 0,
    I1 is I+1,
    pozitii2(T,I1,O),!.
pozitii2([_|T],I,O):-
    I1 is I+1,
    pozitii2(T,I1,O),!.

victorii([[1,2,3],[4,5,6],[7,8,9],
        [1,4,7],[2,5,8],[3,6,9],
        [1,5,9],[3,5,7]]).

compara([],_):-false.
compara([X|T],L):-include(L,X);compara(T,L).

include(_,[]):-true.
include(X,[L|T]):-apartine(X,L),include(X,T).

numarare([],0).
numarare([1|T],R):-numarare(T,R1),R is R1+1,!.
numarare([_|T],R):-numarare(T,R),!.


stariUrmatoare(Jucator, [X|T], [Y|T]) :-
    X = 1->
    Y = Jucator.
stariUrmatoare(Jucator, [X|T], [Y|R]) :-
    Y = X,
    stariUrmatoare(Jucator, T, R).

algoritm(A,B,Pozitie, PozitieCastigatoare, Valoare) :-     
    mutariDerivate(Pozitie,PozitiiUrmatoare),             
    sortareStari(A,B,PozitiiUrmatoare, PozitieCastigatoare, Valoare), !.

algoritm(_,_,[Pion,Lista], _, Valoare) :- 
    evaluareFinalizare(Lista,Status,_),                     
    evaluarePozitie(Status,Pion, Valoare).


mutariDerivate(Pozitie,PozitiiUrmatoare):-
        findall(UrmatoareaPozitie, generareStareUrmatoare(Pozitie, UrmatoareaPozitie), PozitiiUrmatoare).

sortareStari(A,B,[Pozitie], Pozitie, Valoare) :-
    algoritm(A,B,Pozitie, _, Valoare), !.

sortareStari(A,B,[[Pion,Lista] | _], [Pion,Lista], A) :-
    Pion =:= 0,
    A>B,!.

sortareStari(A,B,[[Pion,Lista] | _], [Pion,Lista], B) :-
    Pion =:= 2,
    A>B,!.

sortareStari(A,B,[[Pion,Lista] | ListaPozitii], PozitieCastigatoare, ValoareCastigatoare) :-
    algoritm(A,B,[Pion,Lista], _, Valoare0),
    determinaModificari(Pion,A,B,Valoare0,ANou,BNou),
    sortareStari(ANou,BNou,ListaPozitii, Pozitie1, Valoare1),
    comparare(Pion,Lista, Valoare0, Pozitie1, Valoare1, PozitieCastigatoare, ValoareCastigatoare),!.

determinaModificari(Pion,A,B,Valoare0,ANou,BNou):-
        Pion = 0 , Valoare0 > A ->
        ANou is Valoare0,
        BNou is B,!;
        Pion = 2 , Valoare0 < B ->
        ANou is A,
        BNou is Valoare0,!;
        ANou is A,
        BNou is B,!.

comparare(Pion,Lista, Valoare1, Pozitie2, Valoare2, PozitiePreferata, ValoarePreferata) :-   
    Pion =:= 2,                        
    Valoare1 < Valoare2,
    PozitiePreferata = [Pion,Lista],
    ValoarePreferata = Valoare1, !;
    Pion =:= 0,                        
    Valoare1 > Valoare2,
    PozitiePreferata = [Pion,Lista],
    ValoarePreferata = Valoare1, !;
    PozitiePreferata = Pozitie2,
    ValoarePreferata = Valoare2,!.

generareStareUrmatoare([0, StareCurenta], [0, StareUrmatoare]) :-
    stariUrmatoare(0, StareCurenta, StareUrmatoare),
    finalizat(StareUrmatoare),!.
    
generareStareUrmatoare([0, StareCurenta], [2, StareUrmatoare]) :-
    stariUrmatoare(0, StareCurenta, StareUrmatoare).

generareStareUrmatoare([2, StareCurenta], [2, StareUrmatoare]) :-
    stariUrmatoare(2, StareCurenta, StareUrmatoare),
    finalizat(StareUrmatoare),!.

generareStareUrmatoare([2, StareCurenta], [0, StareUrmatoare]) :-
    stariUrmatoare(2, StareCurenta, StareUrmatoare).

evaluarePozitie(victorie,0, 0).       
evaluarePozitie(victorie,2, 100).      
evaluarePozitie(egalitate,_, 50).

evaluareFinalizare(Stare,X,Y):-
    stareVictorie(2, Stare)->
    X = victorie,
    Y = 2,!;
    stareVictorie(0, Stare)->
    X = victorie,
    Y = 0,!;
    stareEgalitate(0,Stare)->
    X = egalitate,
    Y = 0,!;
    stareEgalitate(2,Stare)->
    X = egalitate,
    Y = 2,!;
    X = desfasurare,
    Y = 2,!.

finalizat(S):-
    stareVictorie(0, S); 
    stareVictorie(2, S);
    stareEgalitate(0,S);
    stareEgalitate(2,S).