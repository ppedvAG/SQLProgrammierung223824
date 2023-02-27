--View/Sicht = gespeicherte Abfrage

USE SchulungsDemo
GO

--View erstellen:
CREATE VIEW vRechnungen
AS
SELECT AuftragID, Produktname, Bestelldatum, Lieferdatum, SUM(Anzahl*Preis) as RechnungsSumme FROM Produkte p
JOIN Auftr�ge a ON p.ProduktID = a.ProduktID
GROUP BY AuftragID, Produktname, Bestelldatum, Lieferdatum
GO
-- Views k�nnen genau wie Tables referiert werden
SELECT * FROM vRechnungen

SELECT Bestelldatum FROM vRechnungen

-- Vor allem auch n�tzlich f�r Rechte management, auf Views k�nnen andere Rechte wie auf Tabellen vergeben werden