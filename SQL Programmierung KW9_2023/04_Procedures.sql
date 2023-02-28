/* 
(Stored) Procedures:

*/
CREATE PROCEDURE sp_LandKunde @Country varchar(20)
AS
SELECT * FROM Customers
WHERE Country = @Country


--Prozedur ausführen mit EXEC:
EXEC sp_LandKunde France


CREATE PROCEDURE sp_FreightINcrease @OrderID int
AS
UPDATE Orders
SET Freight = Freight*1.1
WHERE OrderID = @OrderID


-- "Default" Wert für Parameter mit = 'Wert'
CREATE PROCEDURE sp_Test @Country varchar(20) = 'Germany'
AS
SELECT * FROM Customers
WHERE Country = @Country

EXEC sp_Test 


ALTER PROCEDURE sp_Test @Country varchar(20) = 'France'
AS
SELECT * FROM Customers
WHERE Country = @Country