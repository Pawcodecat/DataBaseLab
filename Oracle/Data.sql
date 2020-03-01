INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Adam', 'Kowalski', '87654321', 'tel: 6623');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Nowak', '12345678', 'tel: tel: 2312, dzwonić po 18.00');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Paweł', 'Wójcik', '32154321', 'tel: 54352542');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Michał', 'Wiśniewski', '12345438', 'tel: 24524522, dzwonić po 18.00');
VALUES('Adam', 'Noga', '32154321', 'tel: 5452442');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Grzegorz', 'Szpak', '12376438', 'tel: 523424, dzwonić po 18.00');
VALUES('Kamil', 'Noga', '33143121', 'tel: 1312871');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Karol', 'Gawron', '54389438', 'tel: 643231, dzwonić po 20.00');
VALUES('Anna', 'Lewska', '67981234', 'tel: 569823432');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Diana', 'Mazak', '34124242', 'tel: 269834097, dzwonić po 19.00');


INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wycieczka do Paryza','Francja',TO_DATE('2019-12-09','YYYY-MM-DD'),'Ciekawa wycieczka ',31);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Piękny Kraków','Polska',TO_DATE('2018-10-12','YYYY-MM-DD'),'Najciekawa wycieczka ',54);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka','Polska',TO_DATE('2020-04-09','YYYY-MM-DD'),'Zadziwiająca kopalnia ',46);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Warszawa','Polska',TO_DATE('2020-05-18','YYYY-MM-DD'),'Stolica dla nas ',42);

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,1,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,2,'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6,3,'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (7,4,'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,5,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,6,'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6,7,'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (7,8,'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4,9,'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5,10,'P');
