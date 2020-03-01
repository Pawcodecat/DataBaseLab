CREATE OR REPLACE TYPE WYCIECZKA AS OBJECT
(
    id_wycieczki NUMBER,
    nazwa varchar2(100),
    kraj varchar2(50),
    data date,
    opis varchar2(200),
    liczba_miejsc NUMBER
);

CREATE OR REPLACE TYPE WYCIECZKI_TABELA AS TABLE OF WYCIECZKA;

create TYPE UCZESTNIK AS OBJECT
(
    NAZWA           NVARCHAR2(100),
    KRAJ            NVARCHAR2(50),
    DATA            DATE,
    IMIE            NVARCHAR2(50),
    NAZWISKO        NVARCHAR2(50),
    STATUS          CHAR(1)
);

CREATE OR REPLACE TYPE UCZETNICY_TABELA AS TABLE OF UCZESTNIK;

COMMIT;