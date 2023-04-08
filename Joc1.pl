%Jucatorul este captiv intr-o casa parasita . El isi doreste sa evadeze
%Usa de la intrare este incuiata
%
%Aceste date vor fi modificate pe parcursul jocului
%Pentru ca povestea sa progreseze avem nevoie de modificarea lor

% pentru realizarea mini jocurilor utilizam fisiere externe integrate cu
% ajutorul modulelor

:- module(joc1,[
              dificultate/2,
              incepeJoc/2,
              n/1,s /1,e/1,w/1,
              mananca/2,
              pastreaza/2,
              l/1,r/1,u/1,d/1,
              scrie_cod/2,
              energie/1,
              harta/0,
              mutare/2,
              stopJoc/1,
              inventar/1,
              raspunde_la_Ghicitoare/2,
              inspecteaza/2,
              decizie/3,
              adaugaEnergie/2,
              scadeEnergie/0,
              seJoaca/1,
              mutaCal/2,
              ajutor/1,
              viata/1,
              nivelSelectat/1,
              alege/2,
              restart/1,
              salveaza/1,
              incarca/1,
              descrie/2,
              locatieJucator/1,
              desenare/1,
              locatieObiect/2,
              renunta/2,
              afisareClasament/2,
              energieJucator/1,
              clasament/3,
              sudoku/3,
              afisareSudoku/1,
              afisareLitereDescoperite/1]).


%:- use_module(sliding).
:- use_module(xsi0).
:- use_module(castigare).
:- use_module(piatrafoarfecahartie).
%:- use_module(sudoku).

:- include('literenoi.pl').
:- include('dilema_prizonierilor.pl').
:- include('hunter.pl').
:- include('descriere.pl').
:- include('salvare.pl').
:- include('distribuireObiecte.pl').
:- include('restart.pl').
:- include('controlJocuri.pl').
:- include('harta2.pl').
:- include('gestionareInventar.pl').
:- include('clasament.pl').
:- include('sudoku.pl').
:- include('sliding.pl').
:- include('gestionareTimp.pl').

:- dynamic locatieJucator/1,
    locatieObiect/2,
    viata/1,
    cod_birou/1,
    codReal/1,
    raspunsGhicitoare/1,
    amInceput/1,
    stare/1,
    seJoaca/1,
    jocSliding/1,
    jocXsi0/1,
    jocDilema/1,
    jocHunter/1,
    nivelSelectat/1,
    jocFoarfecahartiepiatra/1,
    jocSudoku/1,
    avemLit1/1,
    avemLit2/1,
    avemLit3/1,
    avemLit4/1,
    avemLit5/1.

jocSliding(disponibil).
jocXsi0(disponibil).
jocDilema(disponibil).
jocHunter(disponibil).
jocFoarfecahartiepiatra(disponibil).
jocSudoku(disponibil).

nivelSelectat(null).

seJoaca(momentanNimic).

locatieJucator(hol). %Se stabileste locatia de pornire a jucatorului
                        %Aceasta se modifica pe parcur in  functie de mutarile jucatorului

%Sunt stabilite rutele de legatura intre camere.
legatura(n,hol,biblioteca).
legatura(w,hol,cameraW).
legatura(e,hol,cameraE).
legatura(s,hol,iesire).

legatura(e,cameraE,cameraEE).
legatura(w,cameraE,hol).
legatura(s,cameraE,cameraES).

legatura(n,cameraES,cameraE).

legatura(w,cameraEE,cameraE).
legatura(n,cameraEE,cameraNE).

%In birou se poate intra cu un cod gasit prin explorarea camerelor
legatura(n,biblioteca,birou):-cod_birou(X),codReal(Y),egale(X,Y).
legatura(n,biblioteca,birou):-
    write(''),nl,fail.
legatura(s,biblioteca,hol).
legatura(e,biblioteca,bucatarie).
legatura(w,biblioteca,cameraNW).

legatura(e,bucatarie,cameraNE).
legatura(w,bucatarie,biblioteca).

legatura(e,cameraNW,biblioteca).
legatura(s,cameraNW,cameraCapcana1).
legatura(n,cameraNW,debara).
legatura(w,cameraNW,cameraCapcana2).

legatura(s,debara,cameraNW).

legatura(n,cameraCapcana1,cameraNW).

legatura(s,cameraNE,cameraEE).
legatura(w,cameraNE,bucatarie).

legatura(e,cameraCapcana2,cameraNW).

legatura(w,cameraW,cameraWW).
legatura(e,cameraW,hol).
legatura(s,cameraW,cameraWS).

legatura(n,cameraWS,cameraW).

legatura(e,cameraWW,cameraW).

legatura(s,birou,biblioteca).

cod_birou(aaaaa).

avemLit1('*').
avemLit2('*').
avemLit3('*').
avemLit4('*').
avemLit5('*').

%jucatorul introduce codul de la lacatul biroului
scrie_cod(X,R):-
    codReal(X1),
    egale(X,X1),
    locatieJucator(biblioteca),
    cod_birou(Y),
    retract(cod_birou(Y)),
    assert(cod_birou(X)),
    atom_concat('','Cod corect',R),!.

scrie_cod(_,R):-
    atom_concat('','Cod incorect',R),!.

egale(X,X).

%Se stabileste locatia obiectelor cu care jucatorul poate interactiona
% Locatia obiectelor poate fi modificata o data ce jucatorul
% interactioneaza cu ele

locatieObiect(carteLitera3,cameraE).
locatieObiect(scrisoareLitera1,cameraEE).
locatieObiect(ghicitoare,cameraW).
locatieObiect(cheie,seif).
locatieObiect(seif,birou).
locatieObiect(carteLitera2,cameraWW).
locatieObiect(bilet,hol).
locatieObiect(lanterna,bucatarie).
locatieObiect(mar,cameraEE).
locatieObiect(biscuit,bucatarie).
locatieObiect(scrisoareLitera5,debara).
locatieObiect(carteLitera4,cameraNE).

% In aceste camere se afla capcane . Daca jucatorul intra aici el va
% pierde o portiune din viata
cameraCapcana(cameraCapcana1).
cameraCapcana(cameraCapcana2).

%Sunt descrise obiectele ce pot fi mancate
%Prin consumarea lor se obtin puncte de energie
comestibil(biscuit).
comestibil(mar).

% Camerele acestea nu sunt luminate . Initial jucatorul nu va putea
% prelua obiecte de aici. Pentru a interactiona xu obiectele din aceste
% camere el are nevoie de o lanterna.
cameraIntunecata(cameraWW).
cameraIntunecata(cameraW).
cameraIntunecata(cameraNE).

%Jucatorul porneste la drum cu un total de 20 de puncte de energie
%Acest total se va modifica in functie de actiunile jucatorului
% energieJucator(40).

energie(X):-
    energieJucator(X),
    write(''),
    write(''),nl.

scadeEnergie():-
    energieJucator(X),
    Y is X-1,
    retract(energieJucator(X)),
    assert(energieJucator(Y)).

%prin acasta functie jucatorul va putea analiza camera in care se afla
%vor fi prezentate obiectele cu care el poate interactiona


cerceteazaCamera(R1):-
    locatieJucator(X),
    bagof(Y,locatieObiect(Y,X),Obiecte),
    scrieObiecte(Obiecte,RO),
    atom_concat('\nObiecte în câmpul tău vizual!\n',RO,R1).
    

cerceteazaCamera(R1):-
    atom_concat('---------------------------------\n',
    'Nu există obiecte în câmpul vizual.',R1).

raspunsGhicitoare(aaaaaaaaa).

raspunde_la_Ghicitoare(X,R):-
    retract(raspunsGhicitoare(_)),
    assert(raspunsGhicitoare(X)),
    egale(cheie,X),
    atom_concat('','Răspuns corect.',R),!.

raspunde_la_Ghicitoare(_,R):-
    atom_concat('','Răspuns incorect.',R),!.

% Dupa consumarea unui obiect comestibil jucatorul primeste 5 puncte de
% energie
mananca(X,R):-
    comestibil(X),
    locatieObiect(X,jucator),
    adaugaEnergie(5,Z),
    retract(locatieObiect(X,jucator)),
    assert(locatieObiect(X,pierdut)),
    atom_concat('Nivelul curent de energie este : ',Z,R),!.

mananca(_,R):-atom_concat('Acest obiect nu este comestibil','',R),!.

% Sitautia sanatatii jucatorului se modifica in functie de pericolele pe
% care le intalneste
viata(100).
scadeViata():-
    viata(X),
    Y is X-50,
    retract(viata(X)),
    assert(viata(Y)).

%Jucatorul va verifica in ce conditie se afla
verificaConditie():-
    viata(X),
    energieJucator(Y),
    write('Condiția ta : '),
    write(X),nl,
    write('Puncte de energie disponibile:'),
    write(Y),nl.

%Directiile in care jucatorul se poate misca
n(T1):- mutaJucator(n,T1).

s(T1):- mutaJucator(s,T1).

e(T1):- mutaJucator(e,T1).

w(T1):- mutaJucator(w,T1).

% acestea Sunt nivelele de dificultate dintr care jucatorul poate alege
nivel(usor,50).
nivel(mediu,40).
nivel(dificil,10).
nivel(imposibil,5).

%Se incepe jocul dupa selectarea nivelului de dificultate
amInceput(nu).

comunicaNivel(X):-
    retract(nivelCurent(_)),
    assert(nivelCurent(X)).

%jucatorul introduce nivelul dorit
dificultate(X,Resp):-
    nivel(X,Y),
    amInceput(nu),
    retract(energieJucator(_)),
    assert(energieJucator(Y)),
    comunicaNivel(X),
    write(''),
    write(''),
    generareCuvant(C1),
    retract(codReal(_)),
    assert(codReal(C1)),
    retract(nivelSelectat(_)),
    assert(nivelSelectat(X)),
    distribuieObiecte(),
    descrie(hol,Camera),
    cerceteazaCamera(Rez1),
    atom_concat(Camera,Rez1,Resp),
    golire(),
    retract(amInceput(nu)),
    assert(amInceput(da)),!.

codReal(aaaaa).

mutaJucator(_,R):-
    amInceput(nu),
    atom_concat('Nu ai selectat nivelul de dificultate!\n','Utilizează comanda nivel(nivelul ales).\n',T1),
    atom_concat(T1,'Ai patru opțiuni: usor, mediu, dificil, imposibil\n',R),!.

% Daca jucatorul e mort el nu se mai poate deplasa intre camere
mutaJucator(_,R):-
    viata(0),
    atom_concat('','Ai murit!!!!',R).
    

% Jucatorul a ramas fara energie si acum e prea epuizat pentru a circula
% intre camere . Problema poate fi rezolvata prin consumarea unor
% alimente.
mutaJucator(_,R):-
    energieJucator(0),
    atom_concat('','Ești epuizat!!!!',R).

% Atunci cand deplasarea intre camere este realizata jucatorul consuma
% energie . Pentru fiecare deplasare reusita este scazut un punct de
% energie.

mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    cameraIntunecata(Z),
    locatieObiect(lanterna,jucator),
    legatura(X,L,Z),
    scadeEnergie(),
    retract(locatieJucator(L)),
    assert(locatieJucator(Z)),
    descrie(Z,H),
    amParcurs(Z),
    cerceteazaCamera(T1),
    atom_concat(H,T1,R),!.


mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,Z),
    cameraIntunecata(Z),
    atom_concat('Este prea întuneric în această cameră.\n','Ai nevoie de o lanternă\n',R).

mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,iesire),
    locatieObiect(cheie,jucator),
    scadeEnergie(),
    retract(locatieJucator(L)),
    assert(locatieJucator(iesire)),
    atom_concat('','Joc Finalizat !! Felicitări !!!!\n',R).

mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,iesire),
    locatieObiect(cheie,seif),
    atom_concat('','Ai nevoie de cheie pentru a evada\n',R).


mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,cameraCapcana1),
    retract(locatieJucator(L)),
    assert(locatieJucator(cameraCapcana1)),
    amParcurs(cameraCapcana1),
    descrie(cameraCapcana1,Z),
    cerceteazaCamera(T1),
    scadeViata(),
    atom_concat(Z,T1,R),!.

mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,cameraCapcana2),
     amParcurs(cameraCapcana2),
    scadeEnergie(),
    retract(locatieJucator(L)),
    assert(locatieJucator(cameraCapcana2)),
    descrie(cameraCapcana2,Z),
    cerceteazaCamera(T1),
    scadeViata(),
    atom_concat(Z,T1,R),!.

mutaJucator(X,R):-
    amInceput(da),
    locatieJucator(L),
    legatura(X,L,Z),
    scadeEnergie(),
    retract(locatieJucator(L)),
    assert(locatieJucator(Z)),
     amParcurs(Z),
    descrie(Z,H),
    cerceteazaCamera(T1),
    atom_concat(H,T1,R),!.

mutaJucator(n,R):-
    amInceput(da),
    locatieJucator(biblioteca),
    atom_concat('','Introdu codul lacătului!\n',R),!.

mutaJucator(_,R):-
        atom_concat('','În direcția aceasta nu se află nimic!\n',R).

inspecteaza(X,R1):-
    locatieObiect(X,jucator),
    amDescoperit(X),
    descrie(X,R1).

inspecteaza(_,X):-atom_concat('','Nu ai acest obiect în rucsac!\n',X).

harta():-locatieJucator(X),descrie(X,_),!.

amDescoperit(X):-
        X=scrisoareLitera1->
        litera1(L1),
        retract(avemLit1(_)),
        assert(avemLit1(L1)),!;
        X=carteLitera2->
        litera2(L2),
        retract(avemLit2(_)),
        assert(avemLit2(L2)),!;
        X=carteLitera3->
        litera3(L3),
        retract(avemLit3(_)),
        assert(avemLit3(L3)),!;
        X=carteLitera4->
        litera4(L4),
        retract(avemLit4(_)),
        assert(avemLit4(L4)),!;
        X=scrisoareLitera5->
        litera5(L5),
        retract(avemLit5(_)),
        assert(avemLit5(L5)),!;
        true,!.

afisareLitereDescoperite(R):-
        avemLitere(R1),
        atom_concat('Parola este : ',R1,R),!.

avemLitere(R):-
        avemLit1(R1),
        avemLit2(R2),
        avemLit3(R3),
        avemLit4(R4),
        avemLit5(R5),
        atom_concat(R1,R2,T1),
        atom_concat(T1,R3,T2),
        atom_concat(T2,R4,T3),
        atom_concat(T3,R5,R),!.