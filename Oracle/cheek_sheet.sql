select * from OSOBY
select * from  Wycieczkimiejsca
select * from REZERWACJE

select * from table(uczestnicy_wycieczki(4))

select * from table(rezerwacje_osoby(5));

BEGIN
     DODAJ_REZERWACJE (6,2);
END;

BEGIN
     ZMIEN_STATUS_REZERWACJI (6,'P');
END;
BEGIN
     ZMIEN_LICZBE_MIEJSC(6,35);
END;

SELECT * FROM WYCIECZKIMIEJSCA2;

BEGIN
     DODAJ_REZERWACJE2 (7,2);
END;

SELECT * FROM TABLE(REZERWACJE_OSOBY(2));

commit;