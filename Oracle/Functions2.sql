 CREATE OR REPLACE
 FUNCTION dostępne_wycieczki2(kraj varchar2, data_od date, data_do date)
 return WYCIECZKI_TABELA as v_ret WYCIECZKI_TABELA;

     istnieje               Integer;
     BEGIN
         SELECT COUNT(*) INTO istnieje FROM WYCIECZKI
         WHERE WYCIECZKI.KRAJ = dostępne_wycieczki2.kraj AND WYCIECZKI.DATA > dostępne_wycieczki2.data_od AND
               WYCIECZKI.DATA < dostępne_wycieczki2.data_do;

        IF istnieje = 0 THEN
          raise_application_error(-20002, 'Nie znaleziono osoby o podanym id');
        END IF;

        SELECT WYCIECZKA(w.ID_WYCIECZKI, w.NAZWA,w.KRAJ, w.DATA, w.OPIS ,
                                 w.LICZBA_MIEJSC)
            BULK COLLECT INTO v_ret
        FROM WYCIECZKI w
         WHERE w.KRAJ = dostępne_wycieczki2.kraj AND w.DATA > dostępne_wycieczki2.data_od AND
               w.DATA < dostępne_wycieczki2.data_do AND w.LICZBA_WOLNYCH_MIEJSC > 0;
        return v_ret;
     end dostępne_wycieczki2;