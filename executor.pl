:- use_module(text).

executor(X,A1,A2,F):-
        apartine(X,[nivel,dificultate,level]) ->
        dificultate(A1,Resp),
        atom_concat("Ai selectat nivelul de dificultate : ", A1,R1),
        atom_concat(R1,"\n",R2),
        atom_concat(R2,Resp,R),
        modificareTextPrezentat(F,R)
        ,!;
        X = energie ->
        energie(R1),
        atom_concat("Energia ta : ", R1,R2),
        modificareTextPrezentat(F,R2)
        ,!;
        X = inventar -> 
        inventar(R4),
        modificareTextPrezentat(F,R4),
        !;
        X = decizie -> 
        decizie(A1,R8,R9),
        aduagaPuncte(R9,R10),
        atom_concat(R8,R10,R11),
        modificareTextPrezentat(F,R11),
        !;
        apartine(X,[pastreaza,păstrează,'P\u0103streaz\u0103',ridica,colecteaza])  ->
        pastreaza(A1,R12),
        modificareTextPrezentat(F,R12),
        !;
        apartine(X,[joc,joaca,incepeJoc,incepejoc,play,incepe,start]) , A1 = sudoku ->
        incepeJoc(A1,R3),
        modificareTextPrezentat(F,R3),
        ecransudoku(R3,F),
        !;
        apartine(X,[joc,joaca,incepeJoc,incepejoc,play,incepe,start]) ->
        incepeJoc(A1,R3),
        modificareTextPrezentat(F,R3),
        !;
        apartine(X,['M\u0103n\u00E2nc\u0103',mananca,consuma])->
        mananca(A1,R31),
        modificareTextPrezentat(F,R31),
        !;
        X = 'Foarfec\u0103-H\u00E2rtie-Piatr\u0103' ->
        alege(A1,R),
        modificareTextPrezentat(F,R),
        !;
        apartine(X,['Inspecteaz\u0103',inspecteaza,citeste,analizeaza]) ->
        inspecteaza(A1,R3),
        modificareTextPrezentat(F,R3),
        !;
        apartine(X,['Salveaz\u0103',salveaza,salvare,save]) ->
        salveaza(A1),
        atom_concat("Joc salvat!\n",'',R),
        modificareTextPrezentat(F,R),
        !;
        apartine(X,[clasament,top,scor]) ->
        afisareClasament(A1,R),
        modificareTextPrezentat(F,R),
        !;
        X = '\u00CEncarc\u0103', incarca(A1)->
        locatieJucator(Juc),
        numarPlanCasa(NRPC),
        descrieCamera(NRPC,Juc,R1),
        mesajIncarcare(M1),
        atom_concat(M1,R1,R),
        modificareTextPrezentat(F,R),
        !;
        X = '\u00CEncarc\u0103', \+ incarca(A1) ->
        eroareIncarcare(E1),
        atom_concat(E1,'',R),
        modificareTextPrezentat(F,R),
        !;
        X = 'Op\u021Biuni' ->
        directory_files('LucrareFilipAlin\\salvari',[_,_|Fisiere]),
        scriefisiere(Fisiere,Scriere),
        atom_concat("Versiuni salvate!\n",Scriere,R),
        modificareTextPrezentat(F,R),
        !;
        X = sudoku->
        atom_number(A1, A11),
        atom_number(A2, A21),
        sudoku(A11,A21,R),
        modificareTextPrezentat(F,R),
        !;
        X = 'Via\u021B\u0103' ->
        viata(R31),
        mesajViata(M2),
        atom_concat(M2,R31,R312),
        modificareTextPrezentat(F,R312),
        !;
        X = ajutor,nivelSelectat(imposibil) ->
        eroareAjutor(E2),
        atom_concat(E2,'',R),
        modificareTextPrezentat(F,R),
        !;
        X = ajutor,ajutor2(disponibil) ->
        ajutor(R23),
        modificareTextPrezentat(F,R23),
        !;
        X = ajutor,ajutor2(indisponibil) ->
        atom_concat('Ai utilizat indiciul disponibil!\n','',R),
        modificareTextPrezentat(F,R),
        !;
        apartine(X,[restart,reset]) ->
        restart(R),
        modificareTextPrezentat(F,R),
        !;
        apartine(X,['Arunc\u0103',arunca,renunta,elibereaza,drop]) ->
        renunta(A1,R),
        modificareTextPrezentat(F,R),
        !;
        apartine(X,[scrieCod,cod,scriecod,codul]) ->
        scrie_cod(A1,R20),
        modificareTextPrezentat(F,R20),!;
        X = ghicitoare ->
        raspunde_la_Ghicitoare(A1,R21),
        modificareTextPrezentat(F,R21)
        ,!;
        X = parola ->
        afisareLitereDescoperite(R),
        modificareTextPrezentat(F,R)
        ,!;
        X = bandajare ->
        bandajeaza(R),
        modificareTextPrezentat(F,R)
        ,!;
        X = 'Repar\u0103', A1 = lanterna ->
        repara(R),
        modificareTextPrezentat(F,R)
        ,!;
        X = 'Loca\u021Bie' ->
        locatieJucator(Loc),
        numarPlanCasa(NRPC),
        descrieCamera(NRPC,Loc,R1),
        cerceteazaCamera(T1),
        atom_concat(R1,T1,R),
        modificareTextPrezentat(F,R)
        ,!;
        eroareComanda(E3),
        atom_concat(E3, X,R),
        modificareTextPrezentat(F,R),!.