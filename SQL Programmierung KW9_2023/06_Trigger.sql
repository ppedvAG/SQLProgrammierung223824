/*

Trigger: 

Können erstellt werden auf Tabellen, werden "abgefeuert" bei INSERT/UPDATE/DELETE

Dafür können wir die TempDB Tables "inserted" (wie wird es aussehen) 
und "deleted" (wie sah sie vorher aus) nutzen (Merke: Update = Delete + Insert)

*/

CREATE TABLE Messwerte (
ID int identity PRIMARY KEY,
Wert1 char(10)
)

INSERT INTO Messwerte
VALUES --('1234')
--('177758'),
('9994113')

ALTER TRIGGER tr_Messwerte ON Messwerte
--AFTER/(FOR)/INSTEAD OF   INSERT/UPDATE/DELETE
AFTER INSERT
AS

DECLARE @Wert1 char(10), @ID int

SET @Wert1 = (SELECT Wert1 FROM inserted)
SET @ID = (SELECT ID FROM inserted)

SET @Wert1 =
CASE 
	WHEN LEN(@Wert1) < 10 THEN STUFF(@Wert1, 1, 0, REPLICATE('0', 10 - LEN(@Wert1)))
	ELSE @Wert1
END
UPDATE Messwerte
SET Wert1 = @Wert1
WHERE ID = @ID

SELECT * FROM Messwerte

SELECT STUFF('1234      ',  1, 0, REPLICATE('0', 10 - LEN('1234      ')))



/*
Übung: In Tabelle A werden die "richtigen" Werte inserted, in Tabelle B sollen geänderte Werte inserted werden
*/

CREATE TABLE A (
ID int identity PRIMARY KEY,
ProduktionsZeitpunkt smalldatetime NOT NULL )
GO

CREATE TABLE B (
ID int identity PRIMARY KEY,
ProduktionsZeitpunkt smalldatetime NOT NULL )
GO

INSERT INTO A
VALUES ('20230228')

--In B soll Datum von A - 20 Jahre eingefügt werden

SELECT DATEADD(

CREATE TRIGGER tr_Datum ON A
AFTER INSERT
AS
-- @ID int, 
DECLARE @Datum smalldatetime

--SET @ID = (SELECT ID FROM inserted)
--SET @Datum = (SELECT DATEADD(YEAR, -20, ProduktionsZeitpunkt) FROM inserted)
SET @Datum = DATEADD(YEAR, -20, (SELECT ProduktionsZeitpunkt FROM inserted))
INSERT INTO B
VALUES (@Datum)

SELECT * FROM A
SELECT * FROM B
 
DISABLE TRIGGER tr_Datum ON A
ENABLE TRIGGER 

-- Trigger anpassen, dass er für mehr als ein INSERT Statement funktioniert
-- Idee: Abgleich Tabelle A mit Tabelle inserted 


ALTER TRIGGER tr_Datum2 ON A
AFTER INSERT
AS
BEGIN
INSERT INTO B
SELECT ProduktionsZeitpunkt FROM Inserted ORDER BY ID
END
BEGIN
UPDATE B
SET ProduktionsZeitpunkt = DATEADD(YEAR, -20, ProduktionsZeitpunkt)
WHERE ID IN (
SELECT A.ID FROM A
JOIN inserted i ON A.ID = i.ID ) 
END


INSERT INTO A
VALUES ('20230101'),
('20230102'),
('20230103')

SELECT * FROM A
SELECT * FROM B

SET IDENTITY_INSERT A OFF

INSERT INTO A
VALUES (20, '20230101')