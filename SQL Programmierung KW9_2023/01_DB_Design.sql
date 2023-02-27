/*

Tables:

Kunden
Produkte
Aufträge
Produktdetails


*/

USE master
GO

CREATE DATABASE SchulungsDemo


CREATE TABLE Kunden (
KundenID int identity Primary Key,-- identity = automatische Erhöhung und unique/eindeutig
Firma varchar(50) NOT NULL,
Straße varchar(40),
PLZ int,
Ort varchar(40),
Land varchar(30)
)

CREATE TABLE Produkte (
ProduktID int identity Primary Key,
Produktname varchar(50),
Modellnummer smallint,
Seriennummer int
)

ALTER TABLE Produkte
ADD Preis decimal(7,2)


CREATE TABLE Aufträge (
AuftragID int identity Primary Key,
KundenID int,
ProduktID int,
Anzahl smallint,
Bestelldatum smalldatetime,
Lieferdatum date,
CONSTRAINT FK_AufträgeKunden_KundenID FOREIGN KEY (KundenID) REFERENCES Kunden (KundenID),
CONSTRAINT FK_AufträgeProdukte_ProduktID FOREIGN KEY (ProduktID) REFERENCES Produkte (ProduktID)
)


INSERT INTO Kunden
VALUES ('BSH Hausgeräte GmbH', 'Werner-von-Siemens Straße 200', 83301, 'Traunreut', 'Deutschland')

INSERT INTO Produkte
VALUES ('Waschmaschine Saubermann', 1, 1, 500)

INSERT INTO Aufträge 
VALUES (1, 1, 2, getdate(), DATEADD(dd, 10, getdate()))

SELECT * FROM Aufträge a
JOIN Kunden k ON a.KundenID = k.KundenID
JOIN Produkte p ON p.ProduktID = a.ProduktID


DELETE FROM Kunden
WHERE KundenID = 1

USE Demo
SELECT * FROM T1
WHERE Id = 15000