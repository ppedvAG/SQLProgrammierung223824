--Partitionierung

CREATE TABLE Umsatz (
ID int identity PRIMARY KEY,
Datum date,
Umsatz decimal(10,2) )

INSERT INTO Umsatz
SELECT 
getdate() - RAND()*350*5,
CAST(RAND()*30 + 20 as decimal(10,2))
GO 100000

SELECT * FROM Umsatz

-- Schritt 1: Grenzwerte, bzw. Partitionsgruppen definieren

SELECT MIN(Datum), MAX(Datum) FROM Umsatz

--15.05.2018 bis 28.02.2023

--2018, 2019, 2020, 2021, 2022, 2023

-- Schritt 2: Filegroups und Files erstellen 


-- Schritt 3: Partitionsfunktion schreiben (Grenzwerte der Daten für die Partitionen)

CREATE PARTITION FUNCTION f_UmsatzNachJahr2 (date)
AS
RANGE LEFT FOR VALUES ('20181231', '20191231', '20201231', '20211231', '20221231', '20231231')

-- Schritt 4: Partitions Schema erstellen

CREATE PARTITION SCHEME ps_UmsatzNachJahr2
AS PARTITION f_UmsatzNachJahr2
TO ('Umsatz2018', 'Umsatz2019', 'Umsatz2020', 'Umsatz2021', 'Umsatz2022', 'Umsatz2023', [PRIMARY])

-- Schritt 5: Clustered Index (neu) anlegen

CREATE CLUSTERED INDEX IX_UmsatzID ON Umsatz (ID) ON ps_UmsatzNachJahr2 (Datum)

SELECT $PARTITION.f_UmsatzNachJahr2(Datum), Datum FROM Umsatz
ORDER BY Datum


SELECT SUM(UMSATZ) as JahresUmsatz2019, COUNT(*) FROM Umsatz
WHERE YEAR(Datum) = 2019


-- Abfrage für wieviele Datensätze pro Partition
SELECT p.partition_number as partition_number,
f.name,
p.rows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(Object_ID) = 'Umsatz'