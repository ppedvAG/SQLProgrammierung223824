--Transaktion

BEGIN TRAN

UPDATE Customers
SET City = 'Burghausen'


ROLLBACK COMMIT

SELECT * FROM Customers

BEGIN TRAN

INSERT INTO A
VALUES (123)

INSERT INTO B
VALUES (123)

COMMIT OR ROLLBACK

/*
-- Locks = "Schl�sser"
Jede Transaktion "sperrt"/locked die genutzte Ressource solange bis abgeschlossen

*/

BEGIN TRAN

UPDATE Customers
SET City = 'M�nchen'
WHERE CustomerID = 'ALFKI'

--UPDATE sperrt alle betroffenen Zeilen = ROWLOCK(s)

ROLLBACK

SELECT @@TRANCOUNT

BEGIN TRAN
SELECT * FROM Customers


--Blocking kann zu sogenannten DEADLOCKS f�hren

CREATE TABLE Rechts (
ID int identity,
Zeugs varchar(10) )

INSERT INTO Rechts 
VALUES ('abc')


BEGIN TRAN

UPDATE Links
SET Zeugs = 'xyz'

UPDATE Rechts
SET Zeugs = 'xyz'

--Alle 5 Sekunden pr�ft SQL Server auf Deadlock Situationen 
-- und terminiert einen der Prozesse zuf�llig

-- Um Lesequeries ohne Locking durchzuf�hren: NOLOCK

SELECT * FROM Customers WITH (NOLOCK)

-- Nur wenn das Lesen von eventuell f�lschlichen Daten kein Problem ist


