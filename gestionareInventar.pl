scrieObiecte([],'--------------------------\nAcestea sunt obiectele descoperite.\n').
scrieObiecte([mar|T],Y):-
    atom_concat('--------------------------\n','măr',T1),
    atom_concat(T1,'\n',T2),
    scrieObiecte(T,T3),
    atom_concat(T2,T3,Y),!.
scrieObiecte([L|T],Y):-
    atom_concat('--------------------------\n',L,T1),
    atom_concat(T1,'\n',T2),
    scrieObiecte(T,T3),
    atom_concat(T2,T3,Y),!.

inventar_curent(Obiecte):-bagof(Y,locatieObiect(Y,jucator),Obiecte),!.
inventar_curent([]).

inventar(R1):-
    inventar_curent(Obiecte),
    scrieObiecte(Obiecte,RO),
    atom_concat('',RO,R1).

inventar(X):-atom_concat('','------------------------\n',X).

apartineNou(G,[G|_]).
apartineNou(G,[_|T]):-apartineNou(G,T),!.

% Prin aceasta metoda jucatorul are posibilitatea de a pastra obiecte in
% rucsacul personal pentru a le folosi mai tarziu
pastreaza(cheie,R1):-
    locatieObiect(seif,jucator),
    raspunsGhicitoare(RG),
    raspunsCurent(Raspunsuri),
    apartineNou(RG,Raspunsuri),
    retract(locatieObiect(cheie,seif)),
    assert(locatieObiect(cheie,jucator)),
    atom_concat('Cheia e la tine!','\n',R1),!.

pastreaza(cheie,R1):-
    locatieObiect(seif,jucator),
    atom_concat('Pentru a deschide seiful trebuie introduse cuvintele cheie!\nMai întâi răspunde la ghicitoare!','\n',R1),!.

pastreaza(Y,X):-
    locatieObiect(Y,jucator),
    atom_concat('\u00CEl avem deja !\n','',X),!.

pastreaza(Y,R1):-
    locatieObiect(Y,X),
    locatieJucator(X),
    inventar_curent(Obiecte),
    length(Obiecte,NumarInventar),
    NumarInventar < 6,
    retract(locatieObiect(Y, X)),
    assert(locatieObiect(Y, jucator)),
    atom_concat('Obiectul a fost plasat în inventar!','\n',R1),!.

pastreaza(Y,R1):-
    locatieObiect(Y,X),
    locatieJucator(X),
    inventar_curent(Obiecte),
    length(Obiecte,NumarInventar),
    NumarInventar > 5,
    atom_concat('Inventarul este plin!','\n',R1),!.


pastreaza(Y,X):-
    locatieObiect(Y,_),
    atom_concat('Acțiune imposibilă. Nu văd obiectul : ',Y,X),!.

renunta(Y,R):-
    locatieObiect(Y,jucator),
    locatieJucator(X),
    retract(locatieObiect(Y,_)),
    assert(locatieObiect(Y,X)),
    atom_concat('Obiectul a fost aruncat!','\n',R),!.

renunta(_,R):-
    atom_concat('Acest obiect nu este în inventar!','\n',R),!.
