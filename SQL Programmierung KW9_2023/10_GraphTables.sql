/*

Graph-Tables(bzw. Databases)

SQL Server ist eine relationale Datenbank

seit Version 2017 unterstützt SQL Server auch Graph Tables


*/


USE master
GO

CREATE DATABASE GraphDemo
GO

CREATE TABLE Restaurants (
RID int identity,
RName varchar(40)
) AS NODE
GO

CREATE TABLE Produkte (
PID int identity,
Produktname varchar(40) 
) AS NODE
GO

CREATE TABLE BietetAn AS EDGE
GO

INSERT INTO Restaurants 
VALUES ('Food Place'), ('Mexican Food')

INSERT INTO Produkte
VALUES ('Sandwich'), ('Pommes'), ('Cola')

SELECT * FROM Produkte
SELECT * FROM Restaurants

INSERT INTO BietetAn
VALUES
(
(SELECT $node_id FROM Restaurants WHERE Restaurants.RID = 1), -- 1. Insert ist "FROM"
(SELECT $node_id FROM Produkte WHERE Produkte.PID = 1) -- 2. Insert ist "TO"
),
(
(SELECT $node_id FROM Restaurants WHERE Restaurants.RID = 1),
(SELECT $node_id FROM Produkte WHERE Produkte.PID = 3)
),
(
(SELECT $node_id FROM Restaurants WHERE Restaurants.RID = 2),
(SELECT $node_id FROM Produkte WHERE Produkte.PID = 2)
),
(
(SELECT $node_id FROM Restaurants WHERE Restaurants.RID = 2),
(SELECT $node_id FROM Produkte WHERE Produkte.PID = 3)
)

SELECT * FROM BietetAn

SELECT RID, RName, PID, Produktname FROM Restaurants, BietetAn, Produkte
WHERE MATCH(Restaurants-(BietetAn)->Produkte) AND Produktname = 'Cola'

SELECT RID, RName, PID, Produktname FROM Restaurants, BietetAn, Produkte
WHERE MATCH(Kunden-(HabenBestellt)->Bestellungen<-(Beinhalten)-Produkte)