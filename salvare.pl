salveaza(Fisier):-
        jocSliding(A),
        jocXsi0(B),
        jocDilema(C),
        jocHunter(D),
        jocSudoku(E),
        jocFoarfecahartiepiatra(F),
        nivelSelectat(G),
        seJoaca(H),
        locatieJucator(I),
        cod_birou(J),
        locatieObiect(scrisoareLitera1,K),
        locatieObiect(ghicitoare,L),
        locatieObiect(cheie,M),
        locatieObiect(seif,N),
        locatieObiect(carteLitera2,O),
        locatieObiect(bilet,P),
        locatieObiect(lanterna,Q),
        locatieObiect(mar,R),
        locatieObiect(biscuit,S),
        locatieObiect(scrisoareLitera5,T),
        locatieObiect(carteLitera4,U),
        energieJucator(V),
        raspunsGhicitoare(X),
        viata(Y),
        amInceput(Z),
        codReal(Z1),
        atom_concat('C:\\Users\\lenovo\\Documents\\Prolog\\LucrareFilipAlin\\salvari\\',Fisier,Cale),
        atom_concat(Cale,'.txt',Cale1),
        tell(Cale1),
        write(A),write('.\n'),
        write(B),write('.\n'),
        write(C),write('.\n'),
        write(D),write('.\n'),
        write(E),write('.\n'),
        write(F),write('.\n'),
        write(G),write('.\n'),
        write(H),write('.\n'),
        write(I),write('.\n'),
        write(J),write('.\n'),
        write(K),write('.\n'),
        write(L),write('.\n'),
        write(M),write('.\n'),
        write(N),write('.\n'),
        write(O),write('.\n'),
        write(P),write('.\n'),
        write(Q),write('.\n'),
        write(R),write('.\n'),
        write(S),write('.\n'),
        write(T),write('.\n'),
        write(U),write('.\n'),
        write(V),write('.\n'),
        write(X),write('.\n'),
        write(Y),write('.\n'),
        write(Z),write('.\n'),
        write(Z1),write('.\n'),
        told.


incarca(Fisier):-
        atom_concat('C:\\Users\\lenovo\\Documents\\Prolog\\LucrareFilipAlin\\salvari\\',Fisier,Cale),
        atom_concat(Cale,'.txt',Cale1),
        exists_file(Cale1),
        see(Cale1),
        read(A),
        read(B),
        read(C),
        read(D),
        read(E),
        read(F),
        read(G),
        read(H),
        read(I),
        read(J),
        read(K),
        read(L),
        read(M),
        read(N),
        read(O),
        read(P),
        read(Q),
        read(R),
        read(S),
        read(T),
        read(U),
        read(V),
        read(X),
        read(Y),
        read(Z),
        read(Z1),
        seen,
        retract(jocSliding(_)),
        assert(jocSliding(A)),
        retract(jocXsi0(_)),
        assert(jocXsi0(B)),
        retract(jocDilema(_)),
        assert(jocDilema(C)),
        retract(jocHunter(_)),
        assert(jocHunter(D)),
        retract(jocSudoku(_)),
        assert(jocSudoku(E)),
        retract(jocFoarfecahartiepiatra(_)),
        assert(jocFoarfecahartiepiatra(F)),
        retract(nivelSelectat(_)),
        assert(nivelSelectat(G)),
        retract(seJoaca(_)),
        assert(seJoaca(H)),
        retract(locatieJucator(_)),
        assert(locatieJucator(I)),
        retract(cod_birou(_)),
        assert(cod_birou(J)),
        retract(locatieObiect(scrisoareLitera1,_)),
        assert(locatieObiect(scrisoareLitera1,K)),
        retract(locatieObiect(ghicitoare,_)),
        assert(locatieObiect(ghicitoare,L)),
        retract(locatieObiect(cheie,_)),
        assert(locatieObiect(cheie,M)),
        retract(locatieObiect(seif,_)),
        assert(locatieObiect(seif,N)),
        retract(locatieObiect(carteLitera2,_)),
        assert(locatieObiect(carteLitera2,O)),
        retract(locatieObiect(bilet,_)),
        assert(locatieObiect(bilet,P)),
        retract(locatieObiect(lanterna,_)),
        assert(locatieObiect(lanterna,Q)),
        retract(locatieObiect(mar,_)),
        assert(locatieObiect(mar,R)),
        retract(locatieObiect(biscuit,_)),
        assert(locatieObiect(biscuit,S)),
        retract(locatieObiect(scrisoareLitera5,_)),
        assert(locatieObiect(scrisoareLitera5,T)),
        retract(locatieObiect(carteLitera4,_)),
        assert(locatieObiect(carteLitera4,U)),
        retract(energieJucator(_)),
        assert(energieJucator(V)),
        retract(raspunsGhicitoare(_)),
        assert(raspunsGhicitoare(X)),
        retract(viata(_)),
        assert(viata(Y)),
        retract(amInceput(_)),
        assert(amInceput(Z)),
        retract(codReal(_)),
        assert(codReal(Z1)),!.

