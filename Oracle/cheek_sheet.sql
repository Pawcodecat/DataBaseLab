select * from table(uczestnicy_wycieczki(4))

select * from table(rezerwacje_osoby(5));

BEGIN
     DODAJ_REZERWACJE (6,1);
END;

BEGIN
     ZMIEN_STATUS_REZERWACJI (6,'P');
END;
BEGIN
     ZMIEN_LICZBE_MIEJSC(6,35);
END;
commit;