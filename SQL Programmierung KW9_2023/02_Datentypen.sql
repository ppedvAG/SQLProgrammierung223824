/*

Datentypen


Numerisch:


Integer-Typen:
tinyint = bis 255
smallint = 
int
bigint

bit = 1 / 0
decimal(10,2) = 8 Vor dem Komma, 2 Nachkommastellen; Nachkommastellen werden kaufmännisch gerundet
float


String Datentypen:

char(10) = 'Nico      '
nchar
varchar(10) = 'Nico'
nvarchar 
varchar(MAX)


Zeit Datentypen:
date = Nur Datum
time = Nur Zeit
smalldate = Datum & Zeit bis Minuten
datetime = bis Milisekunden
dateime2 = bis Nanosekunden

Spezielle Datentypen:
Geography
XML
JSON


Grundsätzlich: Überlegen wie präzise/groß meine Daten sein müssen, je mehr desto mehr Speicherplatz!


Speichern der Datensätze in Pages/Seiten á 8 kb; Max 700 Datensätze pro Page, auch wenn nicht 8kb groß

*/

SET STATISTICS IO, TIME OFF

dbcc showcontig('Customers')
--Seitendichte ab 80% ist gut, 85% - 90% sehr gut

SELECT * FROM Customers

CREATE TABLE PageDichte (
ID int identity,
Zeugs char(4100) )

INSERT INTO PageDichte
VALUES ('HalloTest'),
('HalloTest')

SELECT * FROM PageDichte

CREATE TABLE PageDichte2 (
ID smallint identity,
Zeugs varchar(5))

INSERT INTO PageDichte2
VALUES ('abc')
GO 1000

dbcc showcontig('PageDichte2')

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers'

SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE OBJECT_ID = (SELECT OBJECT_ID('PageDichte2'))
SELECT DB_ID('Northwind')
SELECT OBJECT_ID('Customers')
SELECT * FROM [Order Details]


