use msdb
go
DROP DATABASE IF EXISTS Szkola
GO

CREATE DATABASE Szkola
GO
USE Szkola

GO


DROP TABLE IF EXISTS dbo.Wyniki_egzaminow;
DROP TABLE IF EXISTS dbo.Egzaminy;
DROP TABLE IF EXISTS dbo.Rodzaje_egzaminow;
DROP TABLE IF EXISTS dbo.Frekwencja;
DROP TABLE IF EXISTS dbo.Powody_nieobecnosci;
DROP TABLE IF EXISTS dbo.Kursy_nauczycieli;
DROP TABLE IF EXISTS dbo.Oceny;
DROP TABLE IF EXISTS dbo.Typy_ocen;
DROP TABLE IF EXISTS dbo.Harmonogramy_przedmiotow;
DROP TABLE IF EXISTS dbo.Przedmioty;
DROP TABLE IF EXISTS dbo.Uczniowie;
DROP TABLE IF EXISTS dbo.Rodzice;
DROP TABLE IF EXISTS dbo.Sale;
DROP TABLE IF EXISTS dbo.Klasy;
DROP TABLE IF EXISTS dbo.Nauczyciele;
DROP TABLE IF EXISTS dbo.Adresy;

CREATE TABLE dbo.Adresy (
    ID_adresu INT IDENTITY(1,1) PRIMARY KEY,
    Ulica NVARCHAR(100),
    Miasto NVARCHAR(50),
    Kod_pocztowy NVARCHAR(10)
);

CREATE TABLE dbo.Nauczyciele (
    ID_nauczyciela INT IDENTITY(1,1) PRIMARY KEY,
    Imie NVARCHAR(50) NOT NULL,
    Nazwisko NVARCHAR(50) NOT NULL,
    ID_adresu INT,
    Data_zatrudnienia DATE NOT NULL,
    Pensja DECIMAL(10, 2),
    Poziom_nauczyciela NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Nauczyciele_Adresy FOREIGN KEY (ID_adresu) REFERENCES dbo.Adresy(ID_adresu),
    CONSTRAINT CK_Nauczyciele_Poziom CHECK (Poziom_nauczyciela IN ('Junior', 'Senior'))
);

CREATE TABLE dbo.Klasy (
    ID_klasy INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_klasy NVARCHAR(10) NOT NULL,
    ID_wychowawcy INT,
    Liczba_uczniow INT,
    Sala NVARCHAR(10),
    Poziom_klasy NVARCHAR(50),
    CONSTRAINT FK_Klasy_Nauczyciele FOREIGN KEY (ID_wychowawcy) REFERENCES dbo.Nauczyciele(ID_nauczyciela)
);

CREATE TABLE dbo.Uczniowie (
    ID_ucznia INT IDENTITY(1,1) PRIMARY KEY,
    Imie NVARCHAR(50) NOT NULL,
    Nazwisko NVARCHAR(50) NOT NULL,
    Data_urodzenia DATE NOT NULL,
    ID_adresu INT,
    ID_klasy INT,
    Grupa_dodatkowa NVARCHAR(100) DEFAULT NULL,
    CONSTRAINT FK_Uczniowie_Adresy FOREIGN KEY (ID_adresu) REFERENCES dbo.Adresy(ID_adresu),
    CONSTRAINT FK_Uczniowie_Klasy FOREIGN KEY (ID_klasy) REFERENCES dbo.Klasy(ID_klasy)
);

CREATE TABLE dbo.Przedmioty (
    ID_przedmiotu INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_przedmiotu NVARCHAR(100) NOT NULL,
    ID_nauczyciela INT,
    Poziom_trudnosci NVARCHAR(50),
    Liczba_godzin INT,
    CONSTRAINT FK_Przedmioty_Nauczyciele FOREIGN KEY (ID_nauczyciela) REFERENCES dbo.Nauczyciele(ID_nauczyciela)
);
CREATE TABLE dbo.Harmonogramy_przedmiotow (
    ID_harmonogramu INT IDENTITY(1,1) PRIMARY KEY,
    ID_przedmiotu INT,
    ID_klasy INT,
    Dzien_zajec NVARCHAR(20),
    Godzina_zajec TIME,
    Semestr INT,
    CONSTRAINT FK_Harmonogramy_Przedmioty FOREIGN KEY (ID_przedmiotu) REFERENCES dbo.Przedmioty(ID_przedmiotu),
    CONSTRAINT FK_Harmonogramy_Klasy FOREIGN KEY (ID_klasy) REFERENCES dbo.Klasy(ID_klasy)
);

CREATE TABLE dbo.Typy_ocen (
    ID_typu_oceny INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_typu_oceny NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Oceny (
    ID_oceny INT IDENTITY(1,1) PRIMARY KEY,
    ID_ucznia INT,
    ID_przedmiotu INT,
    Ocena INT NOT NULL,
    Data DATE NOT NULL,
    ID_typu_oceny INT,
    Uwagi NVARCHAR(MAX),
    CONSTRAINT CK_Oceny_Ocena CHECK (Ocena BETWEEN 1 AND 6),
    CONSTRAINT FK_Oceny_Uczniowie FOREIGN KEY (ID_ucznia) REFERENCES dbo.Uczniowie(ID_ucznia),
    CONSTRAINT FK_Oceny_Przedmioty FOREIGN KEY (ID_przedmiotu) REFERENCES dbo.Przedmioty(ID_przedmiotu),
    CONSTRAINT FK_Oceny_Typy FOREIGN KEY (ID_typu_oceny) REFERENCES dbo.Typy_ocen(ID_typu_oceny)
);

CREATE TABLE dbo.Rodzice (
    ID_rodzica INT IDENTITY(1,1) PRIMARY KEY,
    Imie NVARCHAR(50) NOT NULL,
    Nazwisko NVARCHAR(50) NOT NULL,
    Telefon NVARCHAR(15),
    ID_adresu INT,
    E_mail NVARCHAR(100),
    CONSTRAINT FK_Rodzice_Adresy FOREIGN KEY (ID_adresu) REFERENCES dbo.Adresy(ID_adresu)
);

CREATE TABLE dbo.Powody_nieobecnosci (
    ID_powodu_nieobecnosci INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_powodu NVARCHAR(100)
);

CREATE TABLE dbo.Frekwencja (
    ID_frekwencji INT IDENTITY(1,1) PRIMARY KEY,
    ID_ucznia INT,
    ID_przedmiotu INT,
    Data DATE,
    Obecnosc BIT,
    ID_powodu_nieobecnosci INT,
    CONSTRAINT FK_Frekwencja_Uczniowie FOREIGN KEY (ID_ucznia) REFERENCES dbo.Uczniowie(ID_ucznia),
    CONSTRAINT FK_Frekwencja_Przedmioty FOREIGN KEY (ID_przedmiotu) REFERENCES dbo.Przedmioty(ID_przedmiotu),
    CONSTRAINT FK_Frekwencja_Powody FOREIGN KEY (ID_powodu_nieobecnosci) REFERENCES dbo.Powody_nieobecnosci(ID_powodu_nieobecnosci)
);

CREATE TABLE dbo.Sale (
    ID_sali INT IDENTITY(1,1) PRIMARY KEY,
    Numer_sali NVARCHAR(10),
    Przeznaczenie NVARCHAR(100),
    Pietro INT,
    Sprzet_multimedialny BIT,
    Stan_techniczny NVARCHAR(50)
);

CREATE TABLE dbo.Rodzaje_egzaminow (
    ID_rodzaju_egzaminu INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_rodzaju NVARCHAR(50)
);

CREATE TABLE dbo.Egzaminy (
    ID_egzaminu INT IDENTITY(1,1) PRIMARY KEY,
    ID_przedmiotu INT,
    ID_klasy INT,
    Data_egzaminu DATE NOT NULL,
    ID_rodzaju_egzaminu INT,
    Uwagi NVARCHAR(MAX),
    ID_nauczyciela INT,
    CONSTRAINT FK_Egzaminy_Przedmioty FOREIGN KEY (ID_przedmiotu) REFERENCES dbo.Przedmioty(ID_przedmiotu),
    CONSTRAINT FK_Egzaminy_Klasy FOREIGN KEY (ID_klasy) REFERENCES dbo.Klasy(ID_klasy),
    CONSTRAINT FK_Egzaminy_Nauczyciele FOREIGN KEY (ID_nauczyciela) REFERENCES dbo.Nauczyciele(ID_nauczyciela),
    CONSTRAINT FK_Egzaminy_Rodzaje FOREIGN KEY (ID_rodzaju_egzaminu) REFERENCES dbo.Rodzaje_egzaminow(ID_rodzaju_egzaminu)
);

CREATE TABLE dbo.Wyniki_egzaminow (
    ID_wyniku INT IDENTITY(1,1) PRIMARY KEY,
    ID_ucznia INT,
    ID_egzaminu INT,
    Wynik INT NOT NULL,
    Komentarz NVARCHAR(MAX),
    CONSTRAINT CK_Wyniki_Wynik CHECK (Wynik BETWEEN 0 AND 100),
    CONSTRAINT FK_Wyniki_Uczniowie FOREIGN KEY (ID_ucznia) REFERENCES dbo.Uczniowie(ID_ucznia),
    CONSTRAINT FK_Wyniki_Egzaminy FOREIGN KEY (ID_egzaminu) REFERENCES dbo.Egzaminy(ID_egzaminu)
);

CREATE TABLE dbo.Kursy_nauczycieli (
    ID_kursu INT IDENTITY(1,1) PRIMARY KEY,
    ID_nauczyciela INT,
    Nazwa_kursu NVARCHAR(100),
    Data_rozpoczecia DATE,
    Data_zakonczenia DATE,
    CONSTRAINT FK_Kursy_Nauczyciele FOREIGN KEY (ID_nauczyciela) REFERENCES dbo.Nauczyciele(ID_nauczyciela)
);

-- Adresy
INSERT INTO dbo.Adresy (Ulica, Miasto, Kod_pocztowy) VALUES
('Warszawska 1', 'Warszawa', '00-001'),
('Krakowska 23', 'Kraków', '31-001'),
('Gdańska 15', 'Gdańsk', '80-001'),
('Wrocławska 45', 'Wrocław', '50-001'),
('Poznańska 67', 'Poznań', '60-001'),
('Łódzka 89', 'Łódź', '90-001'),
('Katowicka 32', 'Katowice', '40-001'),
('Lubliniecka 7', 'Lublin', '20-001'),
('Białostocka 11', 'Białystok', '15-001'),
('Szczecińska 21', 'Szczecin', '70-001');

-- Powody_nieobecnosci
INSERT INTO dbo.Powody_nieobecnosci (Nazwa_powodu) VALUES
('Choroba'),
('Wycieczka szkolna'),
('Zwolnienie lekarskie'),
('Problemy rodzinne'),
('Sprawy osobiste'),
('Wypadek'),
('Sprawy urzędowe'),
('Inne'),
('Nieusprawiedliwione'),
('Przebywanie w szpitalu');

-- Typy_ocen
INSERT INTO dbo.Typy_ocen (Nazwa_typu_oceny) VALUES
('Sprawdzian'),
('Kartkówka'),
('Projekt'),
('Aktywność'),
('Praca domowa'),
('Egzamin'),
('Test końcowy'),
('Kolokwium'),
('Prezentacja'),
('Laboratorium');

-- Rodzaje_egzaminow
INSERT INTO dbo.Rodzaje_egzaminow (Nazwa_rodzaju) VALUES
('Pisany'),
('Ustny'),
('Projekt'),
('Praktyczny'),
('Prezentacja'),
('Końcowy'),
('Wielokrotnego wyboru'),
('Kolokwium'),
('Zadanie otwarte'),
('Laboratoryjny');

-- Nauczyciele
INSERT INTO dbo.Nauczyciele (Imie, Nazwisko, ID_adresu, Data_zatrudnienia, Pensja, Poziom_nauczyciela) VALUES
('Jan', 'Kowalski', 1, '2010-09-01', 3500.00, 'Senior'),
('Anna', 'Nowak', 2, '2015-01-15', 3200.00, 'Junior'),
('Tomasz', 'Wiśniewski', 3, '2018-06-12', 3000.00, 'Junior'),
('Ewa', 'Wójcik', 4, '2013-11-23', 3400.00, 'Senior'),
('Krzysztof', 'Kamiński', 5, '2020-02-28', 3100.00, 'Junior'),
('Magdalena', 'Lewandowska', 6, '2017-04-05', 3300.00, 'Senior'),
('Piotr', 'Dąbrowski', 7, '2012-09-13', 3600.00, 'Senior'),
('Agnieszka', 'Zielińska', 8, '2019-12-01', 2900.00, 'Junior'),
('Michał', 'Szymański', 9, '2014-03-20', 3400.00, 'Senior'),
('Monika', 'Woźniak', 10, '2011-07-22', 3550.00, 'Senior');

-- Klasy
INSERT INTO dbo.Klasy (Nazwa_klasy, ID_wychowawcy, Liczba_uczniow, Sala, Poziom_klasy) VALUES
('1A', 1, 25, '101', 'Podstawowy'),
('1B', 2, 26, '102', 'Podstawowy'),
('2A', 3, 24, '201', 'Średni'),
('2B', 4, 23, '202', 'Średni'),
('3A', 5, 22, '301', 'Zaawansowany'),
('3B', 6, 21, '302', 'Zaawansowany'),
('4A', 7, 28, '401', 'Zaawansowany'),
('4B', 8, 27, '402', 'Średni'),
('5A', 9, 20, '501', 'Podstawowy'),
('5B', 10, 29, '502', 'Średni');

-- Uczniowie
INSERT INTO dbo.Uczniowie (Imie, Nazwisko, Data_urodzenia, ID_adresu, ID_klasy, Grupa_dodatkowa) VALUES
('Adam', 'Nowicki', '2008-03-15', 1, 1, 'Matematyka'),
('Beata', 'Kowalczyk', '2007-07-22', 2, 1, 'Język angielski'),
('Cezary', 'Zawadzki', '2008-11-05', 3, 2, 'Biologia'),
('Daria', 'Król', '2007-02-10', 4, 2, 'Fizyka'),
('Ewelina', 'Mazur', '2008-09-18', 5, 3, 'Chemia'),
('Filip', 'Głowacki', '2007-06-01', 6, 3, 'Matematyka'),
('Grażyna', 'Zięba', '2008-12-30', 7, 4, 'Historia'),
('Henryk', 'Kozłowski', '2007-04-12', 8, 4, 'Geografia'),
('Iwona', 'Czajkowska', '2008-10-28', 9, 5, 'Informatyka'),
('Jan', 'Sikora', '2007-01-14', 10, 5, 'Matematyka');

-- Przedmioty
INSERT INTO dbo.Przedmioty (Nazwa_przedmiotu, ID_nauczyciela, Poziom_trudnosci, Liczba_godzin) VALUES
('Matematyka', 1, 'Średni', 5),
('Język Polski', 2, 'Podstawowy', 4),
('Fizyka', 3, 'Zaawansowany', 3),
('Biologia', 4, 'Średni', 4),
('Chemia', 5, 'Zaawansowany', 3),
('Geografia', 6, 'Podstawowy', 2),
('Historia', 7, 'Podstawowy', 2),
('Informatyka', 8, 'Średni', 3),
('Język Angielski', 9, 'Zaawansowany', 5),
('Wychowanie Fizyczne', 10, 'Podstawowy', 2);

-- Harmonogramy_przedmiotow
INSERT INTO dbo.Harmonogramy_przedmiotow (ID_przedmiotu, ID_klasy, Dzien_zajec, Godzina_zajec, Semestr) VALUES
(1, 1, 'Poniedziałek', '08:00', 1),
(2, 1, 'Wtorek', '09:00', 1),
(3, 2, 'Środa', '10:00', 1),
(4, 2, 'Czwartek', '11:00', 1),
(5, 3, 'Piątek', '12:00', 1),
(6, 3, 'Poniedziałek', '13:00', 2),
(7, 4, 'Wtorek', '14:00', 2),
(8, 4, 'Środa', '08:00', 2),
(9, 5, 'Czwartek', '09:00', 2),
(10, 5, 'Piątek', '10:00', 2);

-- Oceny
INSERT INTO dbo.Oceny (ID_ucznia, ID_przedmiotu, Ocena, Data, ID_typu_oceny, Uwagi) VALUES
(1, 1, 5, '2023-09-10', 1, 'Bardzo dobra praca'),
(2, 2, 4, '2023-09-12', 2, 'Dobrze napisany test'),
(3, 3, 3, '2023-09-14', 3, 'Średnia praca projektowa'),
(4, 4, 5, '2023-09-16', 4, 'Aktywny na lekcji'),
(5, 5, 2, '2023-09-18', 5, 'Nieoddana praca domowa'),
(6, 6, 6, '2023-09-20', 6, 'Wzorowy egzamin'),
(7, 7, 3, '2023-09-22', 7, 'Wynik poniżej oczekiwań'),
(8, 8, 4, '2023-09-24', 8, 'Dobrze zrealizowane zadania'),
(9, 9, 5, '2023-09-26', 9, 'Bardzo dobra prezentacja'),
(10, 10, 2, '2023-09-28', 10, 'Słaba praca w laboratorium');

-- Frekwencja
INSERT INTO dbo.Frekwencja (ID_ucznia, ID_przedmiotu, Data, Obecnosc, ID_powodu_nieobecnosci) VALUES
(1, 1, '2023-09-10', 1, NULL),
(2, 2, '2023-09-11', 1, NULL),
(3, 3, '2023-09-12', 0, 1),
(4, 4, '2023-09-13', 1, NULL),
(5, 5, '2023-09-14', 0, 2),
(6, 6, '2023-09-15', 1, NULL),
(7, 7, '2023-09-16', 0, 3),
(8, 8, '2023-09-17', 1, NULL),
(9, 9, '2023-09-18', 0, 4),
(10, 10, '2023-09-19', 1, NULL);

-- Egzaminy
INSERT INTO dbo.Egzaminy (ID_przedmiotu, ID_klasy, Data_egzaminu, ID_rodzaju_egzaminu, Uwagi, ID_nauczyciela) VALUES
(1, 1, '2023-10-10', 1, 'Egzamin pisemny', 1),
(2, 2, '2023-10-12', 2, 'Test wielokrotnego wyboru', 2),
(3, 3, '2023-10-14', 3, 'Projekt grupowy', 3),
(4, 4, '2023-10-16', 4, 'Prezentacja ustna', 4),
(5, 5, '2023-10-18', 5, 'Egzamin praktyczny', 5),
(6, 1, '2023-10-20', 6, 'Egzamin końcowy', 1),
(7, 2, '2023-10-22', 7, 'Sprawdzian', 2),
(8, 3, '2023-10-24', 8, 'Kolokwium', 3),
(9, 4, '2023-10-26', 9, 'Praca pisemna', 4),
(10, 5, '2023-10-28', 10, 'Laboratorium', 5);

-- Wyniki_egzaminow
INSERT INTO dbo.Wyniki_egzaminow (ID_ucznia, ID_egzaminu, Wynik, Komentarz) VALUES
(1, 1, 85, 'Dobry wynik, ale mogło być lepiej'),
(2, 2, 90, 'Bardzo dobry wynik'),
(3, 3, 75, 'Projekt wykonany poprawnie'),
(4, 4, 80, 'Dobra prezentacja'),
(5, 5, 65, 'Wynik zadowalający, choć wymaga poprawy'),
(6, 6, 95, 'Świetny wynik na egzaminie końcowym'),
(7, 7, 70, 'Sprawdzian napisany na średnim poziomie'),
(8, 8, 85, 'Dobrze wykonany test'),
(9, 9, 60, 'Wynik poniżej oczekiwań'),
(10, 10, 55, 'Laboratorium zaliczone na minimalnym poziomie');


GO

-- Powód: Kolumna `Poziom_nauczyciela` w tabeli `Nauczyciele` zawiera powtarzające się wartości (`'Junior'`, `'Senior'`).
-- Normalizacja tej kolumny do nowej tabeli `Poziomy_nauczycieli` eliminuje redundancję danych,
-- poprawia spójność i umożliwia łatwiejsze zarządzanie oraz aktualizacje w przyszłości.

-- Tworzenie nowej tabeli dla poziomów nauczycieli
CREATE TABLE dbo.Poziomy_nauczycieli (
    ID_poziomu INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_poziomu NVARCHAR(50) NOT NULL
);

-- Wstawianie unikalnych wartości z tabeli `Nauczyciele` do nowej tabeli
INSERT INTO dbo.Poziomy_nauczycieli (Nazwa_poziomu)
SELECT DISTINCT Poziom_nauczyciela
FROM dbo.Nauczyciele;

-- Dodanie nowej kolumny w tabeli `Nauczyciele`, aby odwoływać się do `Poziomy_nauczycieli`
ALTER TABLE dbo.Nauczyciele
ADD ID_poziomu INT;

-- Aktualizacja tabeli `Nauczyciele` w celu ustawienia odpowiednich wartości FK
UPDATE dbo.Nauczyciele
SET ID_poziomu = pn.ID_poziomu
FROM dbo.Nauczyciele n
JOIN dbo.Poziomy_nauczycieli pn ON n.Poziom_nauczyciela = pn.Nazwa_poziomu;

-- Usunięcie starej kolumny i ograniczenia
ALTER TABLE dbo.Nauczyciele DROP CONSTRAINT CK_Nauczyciele_Poziom;
ALTER TABLE dbo.Nauczyciele DROP COLUMN Poziom_nauczyciela;

-- Dodanie ograniczenia klucza obcego
ALTER TABLE dbo.Nauczyciele
ADD CONSTRAINT FK_Nauczyciele_Poziomy FOREIGN KEY (ID_poziomu) REFERENCES dbo.Poziomy_nauczycieli(ID_poziomu);

GO

-- Powód: Kolumna `Poziom_klasy` w tabeli `Klasy` zawiera powtarzające się wartości, opisujące poziomy klas.
-- Normalizacja tej kolumny do osobnej tabeli `Poziomy_klas` pozwala na redukcję redundancji danych,
-- ułatwia zarządzanie wartościami i minimalizuje ryzyko niespójności.

-- Tworzenie nowej tabeli dla poziomów klas
CREATE TABLE dbo.Poziomy_klas (
    ID_poziomu INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_poziomu NVARCHAR(50) NOT NULL
);

-- Wstawianie unikalnych wartości z tabeli `Klasy` do nowej tabeli
INSERT INTO dbo.Poziomy_klas (Nazwa_poziomu)
SELECT DISTINCT Poziom_klasy
FROM dbo.Klasy;

-- Dodanie nowej kolumny w tabeli `Klasy`, aby odwoływać się do `Poziomy_klas`
ALTER TABLE dbo.Klasy
ADD ID_poziomu INT;

-- Aktualizacja tabeli `Klasy` w celu ustawienia odpowiednich wartości FK
UPDATE dbo.Klasy
SET ID_poziomu = pk.ID_poziomu
FROM dbo.Klasy k
JOIN dbo.Poziomy_klas pk ON k.Poziom_klasy = pk.Nazwa_poziomu;

-- Usunięcie starej kolumny `Poziom_klasy`
ALTER TABLE dbo.Klasy DROP COLUMN Poziom_klasy;

-- Dodanie ograniczenia klucza obcego
ALTER TABLE dbo.Klasy
ADD CONSTRAINT FK_Klasy_Poziomy FOREIGN KEY (ID_poziomu) REFERENCES dbo.Poziomy_klas(ID_poziomu);

GO

-- Powód: Tabela `Typy_ocen` zawiera nazwy typów ocen, które mogą być powtarzane w wielu rekordach.
-- Zastosowanie osobnej tabeli `Typy_ocen_normalized` pozwala na lepszą organizację danych,
-- redukcję redundancji oraz prostsze zarządzanie typami ocen.

-- Usuwanie ograniczenia klucza obcego w tabeli Oceny
ALTER TABLE dbo.Oceny DROP CONSTRAINT FK_Oceny_Typy;

-- Tworzenie nowej tabeli dla typów ocen (jeśli nie została stworzona wcześniej)
CREATE TABLE dbo.Typy_ocen_normalized (
    ID_typu_oceny INT PRIMARY KEY,
    Nazwa_typu NVARCHAR(50) NOT NULL
);

-- Przenoszenie danych do nowej tabeli
INSERT INTO dbo.Typy_ocen_normalized (ID_typu_oceny, Nazwa_typu)
SELECT ID_typu_oceny, Nazwa_typu_oceny
FROM dbo.Typy_ocen;

-- Aktualizacja tabeli Oceny, aby korzystała z nowej tabeli Typy_ocen_normalized
UPDATE dbo.Oceny
SET ID_typu_oceny = t.ID_typu_oceny
FROM dbo.Oceny o
JOIN dbo.Typy_ocen_normalized as t ON o.ID_typu_oceny = t.ID_typu_oceny;

-- Usuwanie starej tabeli Typy_ocen
DROP TABLE dbo.Typy_ocen;

-- Zmiana nazwy nowej tabeli na Typy_ocen
EXEC sp_rename 'dbo.Typy_ocen_normalized', 'Typy_ocen';

-- Ponowne dodanie klucza obcego do tabeli Oceny
ALTER TABLE dbo.Oceny
ADD CONSTRAINT FK_Oceny_Typy FOREIGN KEY (ID_typu_oceny) REFERENCES dbo.Typy_ocen(ID_typu_oceny);

GO

-- Powód: Kolumna `Przeznaczenie` w tabeli `Sale` opisuje cel użytkowania sali.
-- Przeniesienie tej kolumny do osobnej tabeli `Przeznaczenia_sal` pozwala na zarządzanie
-- przeznaczeniami w jednym miejscu, eliminując redundancję i upraszczając przyszłe zmiany.

-- Tworzenie nowej tabeli dla przeznaczeń sal
CREATE TABLE dbo.Przeznaczenia_sal (
    ID_przeznaczenia INT IDENTITY(1,1) PRIMARY KEY,
    Nazwa_przeznaczenia NVARCHAR(100) NOT NULL
);

-- Wstawianie unikalnych wartości przeznaczeń sal
INSERT INTO dbo.Przeznaczenia_sal (Nazwa_przeznaczenia)
SELECT DISTINCT Przeznaczenie
FROM dbo.Sale;

-- Dodanie kolumny w tabeli Sale dla FK
ALTER TABLE dbo.Sale
ADD ID_przeznaczenia INT;

-- Aktualizacja tabeli Sale w celu ustawienia wartości FK
UPDATE dbo.Sale
SET ID_przeznaczenia = ps.ID_przeznaczenia
FROM dbo.Sale s
JOIN dbo.Przeznaczenia_sal ps ON s.Przeznaczenie = ps.Nazwa_przeznaczenia;

-- Usunięcie starej kolumny Przeznaczenie
ALTER TABLE dbo.Sale DROP COLUMN Przeznaczenie;

-- Dodanie ograniczenia klucza obcego do tabeli Sale
ALTER TABLE dbo.Sale
ADD CONSTRAINT FK_Sale_Przeznaczenia FOREIGN KEY (ID_przeznaczenia) REFERENCES dbo.Przeznaczenia_sal(ID_przeznaczenia);

GO

-- Powód: Kolumna `Pensja` w tabeli `Nauczyciele` może zmieniać się w czasie.
-- Przeniesienie danych o pensjach do tabeli `Historia_pensji` umożliwia przechowywanie
-- historii zmian pensji oraz zapobiega nadpisywaniu wcześniejszych wartości.

-- Tworzenie tabeli Historia_pensji
CREATE TABLE dbo.Historia_pensji (
    ID_historia_pensji INT IDENTITY(1,1) PRIMARY KEY,
    ID_nauczyciela INT NOT NULL,
    Data_rozpoczecia DATE NOT NULL,
    Data_zakonczenia DATE,
    Pensja DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Historia_Pensji FOREIGN KEY (ID_nauczyciela) REFERENCES dbo.Nauczyciele(ID_nauczyciela)
);

-- Przenoszenie istniejących danych z tabeli Nauczyciele do Historia_pensji
INSERT INTO dbo.Historia_pensji (ID_nauczyciela, Data_rozpoczecia, Pensja)
SELECT ID_nauczyciela, Data_zatrudnienia, Pensja
FROM dbo.Nauczyciele;

-- Usunięcie kolumny Pensja z tabeli Nauczyciele
ALTER TABLE dbo.Nauczyciele DROP COLUMN Pensja;

GO
