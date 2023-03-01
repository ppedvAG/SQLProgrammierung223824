/*

Arbeiten mit XML Dateien

XML ausgeben:				*/
SELECT * FROM Produkte


INSERT INTO Produkte 
VALUES
('Spülmaschine',1,5, 350),
('Ofen', 2, 1, 650)


SELECT * FROM Produkte
FOR XML AUTO

---------

SELECT * FROM Produkte
FOR XML PATH -- Parent Element standardmäßig 'row'

SELECT * FROM Produkte
FOR XML PATH ('Produkte') -- Parent Element selbst definieren

SELECT * FROM Produkte
FOR XML PATH ('Produkte'), ROOT('Produkte') -- Root Element selbst definieren

SELECT
[ProduktID] AS [@ProduktID],
[Produktname] AS [ProduktInfo/Produktname],
[Modellnummer] AS [ProduktInfo/Modellnummer],
[Seriennummer] AS [ProduktInfo/Seriennummer],
[Preis]
FROM Produkte
FOR XML PATH ('Produkte'), ROOT('Produkte') -- Spaltenwerte als Attribut definieren

SELECT
[ProduktID] AS [@ProduktID],
[Produktname] AS [ProduktInfo/@Produktname],
[Modellnummer] AS [ProduktInfo/Modellnummer],
[Seriennummer] AS [ProduktInfo/Seriennummer],
[Preis]
FROM Produkte
FOR XML PATH ('Produkte'), ROOT('Produkte') -- Nested Attribute


-----------------------------------------------------------------------------------

-- XML "importieren":

--Schritt 1:

DECLARE @xml xml

SELECT @xml = C 
FROM OPENROWSET (BULK 'C:\\Produkte.xml') AS Produkte(C)

SELECT @xml -- lädt die "reingeladene" XML Datei in memory

--Schritt 2:

EXEC sp_xml_preparedocument @hdoc OUTPUT, @xml
SELECT * FROM OPENXML (@hdoc, '/Produkte/Produkte/ProduktInfo', 1)
WITH (
	[ProduktID] int, 
	[Produktname] varchar(50), 
	[Modellnummer] smallint, 
	[Seriennummer] int, 
	[Preis] decimal(7,2)
	)

EXEC sp_xml_removedocument @hdoc


