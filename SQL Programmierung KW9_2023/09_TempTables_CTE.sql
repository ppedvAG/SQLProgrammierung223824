/*
#temp Tables/temporäre Tabellen

# = lokaler temp Table = nur innerhalb meiner Session
## = globale temp Table = auch in anderen Sessions aufrufbar

Werden in der TempDB gespeichert, daher bei erneutem Aufruf sehr schnell
Nachteil: Evtl. veraltete Daten

*/
DROP TABLE IF EXISTS #NameTempTable

SELECT YEAR(Datum) as Geschäftsjahr, SUM(Umsatz) as JahresUmsatz 
INTO #NameTempTable
FROM Umsatz
GROUP BY YEAR(Datum)
ORDER BY 1

SELECT * FROM #NameTempTable

-- Temp Table manuell löschen:
DROP TABLE ##globalerTempTable


INSERT INTO NeueTable
SELECT * FROM #NameTempTable


/*
CTEs = Common Table Expression

Funktioniert sehr ähnlich wie #temp, mit Unterschied dass sie im Arbeitsspeicher abgelegt wird,
und nicht auf der tempDB

*/

WITH ctename AS
(
SELECT YEAR(Datum) as Geschäftsjahr, SUM(Umsatz) as JahresUmsatz 
FROM Umsatz
GROUP BY YEAR(Datum)
)

SELECT * FROM ctename
WHERE Geschäftsjahr = 2020

-- CTEs können rekursiv geschrieben werden

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
UNION -- Union ist automatisch mit DISTINCT ("löscht" identische Zeilen)
SELECT 'Tschüss'
UNION ALL -- Union All ohne DISTINCT
SELECT 'Tschüss'


SELECT TOP 1 * FROM Umsatz
ORDER BY ID DESC

SELECT TOP 5 PERCENT * FROM Umsatz
ORDER BY Umsatz DESC

SELECT TOP 5 PERCENT WITH TIES * FROM Umsatz
ORDER BY Umsatz DESC