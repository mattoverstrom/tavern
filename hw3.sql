<!-- https://github.com/mattoverstrom/tavern



hw4

1.
SELECT OwnerUserName.Name, RoleOwners.Name, RoleDescription FROM OwnerUserName
INNER JOIN RoleOwners ON (OwnerUserName.idRole = RoleOwners.id)
WHERE RoleOwners.RoleDescription LIKE '%admin%';

2.

SELECT OwnerUserName.Name, RoleOwners.Name, RoleDescription, Taverns.Name,
locationAddress.Name, locationAddress.City, locationAddress.Country FROM OwnerUserName
INNER JOIN RoleOwners ON (OwnerUserName.idRole = RoleOwners.id)
INNER JOIN taverns ON (OwnerUserName.id = Taverns.id)
INNER JOIN locationAddress ON (Taverns.id = locationAddress.id)
WHERE RoleOwners.RoleDescription LIKE '%admin%'

3

--SELECT Guests.Name, Class.Name, Level FROM Levels1
-- INNER JOIN Guests ON (Guests.id = Levels1.idGuest)
-- INNER JOIN Class ON (class.id= Level1s.idClass)
-- ORDER BY Guests.Name asc;

4. select * from Levels1

SELECT TOP 10 Price, Services.Name FROM Sales1
INNER JOIN Services ON (Sales1.idServices = Services.id)
ORDER BY Price desc;

5.

--SELECT idGuest, Guests.Name, Classes.Name, Level FROM Levels1
-- INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
-- INNER JOIN Classes ON (Levels1.idClass = Classes.id)
-- WHERE idGuest IN (SELECT idGuest FROM Levels GROUP BY idGuest HAVING COUNT(idGuest) > 1)
-- ORDER BY Guests.Name;

6.

SELECT idGuest, Guests.Name, Classes.Name, Level FROM Levels1
INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
INNER JOIN Classes ON (Levels1.idClass = Classes.id)
WHERE Level > 5 AND idGuest IN (SELECT idGuest FROM Levels1 GROUP BY idGuest HAVING COUNT(idGuest) > 1)
ORDER BY idGuest;



7.
SELECT idGuest, Guests.Name, Max(Level) AS HighestLevel FROM Levels1
INNER JOIN Guests ON (Levels1.idGuest = Guests.id)
INNER JOIN Classes ON (Levels1.idClass = Classes.id)
GROUP BY idGuest, Guests.Name;

8.

SELECT Guests.Name, Stays.CheckedIn, Stays.CheckedOut FROM Guests
INNER JOIN Stays ON (Guests.id = Stays.idGuest)
WHERE CheckedIn BETWEEN ('11/01/2019') and ('11/30/2019') OR
     CheckedOut BETWEEN ('11/01/2019') and ('11/30/2019');



 --ALTER TABLE Stays ADD FOREIGN KEY (idRoom) REFERENCES Rooms(id);

9.
 SELECT CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as CreateTableTemplate
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE,
(CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
Then CONCAT
('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')')
Else ''
END),
CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
Then
(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')'))
Else ''
END,
CASE WHEN keys.CONSTRAINT_NAME LIKE '%PK%'
THEN
(' IDENTITY(1,1) PRIMARY KEY')
ELSE ''
END,
',') as queryPiece
FROM INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
WHERE cols.TABLE_NAME = 'Taverns'
UNION ALL
SELECT ');';


 -->











-------------------hw3


--2:
SELECT * From BasementRats
EXCEPT
SELECT * From BasementRats
WHERE ID <= 100;


--3:
SELECT * From BasementRats
EXCEPT
SELECT * From BasementRats
WHERE Name > '01/01/2000';



--4:
SELECT DISTINCT Name From Guests;


--5:
SELECT * FROM Guests order by Name asc;

--6:
SELECT TOP 10 * FROM Sales ORDER BY Age desc;

7-


SELECT id,Name FROM INFORMATION_SCHEMA.COLUMNS AS NamesAndids WHERE NAME="mattoverstrom"


8.

SELECT ClassID, GuestID, Level,
CASE WHEN Level BETWEEN 1 and 10 THEN 'Noob'
WHEN Level BETWEEN 11 and 20 THEN 'Intermediate'
WHEN Level BETWEEN 21 and 30 THEN 'Pro'
WHEN Level BETWEEN 31 and 40 THEN 'Expert'
WHEN Level BETWEEN 41 and 50 THEN 'Master'
END AS Brackets FROM GuestClass;

9-
SELECT CONCAT ('INSERT INTO ',TABLE_NAME,' (Name, Floors)') AS InsertCommands
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Taverns'

<!-- 
  -------------------------------------------------------------------

 

<--  CREATE TABLE Locations (
ID int Identity PRIMARY KEY,
Name varchar(100) NOT NULL,
);

INSERT INTO Locations
(Name)
VALUES
('West Side'),
('Red Light District'),
('Wonderland'),
('Camelot'),
('Sector 9'),
('R''yleah'); -->




<!--
CREATE TABLE Roles (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE,
Description varchar(100) NOT NULL,
);

INSERT INTO Roles
(Name, Description)
VALUES
('Owner', 'Ye owns the lot of em'),
('Wench', 'Serve dem drinks'),
('Barkeep', ' Make dem drinks'),
('Bard', 'Sing dem songs'),
('Guard', 'Bash Dem skulls'),
('Stable Boy', 'Shovel dem turds');
-->


<!-- CREATE TABLE Supplies (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE,
Unit varchar(20) NOT NULL,
);

INSERT INTO Supplies
(Name, Unit)
VALUES
('Mead', 'ounces'),
('Ale', 'ounces'),
('Rum', 'jugs'),
('Cheetos', 'bags'),
('Caltrops', 'sacks'),
('Gunpowder', 'pounds'),
('Maple Syrup', 'gallons'),
('Poison', 'liters'),
('Darts', 'cases'),
('Soap?', 'bars'),
('Rope!', 'feet');
-->


<!-- -- CREATE TABLE Status (
ID int Identity PRIMARY KEY,
Status varchar(20) NOT NULL UNIQUE,
);
--> -->
<!-- INSERT INTO Status
(Status)
VALUES
('Valid'),
('Invalid'),
('Dead'),
('Cursed'),
('Restricted');
-->
-->



<!--
CREATE TABLE Services (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE,
StatusID int NOT NULL,CONSTRAINT FK_Status FOREIGN KEY (StatusID)
REFERENCES Status(ID)
ON DELETE CASCADE
);

INSERT INTO Services
(Name, StatusID)
VALUES
('Rent a Room', 1),
('Spin a Tale', 1),
('Dunk the Drunk', 2),
('Drown the Clown', 5),
('Assasination', 3),
('Weapon Sharpening', 3),
('Identify', 4);
-->



<!-- CREATE TABLE Users (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL,
RoleId int NOT NULL,CONSTRAINT FK_Role FOREIGN KEY (RoleID)
REFERENCES Roles(ID)
ON DELETE CASCADE
);

INSERT INTO Users
(Name, RoleId)
VALUES
('Buck Rogers', 1),
('Moe', 1),
('Swarthy Daniels', 1),
('Bjorn Bjorgenson', 5),
('Daisy Duke', 2),
('Cthulhu', 3),
('Deckard Cain', 1),
('Bob Ross', 4),
('Shawn Dougherty', 6);

-->




<!-- CREATE TABLE Taverns (
ID int Identity PRIMARY KEY,
Name varchar(100) NOT NULL,
Floors int NOT NULL,
LocationID int NOT NULL,CONSTRAINT FK_Loc FOREIGN KEY (LocationID)
REFERENCES Locations(ID)
ON DELETE CASCADE,
OwnerID int NOT NULL,CONSTRAINT FK_Own FOREIGN KEY (OwnerID)
REFERENCES Users(ID)
ON DELETE CASCADE
);

INSERT INTO Taverns
(Name, LocationID, Floors, OwnerId)
VALUES
('Buck Roger''s', 1, 2, 1),
('Moe''s', 3, 1, 2),
('Pain Train', 4, 6, 3),
('Lover''s Quarrel', 2, 4, 3),
('Stay Awhile', 5, 4, 7),
('The Dive', 2, 3, 3),
('The Deep', 6, 5, 3);
-->




<!-- CREATE TABLE BasementRats (
ID int Identity PRIMARY KEY,
Name varchar(100) NOT NULL,
TavernID int NOT NULL,CONSTRAINT FK_TavernRats FOREIGN KEY (TavernID)
REFERENCES Taverns(ID)
ON DELETE CASCADE
);

INSERT INTO BasementRats
(Name, TavernID)
VALUES
('Doc', 1),
('Grumpy', 2),
('Happy', 3),
('Sleepy', 4),
('Dopey', 5),
('Bashful', 5),
('Sneezy', 7);
-->



<!--

CREATE TABLE Inventory (
Count int NOT NULL,
Date datetime NOT NULL,
TavernID int,CONSTRAINT FK_TavernInv FOREIGN KEY (TavernID)
REFERENCES Taverns(ID)
ON DELETE CASCADE,
SupplyID int,CONSTRAINT FK_SupplyInv FOREIGN KEY (SupplyID)
REFERENCES Supplies(ID)
ON DELETE CASCADE,
PRIMARY KEY (TavernID, SupplyID)
);

INSERT INTO Inventory
(TavernID, SupplyID, Count, Date)
VALUES
(1, 1, 23, GETDATE()),
(1, 5, 69, GETDATE()),
(1, 4, 17, GETDATE()),
(2, 2, 13, GETDATE()),
(2, 7, 5, GETDATE()),
(3, 11, 123, GETDATE()),
(3, 9, 236, GETDATE()),
(3, 5, 6, GETDATE()),
(4, 7, 31, GETDATE()),
(5, 3, 44, GETDATE()),
(6, 8, 67, GETDATE()),
(7, 2, 88, GETDATE()),
(7, 9, 92, GETDATE()),
(7, 10, 2, GETDATE());

-->



<!--
CREATE TABLE Receiving (
ID int Identity PRIMARY KEY,
Quantity int NOT NULL,
Cost smallmoney NOT NULL,
TavernID int NOT NULL, CONSTRAINT FK_TavernRec FOREIGN KEY (TavernID)
REFERENCES Taverns(ID)
ON DELETE CASCADE,
SupplyID int NOT NULL,CONSTRAINT FK_SupplyRec FOREIGN KEY (SupplyID)
REFERENCES Supplies(ID)
ON DELETE CASCADE
);

INSERT INTO Receiving
(TavernID, SupplyID, Quantity, Cost)
VALUES
(1, 4, 14, $4.38),
(2, 2, 3, $41.13),
(3, 7, 75, $6.28),
(4, 8, 43, $0.18),
(5, 11, 2, $214.56),
(6, 5, 77, $4.70),
(7, 8, 92, $1.38),
(4, 8, 62, $231.98),
(2, 2, 4, $6.99),
(6, 10, 12, $16.08),
(1, 9, 6453, $21.33),
(7, 4, 2, $12.76),
(1, 7, 204, $22.17),
(2, 3, 12, $33.43); -->


<!-- CREATE TABLE GuestStatus (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE
);

INSERT INTO GuestStatus
(Name)
VALUES
('Hangry'),
('Enraged'),
('Drunk'),
('Enchanted'),
('Sleepy'); -->

<!-- CREATE TABLE Class (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE
);


INSERT INTO Class
(Name)
VALUES
('Barberbidon'),
('Sorcherawr'),
('Drunk'),
('Pyromancer'),
('Renger');
-->

<!-- CREATE TABLE Guests (
ID int Identity PRIMARY KEY,
Name varchar(50) NOT NULL UNIQUE,
Birthday date DEFAULT(GETDATE()) NOT NULL,
Cakeday date DEFAULT(GETDATE()) NOT NULL,
StatusID int NOT NULL, CONSTRAINT FK_Guests_Status FOREIGN KEY (StatusID)
REFERENCES GuestStatus(ID)
ON DELETE CASCADE,

);

INSERT INTO Guests
(Name,StatusID)
VALUES
('Minsc', 1),
('Boo', 1),
('Steve Harvey',3),
('Judas Priest',2),
('Bane',1),
('Radigast',5),
('Count Dookie',2);

-->
<!--
CREATE TABLE GuestClass (
ClassID int, CONSTRAINT FK_GuestClass_Class FOREIGN KEY (ClassID)
REFERENCES Class(ID)
ON DELETE CASCADE,
GuestID int, CONSTRAINT FK_Guests_Guests FOREIGN KEY (GuestID)
REFERENCES Guests(ID)
ON DELETE CASCADE,
Level int NOT NULL,
PRIMARY KEY (ClassId, GuestId)
);




CREATE TABLE ServicesSales (
ID int Identity PRIMARY KEY,
Price smallmoney NOT NULL,
DatePurchased date NOT NULL,
QuantityPurchased int NOT NULL,
TavernID int NOT NULL,CONSTRAINT FK_Tavern_Sales FOREIGN KEY (TavernID)
REFERENCES Taverns(ID)
ON DELETE CASCADE,
ServiceID int NOT NULL,CONSTRAINT FK_Services_Sales FOREIGN KEY (ServiceID)
REFERENCES Services(ID)
ON DELETE CASCADE,
GuestId int NOT NULL,CONSTRAINT FK_ServSales_Guest FOREIGN KEY (GuestId)
REFERENCES Guests(Id)
ON DELETE CASCADE
);


INSERT INTO ServicesSales
(TavernID, ServiceID, GuestId, Price, QuantityPurchased, DatePurchased)
VALUES
(1, 7, 3, $2.34, 2, GETDATE()),
(7, 7, 2, $1564, 1, GETDATE()),
(4, 4, 2, $45.98, 4, GETDATE()),
(5, 2, 1, $2.12, 3, GETDATE()),
(2, 1, 5, $432.76, 14, GETDATE()),
(2, 5, 3, $0.01, 114, GETDATE()),
(2, 6, 2, $64.64, 5, GETDATE()),
(6, 6, 5, $16, 1, GETDATE()),
(4, 2, 1, $1.38, 1307, GETDATE()),
(3, 1, 2, $3.50, 1987, GETDATE()),
(1, 7, 4, $3.50, 2018, GETDATE());
-->

<!-- CREATE TABLE SuppliesSales (
ID int Identity PRIMARY KEY,
Price smallmoney NOT NULL,
DatePurchased date NOT NULL,
QuantityPurchased int NOT NULL,
TavernID int NOT NULL,CONSTRAINT FK_SupSales_Tavern FOREIGN KEY (TavernID)
REFERENCES Taverns(ID)
ON DELETE CASCADE,
SupplyID int NOT NULL,CONSTRAINT FK_SupSales_Supplies FOREIGN KEY (SupplyID)
REFERENCES Supplies(ID)
ON DELETE CASCADE,
GuestId int NOT NULL,CONSTRAINT FK_SupSales_Guest FOREIGN KEY (GuestId)
REFERENCES Guests(Id)
ON DELETE CASCADE,
);


INSERT INTO SuppliesSales
(TavernID, SupplyID, GuestId, Price, QuantityPurchased, DatePurchased)
VALUES
(1, 7, 3, $2.34, 2, GETDATE()),
(7, 7, 2, $1564, 1, GETDATE()),
(4, 4, 2, $45.98, 4, GETDATE()),
(5, 2, 1, $2.12, 3, GETDATE()),
(2, 1, 5, $432.76, 14, GETDATE()),
(2, 5, 3, $0.01, 114, GETDATE()),
(2, 6, 2, $64.64, 5, GETDATE()),
(6, 6, 5, $16, 1, GETDATE()),
(4, 2, 1, $1.38, 1307, GETDATE()),
(3, 1, 2, $3.50, 1987, GETDATE()),
(1, 7, 4, $3.50, 2018, GETDATE()); --> -->


SELECT CONCAT('Concat table', TABLE_NAME, ' (') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT (COLUMN_NAME,' ', DATA_TYPE, ' ',
    (CASE WHEN DATA_TYPE = 'varchar'
    THEN CONCAT ('(', CHARACTER_MAXIMUM_LENGTH, ')') ELSE ' ' END ))  AS NewColumnName
    FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT ')'
