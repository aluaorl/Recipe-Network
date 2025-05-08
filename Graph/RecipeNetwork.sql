USE master;
GO
DROP DATABASE IF EXISTS RecipeNetwork;
GO
CREATE DATABASE RecipeNetwork;
GO
USE RecipeNetwork;
GO

-----------------------------------�������� ������ �����---------------------------


--Recipes
CREATE TABLE Recipes (
    RecipeID INT NOT NULL PRIMARY KEY,
    RecipeName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Rating DECIMAL(2,1) CHECK (Rating >= 0 AND Rating <= 5)
) AS NODE;

--Ingredients
CREATE TABLE Ingredients (
    IngredientID INT NOT NULL PRIMARY KEY,
    IngredientName NVARCHAR(255) NOT NULL,
    Category NVARCHAR(255) NULL
) AS NODE;

--CookingTechniques
CREATE TABLE CookingTechniques (
    TechniqueID INT NOT NULL PRIMARY KEY,
    TechniqueName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL
) AS NODE;

--Equipment
CREATE TABLE Equipment (
    EquipmentID INT NOT NULL PRIMARY KEY,
    EquipmentName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL
) AS NODE;

----------------------------------------�������� ������ �����-------------------------------

--ContainsIn
CREATE TABLE ConsistsOf (
    Quantity DECIMAL(10,2) NOT NULL
) AS EDGE;

--Includes
CREATE TABLE Includes AS EDGE;

--Uses
CREATE TABLE Uses AS EDGE;

--------------------------------------����������� �����----------------------------------

ALTER TABLE ConsistsOf
ADD CONSTRAINT EC_ConsistsOf CONNECTION (Recipes TO Ingredients  );

ALTER TABLE Includes
ADD CONSTRAINT EC_Includes CONNECTION (Recipes TO CookingTechniques);

ALTER TABLE Uses
ADD CONSTRAINT EC_Uses CONNECTION (CookingTechniques TO Equipment);

-----------------------------------���������� ������ �����-----------------------------------

-- ���������� ������� Recipes
INSERT INTO Recipes (RecipeID, RecipeName, Description, Rating) VALUES
(1, N'����� ���������', N'������������ ����������� ����� � ���������, ������ � �����.', 4.5),
(2, N'����', N'������������ ���������� ��� �� ������� � �������.', 4.8),
(3, N'�������� �����', N'�������� ����� � �������� � �������.', 4.6),
(4, N'����� ������', N'���������� ����� � ��������, ���������� � ������ ������.', 4.3),
(5, N'����', N'��������� ����� �� ����, ���� � ������.', 4.7),
(6, N'����� ������', N'������������ ������� ����� � ������� � ���������.', 4.4),
(7, N'�����', N'������� ����� ����.', 4.9),
(8, N'����� ���������', N'������� ����� � ��������, ���������� � ���������.', 4.1),
(9, N'������� ���', N'������ � �������� ��� � ������� � �������.', 4.7),
(10, N'��������� �����', N'������ ����� � ��������, ����������, ����� � ��������.', 4.6);

-- ���������� ������� Ingredients
INSERT INTO Ingredients (IngredientID, IngredientName, Category) VALUES
(1, N'��������', N'��������'),
(2, N'����', N'�������� ��������'),
(3, N'�����', N'����'),
(4, N'���', N'�������� ��������'),
(5, N'������', N'�������� ��������'),
(6, N'������', N'�����'),
(7, N'�������', N'�����'),
(8, N'���', N'�����'),
(9, N'������', N'������'),
(10, N'����', N'��������'),
(11, N'������', N'�������� ��������'),
(12, N'����� ���������', N'�������� ��������'),
(13, N'������', N'�������������'),
(14, N'���', N'��������'),
(15, N'���������', N'�����'),
(16, N'��������', N'����'),
(17, N'������', N'�����'),
(18, N'���������', N'�������� ��������'),
(19, N'������', N'�����'),
(20, N'����', N'�������� ��������'),
(21, N'������', N'����'),
(22, N'�������', N'�������� ��������'),
(23, N'�����', N'�����'),
(24, N'������� �������', N'��������');

-- ���������� ������� CookingTechniques
INSERT INTO CookingTechniques (TechniqueID, TechniqueName, Description) VALUES
(1, N'�����', N'������������� � ���� ��� 100�C'),
(2, N'�����', N'������������� � ������� �����'),
(3, N'�������', N'������������� � ������� � ����� ������'),
(4, N'�����', N'������������� �� �������� ����'),
(5, N'�������', N'��������� ������������� � ��������'),
(6, N'��������', N'���������� ����, ���� ��� ����� � �������������'),
(7, N'���������', N'����������� ������������� ��� ��������� ��������'),
(8, N'�����������', N'���������� ��������� � ������� ��� ������'),
(9, N'����������', N'���������� ���������� ������������ ������'),
(10, N'�������', N'���������� ������������ �� ����� ������ �����');

-- ���������� ������� Equipment
INSERT INTO Equipment (EquipmentID, EquipmentName, Description) VALUES
(1, N'��������', N'��� ����� �����, �������� � ������ ���� � ����.'),
(2, N'���������', N'��� ����� ����, ������, ��� � ������ ���������.'),
(3, N'�������', N'��� ������� �������, �����, ��������� ���� � ������.'),
(4, N'�������-�����', N'��� ����� ���� � ������ �� �������� ���� ��� ������������� �����.'),
(5, N'��������', N'��� ������� ����, ������ � ������ ����.'),
(6, N'���', N'��� �������� ����, ���� � �����. ��� �������.'),
(7, N'������', N'��� ��������� ���, ������, ������ � ������ ������������.'),
(8, N'������� ��� �����������', N'��� ����������� ����, ����, ������ � ������ ���������.'),
(9, N'�����', N'��� ���������� ������������.'),
(10, N'����������� �����', N'��� ������� ������, ����, ���� � ������ ���������.'),
(11, N'��������', N'��� ��������� ����� � ������ ������ ����.');


----------------------------------------���������� ������ �����--------------------------------

-- ��������� ������� � ������������� (ContainsIn)
INSERT INTO ConsistsOf ($from_id, $to_id, Quantity)
VALUES
-- ����� ���������
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 1), 200), -- �������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 2),   -- ���� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 3), 100), -- ����� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 4), 50),  -- ��� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 5), 50),  -- ������ (������)

-- ����
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 6), 200),  -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),  -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 8), 1),    -- ��� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 300), -- �������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 200), -- ��������� (������)

-- �������� �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 2),   -- ���� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 9), 500),  -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 10), 200), -- ���� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 11), 100), -- ������ (����������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 12), 100), -- ����� ��������� (������)

-- ����� ������
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 13), 100), -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 4), 50),  -- ��� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 23), 150), -- ����� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 50),  -- �������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 1),   -- ���� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 22), 150),  -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 21), 300),  -- ������ (������)

-- ����
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 14), 500),  -- ��� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 500),  -- �������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),   -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 8), 1),     -- ��� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 100),  -- �������� (������)

-- ����� ������
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 300),  -- ��������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 4),    -- ���� (�����)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 22), 150),  -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),   -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 24), 100),   -- ������� ������� (������)

-- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 300),  -- �������� (������)

-- ����� ���������
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 200),  -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM Ingredients WHERE IngredientID = 18), 150),  -- ��������� (������)

-- ������� ���
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 21), 300),  -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),  -- ������� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 200),  -- ��������� (������)

-- ��������� �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 19), 200), -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 200), -- ������ (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 20), 100), -- ���� (������)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 23), 100); -- ����� (������)

-- ��������� ������� � ��������� ������������� (Includes)
INSERT INTO Includes ($from_id, $to_id)
VALUES
-- ����� ���������
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- ����������

-- ����
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5)), -- �������
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������

-- �������� �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3)), -- �������
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 7)), -- ���������

-- ����� ������
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- ����������
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������

-- ����
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5)), -- �������
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������

-- ����� ������
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- ����������

-- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 4)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6)), -- ��������
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 8)), -- �����������

-- ����� ���������
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3)), -- �������

-- ������� ���
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������

-- ��������� �����
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- �������
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)); -- ����������

-- ��������� ������� ������������� � ������������� (Uses)
INSERT INTO Uses ($from_id, $to_id)
VALUES
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1), (SELECT $node_id FROM Equipment WHERE EquipmentID = 1)),  -- ����� - ��������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2), (SELECT $node_id FROM Equipment WHERE EquipmentID = 2)),  -- ����� - ���������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3), (SELECT $node_id FROM Equipment WHERE EquipmentID = 3)),  -- ������� - �������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 4), (SELECT $node_id FROM Equipment WHERE EquipmentID = 4)),  -- ����� - �����
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5), (SELECT $node_id FROM Equipment WHERE EquipmentID = 5)),  -- ������� - ��������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6), (SELECT $node_id FROM Equipment WHERE EquipmentID = 6)),  -- �������� - ���
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 7), (SELECT $node_id FROM Equipment WHERE EquipmentID = 7)),  -- ��������� - ������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 8), (SELECT $node_id FROM Equipment WHERE EquipmentID = 8)),  -- ����������� - �������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9), (SELECT $node_id FROM Equipment WHERE EquipmentID = 9)),  -- ���������� - �����
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10), (SELECT $node_id FROM Equipment WHERE EquipmentID = 6)), -- ������� - ���
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1), (SELECT $node_id FROM Equipment WHERE EquipmentID = 11)), -- ����� - ��������
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6), (SELECT $node_id FROM Equipment WHERE EquipmentID = 10)), -- �������� - ����������� �����
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10), (SELECT $node_id FROM Equipment WHERE EquipmentID = 10)); -- ������� - ����������� �����

----------------------------------------������� � �������� MATCH---------------------------------------------------------

--1. ����� ������������ ������������ ��� ������������� ��������, � ������� ���� "������"?
SELECT DISTINCT EquipmentName
FROM Equipment, CookingTechniques, Recipes, Ingredients, Uses, Includes, ConsistsOf
WHERE MATCH(Ingredients<-(ConsistsOf)-Recipes-(Includes)->CookingTechniques-(Uses)->Equipment)
AND IngredientName = N'������';

--2. ����� ������� ���������� �� �� �����������, ��� � "����� ���������"? ���� ������ ������ �������, ������� ����� ����� ����������� � ������ ���������.
SELECT DISTINCT R2.RecipeName
FROM Recipes AS R1, Recipes AS R2, ConsistsOf AS COF1, ConsistsOf AS COF2, Ingredients AS ING
WHERE MATCH(R1-(COF1)->ING<-(COF2)-R2)
AND R1.RecipeName = N'����� ���������'
AND R2.RecipeName <> N'����� ���������';

--3. ����� ������� ���������� �� �� ������� �������������, ��� � "����"? ���� ������ ������ �������, ������� ���������� ����� ������� ������������� � ������.
SELECT DISTINCT R2.RecipeName
FROM Recipes AS R1, Recipes AS R2, Includes AS I1, Includes AS I2, CookingTechniques AS CT
WHERE MATCH(R1-(I1)->CT<-(I2)-R2)
AND R1.RecipeName = N'����'
AND R2.RecipeName <> N'����';

--4. ����� ����������� ������������ � ��������, ������� ������� "�����"? ���� ������ ������ �����������, ������� ������������ � ��������, ��� ����������� ������� �����
SELECT DISTINCT I.IngredientName
FROM Ingredients AS I, Recipes AS R, Includes AS INC, CookingTechniques AS CT, ConsistsOf AS COF
WHERE MATCH(CT<-(INC)-R-(COF)->I)
AND CT.TechniqueName = N'�����';

--5. ����� ����������� ������ � ������� � ����� ������� ��������� (������ 4.7)? ���� ������ ������ �����������, ������������ � �������� � ��������� ���� 4.7.
SELECT DISTINCT I.IngredientName
FROM Ingredients AS I, Recipes AS R, ConsistsOf AS COF
WHERE MATCH(R-(COF)->I)
AND R.Rating > 4.7;

----------------------------------------������� � �������� SHORTEST_PATH---------------------------------------------------------

--1.����� ��� ����������� ��� ������� "����� ���������"
SELECT 
    R.RecipeName AS StartRecipe,
    STRING_AGG(I.IngredientName, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToIngredients
FROM 
    Recipes AS R,
    ConsistsOf FOR PATH AS C,
    Ingredients FOR PATH AS I
WHERE 
    MATCH(SHORTEST_PATH(R(-(C)->I)+))
    AND R.RecipeName = '����� ���������';

-- 2. ����� ��� ������� �������������, ������� ������������ ��� ������������� �����
SELECT 
    R.RecipeName AS StartRecipe,
    STRING_AGG(CT.TechniqueName, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToTechniques
FROM
     Recipes AS R,
     Includes FOR PATH AS I,
     CookingTechniques FOR PATH AS CT
WHERE 
    MATCH(SHORTEST_PATH(R(-(I)->CT){1,3}))
    AND R.RecipeName = '����';

---------------------------------------------Power BI-------------------------------------

SELECT @@SERVERNAME
-- ������: DESKTOP-TI9JN07\SQLEXPRESS
-- ���� ������: RecipeNetwork
-- ���� � ��������: --https://raw.githubusercontent.com/aluaorl/Recipe-Network/refs/heads/main/pictures/

-- 1. ������� � ����������� (ConsistsOf)
SELECT
    R.RecipeID AS IdFirst,
    R.RecipeName AS First,
    CONCAT(N'recipe', R.RecipeID) AS [First image name],  
    I.IngredientID AS IdSecond,
    I.IngredientName AS Second,
    CONCAT(N'ingredient', I.IngredientID) AS [Second image name] 
FROM 
    Recipes AS R,
    ConsistsOf AS COF, 
    Ingredients AS I
WHERE MATCH(R-(COF)->I);

-- 2. ������� � ������� ������������� (Includes)
SELECT
    R.RecipeID AS IdFirst,
    R.RecipeName AS First,
    CONCAT(N'recipe', R.RecipeID) AS [First image name], 
    CT.TechniqueID AS IdSecond,
    CT.TechniqueName AS Second,
    CONCAT(N'technique', CT.TechniqueID) AS [Second image name]
FROM Recipes AS R,
     Includes AS I,
     CookingTechniques AS CT
WHERE MATCH(R-(I)->CT);

-- 3. ������� ������������� � ������������ (Uses)
SELECT
    CT.TechniqueID AS IdFirst,
    CT.TechniqueName AS First,
    CONCAT(N'technique', CT.TechniqueID) AS [First image name], 
    E.EquipmentID AS IdSecond,
    E.EquipmentName AS Second,
    CONCAT(N'equipment', E.EquipmentID) AS [Second image name]
FROM 
    CookingTechniques AS CT,
    Uses AS U,
    Equipment AS E
WHERE MATCH(CT-(U)->E);