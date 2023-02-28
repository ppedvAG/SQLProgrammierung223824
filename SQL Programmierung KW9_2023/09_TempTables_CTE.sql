/*
#temp Tables/tempor�re Tabellen

# = lokaler temp Table = nur innerhalb meiner Session
## = globale temp Table = auch in anderen Sessions aufrufbar

Werden in der TempDB gespeichert, daher bei erneutem Aufruf sehr schnell
Nachteil: Evtl. veraltete Daten

*/
DROP TABLE IF EXISTS #NameTempTable

SELECT YEAR(Datum) as Gesch�ftsjahr, SUM(Umsatz) as JahresUmsatz 
INTO #NameTempTable
FROM Umsatz
GROUP BY YEAR(Datum)
ORDER BY 1

SELECT * FROM #NameTempTable

-- Temp Table manuell l�schen:
DROP TABLE ##globalerTempTable


INSERT INTO NeueTable
SELECT * FROM #NameTempTable


/*
CTEs = Common Table Expression

Funktioniert sehr �hnlich wie #temp, mit Unterschied dass sie im Arbeitsspeicher abgelegt wird,
und nicht auf der tempDB

*/

WITH ctename AS
(
SELECT YEAR(Datum) as Gesch�ftsjahr, SUM(Umsatz) as JahresUmsatz 
FROM Umsatz
GROUP BY YEAR(Datum)
)

SELECT * FROM ctename
WHERE Gesch�ftsjahr = 2020

-- CTEs k�nnen rekursiv geschrieben werden

WITH cteWochentag (x, Wochentag)
AS
(
--Anchor Zeile

SELECT 0, DATENAME(WEEKDAY, 0)

UNION ALL
--Recursion

SELECT x + 1, DATENAME(WEEKDAY, x + 1)
FROM cteWochentag
WHERE x < 6 --Terminator
)

SELECT * FROM cteWochentag





-- UNION

SELECT 'Hallo' 
UNION -- Union ist automatisch mit DISTINCT ("l�scht" identische Zeilen)
SELECT 'Tsch�ss'
UNION ALL -- Union All ohne DISTINCT
SELECT 'Tsch�ss'


SELECT TOP 1 * FROM Umsatz
ORDER BY ID DESC

SELECT TOP 5 PERCENT * FROM Umsatz
ORDER BY Umsatz DESC

SELECT TOP 5 PERCENT WITH TIES * FROM Umsatz
ORDER BY Umsatz DESC