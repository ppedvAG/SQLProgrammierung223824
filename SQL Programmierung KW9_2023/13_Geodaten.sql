/*

2 Datentypen in SQL

1. geometry
2. geography

*/

CREATE TABLE Locations 
   (ID int IDENTITY(1, 1) NOT NULL Primary Key, 
   Ctry char(2), 
   City varchar(40), 
   Coordinate geography); 

INSERT INTO Locations VALUES 
   ('DE', 'Berlin',  'POINT(13.4000 51.5166)') 
   ,('DE', 'Hamburg',  'POINT(10.0000 53.5500)') 
   ,('DE', 'Köln',  'POINT( 6.9572 50.9413)') 
   ,('DE', 'Hannover',  'POINT( 9.7361 52.3744)') 
   ,('DE', 'Frankfurt (M)', 'POINT( 8.6859 50.1118)') 
   ,('DE', 'Bonn',  'POINT( 7.0998 50.7339)') 
   ,('DE', 'Düsseldorf',  'POINT( 6.7827 51.2255)') 
   ,('DE', 'München',  'POINT(11.5744 48.1397)') 
   ,('DE', 'Nürnberg',  'POINT(11.0777 49.4527)') 
   ,('DE', 'Frankfurt (O)', 'POINT(14.5500 52.3500)') 
   ,('DE', 'Dortmund',  'POINT( 7.4652 51.5138)') 
   ,('DE', 'Regensburg',  'POINT(12.0833 49.0166)') 
   ,('DE', 'Dresden',  'POINT(13.7383 51.0492)') 
   ,('DE', 'Leipzig',  'POINT(12.3747 51.3403)') 
   ,('DE', 'Halle (Saale)', 'POINT(11.9700 51.4827)') 
   ,('DE', 'Magdeburg',  'POINT(11.6166 52.1333)') 
   ,('DE', 'Cottbus',  'POINT(14.3341 51.7605)') 
   ,('DE', 'Flensburg',  'POINT( 9.4366 54.7819)') 
   ,('GB', 'London',  'POINT(-0.1183 51.5094)') 
   ,('GB', 'Greenwich',  'POINT(-0.0080 51.4812)') 


SELECT * FROM Locations

--WKT = well-known Text

SELECT [ID], [Ctry], [City], 
[Coordinate].ToString() FROM Locations

DECLARE @Traunstein geography
SET @Traunstein = geography::STGeomFromText ( 'POINT(12.64335 47.86825)', 4326) -- 4326 = Spatial reference identifier (SRID)

SELECT Ctry, City 
   ,Coordinate 
   ,Coordinate.ToString()  -- Klartext über ToString() 
   ,Coordinate.STDistance(@Traunstein) / 1000 AS [Abstand KM] 
 FROM Locations 
 ORDER BY Coordinate.STDistance(@Traunstein); 

DECLARE @Traunstein geography
SET @Traunstein = geography::STGeomFromText ('POINT(12.64335 47.86825)', 4326)

SELECT geography::STGeomFromText('POINT(-0.0080 51.4812)',4326).STDistance(@Traunstein) / 1000



DECLARE @x float = 4.513213 , @y float = 7.4442, @geometry geometry

SET @geometry = geometry::Point(@x, @y, 4326)

SELECT @geometry.ToString()





