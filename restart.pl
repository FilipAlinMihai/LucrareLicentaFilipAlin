restart(X):-
        golire(),
        retract(camereLibere(_)),
        assert(camereLibere([hol,biblioteca,cameraE,
        cameraES,cameraEE,debara,bucatarie,
        cameraNW,cameraW,cameraWW,cameraWS,cameraNE])),
        retract(jocSliding(_)),
        assert(jocSliding(disponibil)),
        retract(jocXsi0(_)),
        assert(jocXsi0(disponibil)),
        retract(jocDilema(_)),
        assert(jocDilema(disponibil)),
        retract(jocHunter(_)),
        assert(jocHunter(disponibil)),
        retract(jocSudoku(_)),
        assert(jocSudoku(disponibil)),
        retract(jocFoarfecahartiepiatra(_)),
        assert(jocFoarfecahartiepiatra(disponibil)),
        retract(nivelSelectat(_)),
        assert(nivelSelectat(null)),
        retract(seJoaca(_)),
        assert(seJoaca(momentanNimic)),
        retract(locatieJucator(_)),
        assert(locatieJucator(hol)),
        retract(cod_birou(_)),
        assert(cod_birou(aaaaa)),
        retract(locatieObiect(carteLitera3,_)),
        assert(locatieObiect(carteLitera3,cameraE)),
        retract(locatieObiect(scrisoareLitera1,_)),
        assert(locatieObiect(scrisoareLitera1,cameraEE)),
        retract(locatieObiect(ghicitoare,_)),
        assert(locatieObiect(ghicitoare,cameraW)),
        retract(locatieObiect(cheie,_)),
        assert(locatieObiect(cheie,seif)),
        retract(locatieObiect(seif,_)),
        assert(locatieObiect(seif,birou)),
        retract(locatieObiect(carteLitera2,_)),
        assert(locatieObiect(carteLitera2,cameraWW)),
        retract(locatieObiect(bilet,_)),
        assert(locatieObiect(bilet,hol)),
        retract(locatieObiect(lanterna,_)),
        assert(locatieObiect(lanterna,bucatarie)),
        retract(locatieObiect(mar,_)),
        assert(locatieObiect(mar,cameraEE)),
        retract(locatieObiect(biscuit,_)),
        assert(locatieObiect(biscuit,bucatarie)),
        retract(locatieObiect(scrisoareLitera5,_)),
        assert(locatieObiect(scrisoareLitera5,debara)),
        retract(locatieObiect(carteLitera4,_)),
        assert(locatieObiect(carteLitera4,cameraNE)),
        retract(energieJucator(_)),
        assert(energieJucator(0)),
        retract(raspunsGhicitoare(_)),
        assert(raspunsGhicitoare(aaaaaaaaa)),
        retract(viata(_)),
        assert(viata(100)),
        retract(amInceput(_)),
        assert(amInceput(nu)),
        retract(codReal(_)),
        assert(codReal(aaaaa)),
        atom_concat('
                           Evadeaza din captivitate.\n
                           Da dovada de gandire logica.\n
                           Demonstreaza aptitudinile tale de strateg.\n
                            ','',X),!.