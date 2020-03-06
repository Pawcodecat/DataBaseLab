CREATE OR REPLACE PROCEDURE
    DODAJ_REZERWACJE2(ID_wycieczki WYCIECZKI.ID_WYCIECZKI%TYPE,
                     ID_osoby OSOBY.ID_OSOBY%TYPE)
AS
    istnieje_osoba     INT;
    dostępna_wycieczka   INT;
    istnieje_rezerwacja INT;
    ID_nowej_rezerwacji INT;
BEGIN
    -- sprawdź czy osoba istnieje, jeśli tak to istnieje_osoba  > 0
    SELECT COUNT(*) INTO istnieje_osoba FROM OSOBY WHERE OSOBY.ID_OSOBY = DODAJ_REZERWACJE2.ID_osoby;

    IF istnieje_osoba = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nie znaleziono osoby z tym ID.');
    END IF;

    -- sprawdź czy istnieje wycieczka (czy jest w przyszłości i czy są wolne miejsca)
    SELECT COUNT(*)
    INTO dostępna_wycieczka
    FROM WYCIECZKIDOSTĘPNE
    WHERE WYCIECZKIDOSTĘPNE.ID_WYCIECZKI = DODAJ_REZERWACJE2.ID_wycieczki;

    IF dostępna_wycieczka = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Wycieczka z tym ID nie jest dostępna');
    END IF;

    -- sprawdź czy istnieje rezerwacja
    SELECT COUNT(*)
    INTO istnieje_rezerwacja
    FROM REZERWACJE
    WHERE REZERWACJE.ID_WYCIECZKI = DODAJ_REZERWACJE2.ID_wycieczki
      AND REZERWACJE.ID_OSOBY = DODAJ_REZERWACJE2.ID_osoby;

    IF istnieje_rezerwacja > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Rezerwacja owyczieczki o podanym id istnieje dla osoby o podanym id');
    END IF;
    SET TRANSACTION READ WRITE;

        INSERT INTO REZERWACJE (ID_WYCIECZKI, ID_OSOBY, STATUS)
        VALUES (DODAJ_REZERWACJE2.ID_wycieczki, DODAJ_REZERWACJE2.ID_osoby, 'N')
        RETURNING NR_REZERWACJI INTO ID_nowej_rezerwacji;

        INSERT INTO REZERWACJE_LOG (ID_REZERWACJI, DATA, STATUS)
        VALUES (ID_nowej_rezerwacji, CURRENT_DATE, 'N');

        UPDATE WYCIECZKI
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC -1
        WHERE ID_WYCIECZKI = DODAJ_REZERWACJE2.ID_wycieczki;
    COMMIT;
    ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE
    ZMIEN_STATUS_REZERWACJI2(ID_rezerwacji REZERWACJE.NR_REZERWACJI%TYPE,
                            status REZERWACJE.STATUS%TYPE)
AS
    stary_status  REZERWACJE.STATUS%TYPE;
    wycieczka_istnieje INT;
    nowe_miejsce INT;
BEGIN
    --sprawdź czy wycieczka istnieje
    SELECT COUNT(*)
    INTO wycieczka_istnieje
    FROM WYCIECZKIDOSTĘPNE wp
             JOIN REZERWACJE r ON wp.ID_WYCIECZKI = r.ID_WYCIECZKI
    WHERE r.ID_WYCIECZKI = ZMIEN_STATUS_REZERWACJI2.ID_rezerwacji;

    IF wycieczka_istnieje = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Nie znaleziono wycieczki z tym ID');
    END IF;

    SELECT STATUS INTO stary_status FROM REZERWACJE r WHERE r.NR_REZERWACJI = ZMIEN_STATUS_REZERWACJI2.ID_REZERWACJI;

    -- status 'N' (nowy) może być zmieniony na każdy status
    -- status 'P' (potwierdzony) może być zmieniony na status 'Z' lub 'A'
    -- status 'Z' (potwierdzony i zapłacony) może być zmieniony na status 'A'
    -- status 'A' nie może być zmieniony na iny status
    CASE
        WHEN stary_status IS NULL
            THEN RAISE_APPLICATION_ERROR(-20005, 'Rezerwacja z tym ID nie istnieje');

        WHEN stary_status = 'A'
            THEN RAISE_APPLICATION_ERROR(-20006, 'Status A odwołanej rezerwacji nie może być zmieniony');

        WHEN stary_status = 'P'
            THEN IF (ZMIEN_STATUS_REZERWACJI2.status <> 'Z'
                AND ZMIEN_STATUS_REZERWACJI2.status <> 'A') THEN
                RAISE_APPLICATION_ERROR(-20006,
                                        'Status potwierdzonej rezerwacji może być zmieniony' ||
                                        'na "Z" (potwierdzona i zapłacona) lub "A" (odwołana).');
            END IF;

        WHEN stary_status = 'Z'
            THEN IF ZMIEN_STATUS_REZERWACJI2.status <> 'A' THEN
                RAISE_APPLICATION_ERROR(-20006,
                                        'Status potwierdzonej i zapłaconej rezerwacji ("Z") może być zmieniony tylko' ||
                                        'na "A" (odwołany).');
            END IF;


        ELSE
            RAISE_APPLICATION_ERROR(-20999, 'Błąd wewnętrzny aplikacji');
        END CASE;

    IF ZMIEN_STATUS_REZERWACJI2.status = 'A' THEN
        nowe_miejsce := 1;
    ELSE
        nowe_miejsce :=0;
    END IF;

    SET TRANSACTION READ WRITE;
        UPDATE REZERWACJE
        SET STATUS = ZMIEN_STATUS_REZERWACJI2.status
        WHERE NR_REZERWACJI = ZMIEN_STATUS_REZERWACJI2.ID_rezerwacji;

        INSERT INTO REZERWACJE_LOG (ID_REZERWACJI, DATA, STATUS)
        VALUES (ZMIEN_STATUS_REZERWACJI2.ID_rezerwacji, CURRENT_DATE, ZMIEN_STATUS_REZERWACJI2.status);

        UPDATE WYCIECZKI w
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC + nowe_miejsce
        WHERE ID_WYCIECZKI = (SELECT ID_WYCIECZKI FROM REZERWACJE r
                              WHERE r.NR_REZERWACJI = ZMIEN_STATUS_REZERWACJI2.ID_rezerwacji);

    COMMIT;
    ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE
    ZMIEN_LICZBE_MIEJSC2(ID_wycieczki WYCIECZKI.ID_WYCIECZKI%TYPE,
                        nowa_liczba_miejsc WYCIECZKI.LICZBA_MIEJSC%TYPE)
AS
    zarezerwowane_miejsca INT;
BEGIN
    --jeśli wycieczka nie istnieje rzuć błąd
    SELECT w.LICZBA_MIEJSC - w.LICZBA_WOLNYCH_MIEJSC
    INTO zarezerwowane_miejsca
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = ZMIEN_LICZBE_MIEJSC2.ID_wycieczki;

    IF nowa_liczba_miejsc < 0 OR zarezerwowane_miejsca > nowa_liczba_miejsc
    THEN
        raise_application_error(-20007,
                                'Nowa liczba miejsc jest za mała (mniejsza od 0 lub mniejsza niż liczba zarezerwowanych miejsc');
    END IF;
    SET TRANSACTION READ WRITE;
    UPDATE WYCIECZKI
    SET LICZBA_MIEJSC = ZMIEN_LICZBE_MIEJSC2.nowa_liczba_miejsc,
        LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC + (ZMIEN_LICZBE_MIEJSC2.nowa_liczba_miejsc - LICZBA_MIEJSC)
    WHERE ID_WYCIECZKI = ZMIEN_LICZBE_MIEJSC2.ID_wycieczki;


    COMMIT;
    ROLLBACK;


-- złap wyjątek i wypisz komunikat o błędzie
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nie znaleziono wycieczki z tym ID');
END;

