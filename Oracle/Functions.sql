CREATE OR REPLACE TYPE UCZESTNIK AS OBJECT
(
    NAZWA           NVARCHAR2(100),
    KRAJ            NVARCHAR2(50),
    DATA            DATE,
    IMIE            NVARCHAR2(50),
    NAZWISKO        NVARCHAR2(50),
    STATUS          CHAR(1)
)/


CREATE OR REPLACE TYPE uczestnicy_tabela IS TABLE OF UCZESTNIK;

CREATE OR REPLACE
FUNCTION uczestnicy_wycieczki(id INT)
  return uczestnicy_tabela as v_ret uczestnicy_tabela;
  istnieje                          integer;
  BEGIN
    SELECT COUNT(*) INTO istnieje FROM WYCIECZKI WHERE WYCIECZKI.ID_WYCIECZKI = id;

    IF istnieje = 0 THEN
      raise_application_error(-20001, 'Nie znaleziono wycieczki o podanym id');
    END IF;

    SELECT UCZESTNIK(w.NAZWA,w.KRAJ, w.DATA,  o.IMIE,
                             o.NAZWISKO, r.STATUS)
        BULK COLLECT INTO v_ret
    FROM WYCIECZKI w
           JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
           JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
    WHERE w.ID_WYCIECZKI = id AND r.STATUS <> 'A';
    RETURN v_ret;
  END uczestnicy_wycieczki;

CREATE OR REPLACE TYPE UCZESTNIK AS OBJECT
(
    NAZWA           NVARCHAR2(100),
    KRAJ            NVARCHAR2(50),
    DATA            DATE,
    IMIE            NVARCHAR2(50),
    NAZWISKO        NVARCHAR2(50),
    STATUS          CHAR(1)
)/


CREATE OR REPLACE TYPE uczestnicy_tabela IS TABLE OF UCZESTNIK;

CREATE OR REPLACE
FUNCTION rezerwacje_osoby(id_osoby INT)
  return uczestnicy_tabela as v_ret uczestnicy_tabela;
  istnieje                          integer;
  BEGIN
    SELECT COUNT(*) INTO istnieje FROM OSOBY WHERE OSOBY.ID_OSOBY = rezerwacje_osoby.id_osoby;

    IF istnieje = 0 THEN
      raise_application_error(-20002, 'Nie znaleziono osoby o podanym id');
    END IF;

    SELECT uczestnik(w.NAZWA,w.KRAJ, w.DATA,  o.IMIE,
                             o.NAZWISKO, r.STATUS)
        BULK COLLECT INTO v_ret
    FROM WYCIECZKI w
           JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
           JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
    WHERE o.ID_OSOBY = rezerwacje_osoby.id_osoby AND r.STATUS <> 'A'
    AND w.LICZBA_MIEJSC > (
        SELECT COUNT(*)
        FROM REZERWACJE
        WHERE r.STATUS <> 'A' AND r.ID_WYCIECZKI = w.ID_WYCIECZKI);
    return v_ret;
  end rezerwacje_osoby;

 CREATE OR REPLACE
 FUNCTION dostępne_wycieczki(kraj varchar2, data_od date, data_do date)
 return WYCIECZKI_TABELA as v_ret WYCIECZKI_TABELA;

     istnieje               Integer;
     BEGIN
         SELECT COUNT(*) INTO istnieje FROM WYCIECZKI
         WHERE WYCIECZKI.KRAJ = dostępne_wycieczki.kraj AND WYCIECZKI.DATA > dostępne_wycieczki.data_od AND
               WYCIECZKI.DATA < dostępne_wycieczki.data_do;

        IF istnieje = 0 THEN
          raise_application_error(-20002, 'Nie znaleziono osoby o podanym id');
        END IF;

        SELECT WYCIECZKA(w.ID_WYCIECZKI, w.NAZWA,w.KRAJ, w.DATA, w.OPIS ,
                                 w.LICZBA_MIEJSC)
            BULK COLLECT INTO v_ret
        FROM WYCIECZKI w
         WHERE w.KRAJ = dostępne_wycieczki.kraj AND w.DATA > dostępne_wycieczki.data_od AND
               w.DATA < dostępne_wycieczki.data_do;
        return v_ret;
     end dostępne_wycieczki;



