--Window Functions bzw. OVER() + ORDER BY oder PARTITION BY

SUM() AVG()

SELECT 
ID,
Datum,
Umsatz,
SUM(Umsatz) OVER (ORDER BY ID) as RunningTotal,
SUM(Umsatz) OVER (PARTITION BY YEAR(Datum),MONTH(Datum), DAY(Datum)) as TagesSumme,
AVG(Umsatz) OVER (PARTITION BY YEAR(Datum), MONTH(Datum)) as MonatsDurchschnitt
FROM Umsatz ORDER BY RunningTotal

LAG(), LEAD()

SELECT *,
Umsatz - LAG(Umsatz, 1) OVER (ORDER BY Datum) as PositionsDifferenz
FROM Umsatz
ORDER BY Datum

SELECT Datum, SUM(Umsatz) as TagesSumme INTO #t
FROM Umsatz
GROUP BY Datum
ORDER BY Datum

SELECT *, 
TagesSumme - LAG(TagesSumme, 1, 0) OVER (ORDER BY Datum) as Diff
FROM #t

SELECT *, 
TagesSumme - LEAD(TagesSumme, 1, 0) OVER (ORDER BY Datum DESC) as Diff
FROM #t
ORDER BY Datum DESC

SELECT *,
RANK() OVER (ORDER BY TagesSumme DESC) as Ranking into #tt
FROM #t

SELECT * FROM #tt WHERE Ranking = 3

SELECT TOP 10 PERCENT *
FROM #t ORDER BY TagesSumme DESC

