/*

Clustered Index / gruppierter Index:

- genau einer pro Tabelle
- sortiert Datensätze neu an (auch physikalisch)

Non-Clustered Index / nicht-gruppierter Index:

- soviele wie ich möchte pro Tabelle (bis zu 1000)
- "Kopie" der Tabelle, mit anderer Sortierung
- Nur die Spalten, die im Index angegeben sind
- verweist auf die Pages in der "original" Tabelle


"Faustregeln":

- Clustered Index aus Primary Key bzw. auf eindeutige ID Spalte
- NCIX auf Foreign Keys, also Spalten die oft in Joins verwendet werden
- Bei viel beschriebenen Tabellen aufpassen (weniger ist mehr), da Indizes updaten müssen
- Spalten die oft selected werden, oder oft im where Filter auftauchen, Index vermutlich sinnvoll

*/

REBUILD INDEX [NonClusteredIndex-20230227-141716]

-- Fragmentierung von Indexes

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE OBJECT_ID = (SELECT OBJECT_ID('[dbo].[query]'))

--avg_fragmentation_in_percent
--Bei Tabellen in denen viel deleted wird ("Schießt Löcher in die Pages")

SELECT * FROM query
WHERE land = 'B'

CREATE NONCLUSTERED INDEX IndexName ON Tabelle (Spalte1, Spalte2)

CREATE CLUSTERED INDEX CIX_Name ON Tabelle (Spalte1)

DROP INDEX IndexName

SET STATISTICS IO, TIME ON

CREATE TABLE IndexTest (
id int identity,
ProduktionsZeitpunkt datetime,
Menge int )

ALTER TABLE IndexTest
ADD ProduktID int

INSERT INTO IndexTest
SELECT 
getdate() - RAND()*100 + 20,
CAST(RAND()*30 + 20 as int)
GO 100000

UPDATE IndexTest
SET ProduktID = 2
WHERE Id > 50000

SELECT * FROM IndexTest
-- logische Lesevorgänge: 17243, , CPU-Zeit = 94 ms, verstrichene Zeit = 936 ms.

SELECT * FROM IndexTest
WHERE ID BETWEEN 700 AND 1500
-- logische Lesevorgänge: 17243, CPU-Zeit = 63 ms, verstrichene Zeit = 137 ms.
--, logische Lesevorgänge: 6, , CPU-Zeit = 0 ms, verstrichene Zeit = 101 ms.

SELECT ProduktionsZeitpunkt FROM IndexTest
WHERE ID = 10236
-- logische Lesevorgänge: 17243, , CPU-Zeit = 15 ms, verstrichene Zeit = 28 ms.

SELECT ProduktID, SUM(Menge) FROM IndexTest
GROUP BY ProduktID
--logische Lesevorgänge: 17243, , CPU-Zeit = 47 ms, verstrichene Zeit = 85 ms.
--logische Lesevorgänge: 307, , CPU-Zeit = 47 ms, verstrichene Zeit = 76 ms.


CREATE TABLE IndexProdukte (
id int identity,
Produktname varchar(50))

INSERT INTO IndexProdukte
VALUES ('Backofen'), ('Spülmaschine')

SELECT Produktname, ProduktionsZeitpunkt FROM IndexProdukte IxP
JOIN IndexTest IxT ON IxP.id = IxT.ProduktID

SELECT Produktname, SUM(Menge) FROM IndexProdukte IxP
JOIN IndexTest IxT ON IxP.id = IxT.ProduktID
GROUP BY Produktname
