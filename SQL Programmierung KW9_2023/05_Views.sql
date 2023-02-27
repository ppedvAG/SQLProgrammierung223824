--View/Sicht = gespeicherte Abfrage

USE SchulungsDemo
GO

--View erstellen:
CREATE VIEW vRechnungen
AS
SELECT AuftragID, Produktname, Bestelldatum, Lieferdatum, SUM(Anzahl*Preis) as RechnungsSumme FROM Produkte p
JOIN Aufträge a ON p.ProduktID = a.ProduktID
GROUP BY AuftragID, Produktname, Bestelldatum, Lieferdatum
GO
-- Views können genau wie Tables referiert werden
SELECT * FROM vRechnungen

SELECT Bestelldatum FROM vRechnungen

-- Vor allem auch nützlich für Rechte management, auf Views können andere Rechte wie auf Tabellen vergeben werden