/* HW5

1
SELECT OwnerUserName.Name, RoleOwners.Name, RoleOwners.RoleDescription FROM OwnerUserName
INNER JOIN RoleOwners ON (OwnerUserName.idRole = RoleOwners.id)

2.

SELECT Guests.Name, Classes.Name, Levels1.idClass, COUNT(Levels1.idGuest) FROM Levels1
INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
INNER JOIN Classes ON (Levels1.idClass = Classes.id)

GROUP BY Guests.Name, Classes.Name, Levels1.idClass


select * from Classes

3.

SELECT idGuest, Guests.Name, idClass, Classes.Name, Level,
CASE WHEN Level BETWEEN 1 and 10 THEN 'Noob'
WHEN Level BETWEEN 11 and 20 THEN 'Intermediate'
WHEN Level BETWEEN 21 and 30 THEN 'Pro'
WHEN Level BETWEEN 31 and 40 THEN 'Expert'
WHEN Level BETWEEN 41 and 50 THEN 'Master'
END AS Brackets FROM Levels1
INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
INNER JOIN Classes ON (Levels1.idClass = Classes.id)
ORDER BY Guests.Name asc;


4.
GO
IF OBJECT_ID (N'dbo.GetBrackets', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.GetBrackets;  
GO  
CREATE FUNCTION dbo.GetBrackets (@level int)  
RETURNS varchar(50)  
AS    
BEGIN
DECLARE @ret int;
DECLARE @label varchar(50);  
SELECT @ret = (@level)  
    IF (@ret < 10)
SET @label = 'Noob';
IF (@ret BETWEEN 10 AND 19)
SET @label = 'Intermediate';
IF (@ret BETWEEN 20 AND 29)
SET @label = 'Pro';
IF (@ret BETWEEN 30 AND 39)
SET @label = 'Expert';
IF (@ret >= 40)
SET @label = 'Master';
RETURN @label;
END;

GO

SELECT idGuest, Guests.Name, idClass, Classes.Name, Level, dbo.GetBrackets(Level) AS LevelBrackets FROM Levels1
INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
INNER JOIN Classes ON (Levels1.idClass = Classes.id)
ORDER BY Guests.Name asc;

IF OBJECT_ID (N'dbo.RoomOpen', N'IF') IS NOT NULL
DROP FUNCTION dbo.RoomOpen;
GO
CREATE FUNCTION dbo.RoomOpen (@vacant date)
RETURNS TABLE
AS
RETURN
(
SELECT Rooms.Number, Taverns.Name, Rooms.idTavern, Rooms.id
FROM Stays
INNER JOIN Rooms ON Rooms.id = Stays.idRoom
INNER JOIN Taverns ON Taverns.id = Rooms.idTavern
WHERE @vacant NOT BETWEEN Stays.CheckedIn AND Stays.Checkedout
);
GO
SELECT * FROM dbo.RoomOpen('2019-12-21');
SELECT * FROM Stays





6.

GO
 IF OBJECT_ID (N'dbo.PriceRange', N'IF') IS NOT NULL
DROP FUNCTION dbo.PriceRange;
GO
CREATE FUNCTION dbo.PriceRange (@min DECIMAL(5,2), @max DECIMAL(5,2))
RETURNS TABLE
AS
RETURN
(
SELECT Rooms.Number, Taverns.Name, Rooms.idTavern, Rooms.id, Rooms.Cost
FROM Rooms
INNER JOIN Stays ON Rooms.id = Stays.idRoom
INNER JOIN Taverns ON Taverns.id = Rooms.idTavern
WHERE Rooms.Cost BETWEEN @min AND @max
);
GO
SELECT * FROM dbo.PriceRange(80, 130)














need 2

create procedure
--7
--IF OBJECT_ID (N'dbo.CreateARoom', N'P') IS NOT NULL  
--    DROP PROCEDURE dbo.CreateARoom;
--GO
--CREATE PROCEDURE dbo.CreateARoom
-- @cost DECIMAL(5,2),
-- @tavernsname varchar(50),
-- @tavernid int
--AS
--BEGIN
--SET NOCOUNT ON;
--SET @cost = (SELECT MIN(Cost) FROM dbo.PriceRange(80, 130));
--SET @tavernsname = (SELECT TOP 1 Name FROM dbo.PriceRange(80, 130) AS NewRoom
-- WHERE Cost = (
--        SELECT MIN(Cost)
--        FROM dbo.PriceRange(80, 130)));
--SET @tavernid = (SELECT id FROM Taverns WHERE @tavernsname = Name);
--INSERT INTO Rooms (Cost, idTavern)
-- VALUES (@Cost - 0.01, @Tavernid)
--END

--BEGIN TRANSACTION
--EXECUTE dbo.CreateARoom
--@Cost = 80,
--@Tavernsname = '',
--@Tavernid = ''

--ROLLBACK

--GO



--SELECT * FROM Rooms;
--SELECT * FROM Taverns;

--IF OBJECT_ID('dbo.book_cheap_room',N'P') IS NOT NULL
-- DROP PROCEDURE dbo.book_cheap_room;
--GO
--CREATE PROCEDURE dbo.book_cheap_room
-- @Guest varchar(50),
-- @Min DECIMAL(5,2),
-- @Max DECIMAL(5,2),
-- @Book Date,
-- @checkout Date        
--AS
--BEGIN
-- SET NOCOUNT ON;
-- SET @Book = getdate();
-- SET @checkout = getdate() + 3;
-- INSERT INTO Stays (idSale, idRoom, idGuest, CheckedIn, CheckedOut, Rate )
-- VALUES (
-- (SELECT TOP 1 id FROM Sales ORDER BY id desc),
-- (SELECT TOP 1 id FROM ROOMS WHERE number IN  (SELECT number FROM dbo.RoomOpen(@Book))
-- AND number IN (SELECT number FROM dbo.PriceRange(@Min, @Max)) ORDER BY cost ASC),
-- (SELECT ID FROM Guests WHERE Name Like @Guest),
-- @Book,
-- @checkout,
-- (SELECT TOP 1 cost FROM ROOMS WHERE number IN  (SELECT number FROM dbo.RoomOpen(@Book))
-- AND number IN (SELECT number FROM dbo.PriceRange(@Min, @Max)) ORDER BY cost ASC)
-- )
--END
--GO

--BEGIN TRANSACTION
--EXEC dbo.book_cheap_room
--@Guest = 'William Tate',
--@Min = 76,
--@Max = 999,
--@book = '',
--@checkout = ''
--GO
--ROLLBACK
--select * from stays

--GO

--DROP TRIGGER addSaleBooking
--GO
--CREATE TRIGGER addSaleBooking
--ON Stays
--AFTER INSERT
--AS

--INSERT INTO Sales (Name, Price, DatePurchased) SELECT Rate, CheckedIn
--FROM inserted;

--GO
--select * from Sales

