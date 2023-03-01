-- Merge Statement führt 2 Tables zusammen, checkt auf identische bzw.unterschiedliche Werte
-- und führt entsprechende Anweisungen aus

SELECT * INTO ProdukteNeu FROM Produkte -- SELECT Columns INTO NewTable FROM ExistingTable: kopiert Tabelle in neue Tabelle


SELECT * FROM Produkte
SELECT * FROM ProdukteNeu

--Tabellen vorbereiten:
UPDATE ProdukteNeu
SET ProduktName = 'Ofen Induktion'
WHERE ProduktID = 3

UPDATE ProdukteNeu
SET Preis = 550
WHERE ProduktID = 1

DELETE FROM ProdukteNeu
WHERE ProduktID = 2

INSERT INTO ProdukteNeu
VALUES ('Toaster', 1, 1, 50)


--MERGE Statement:

MERGE Produkte TARGET		-- Target = was soll geupdatet werden
USING ProdukteNeu SOURCE	-- Source = was soll als Vorlage dienen
ON TARGET.ProduktID = SOURCE.ProduktID

WHEN MATCHED THEN
UPDATE 
SET TARGET.Preis = SOURCE.Preis, TARGET.Produktname = SOURCE.Produktname

WHEN NOT MATCHED BY TARGET THEN
INSERT
VALUES (SOURCE.Produktname, SOURCE.Modellnummer, SOURCE.Seriennummer, SOURCE.Preis)

WHEN NOT MATCHED BY SOURCE THEN
DELETE;


SELECT * FROM Produkte 
EXCEPT -- Nur unterschiedliche Records der beiden Tables im Ergebnis
SELECT * FROM ProdukteNeu 

SELECT * FROM Produkte 
INTERSECT -- Nur identische Records der beiden Tables im Ergebnis
SELECT * FROM ProdukteNeu