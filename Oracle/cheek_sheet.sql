select * from OSOBY
select * from  Wycieczkimiejsca
select * from REZERWACJE
SEELCT * FROM REZERWACJEWSZYSTKIE

select * from table(uczestnicy_wycieczki(4));


select * from table(rezerwacje_osoby(5));
select * from table(DOSTĘPNE_WYCIECZKI('Polska',TO_DATE('2019-11-09','YYYY-MM-DD'),TO_DATE('2020-12-09','YYYY-MM-DD')));
BEGIN
     DODAJ_REZERWACJE (7,3);
END;

BEGIN
     ZMIEN_STATUS_REZERWACJI (7,'A');
END;
BEGIN
     ZMIEN_LICZBE_MIEJSC(6,99);
END;

SELECT * FROM WYCIECZKIMIEJSCA2;

BEGIN
     DODAJ_REZERWACJE2 (7,2);
END;

SELECT * FROM TABLE(REZERWACJE_OSOBY(2));

commit;
update wycieczki
set LICZBA_WOLNYCH_MIEJSC = 96
where ID_Wycieczki = 6;

delete REZERWACJE
where NR_REZERWACJI = 2