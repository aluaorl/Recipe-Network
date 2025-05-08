USE master;
GO
DROP DATABASE IF EXISTS RecipeNetwork;
GO
CREATE DATABASE RecipeNetwork;
GO
USE RecipeNetwork;
GO

-----------------------------------Создание таблиц узлов---------------------------


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

----------------------------------------Создание таблиц ребер-------------------------------

--ContainsIn
CREATE TABLE ConsistsOf (
    Quantity DECIMAL(10,2) NOT NULL
) AS EDGE;

--Includes
CREATE TABLE Includes AS EDGE;

--Uses
CREATE TABLE Uses AS EDGE;

--------------------------------------Ограничение ребер----------------------------------

ALTER TABLE ConsistsOf
ADD CONSTRAINT EC_ConsistsOf CONNECTION (Recipes TO Ingredients  );

ALTER TABLE Includes
ADD CONSTRAINT EC_Includes CONNECTION (Recipes TO CookingTechniques);

ALTER TABLE Uses
ADD CONSTRAINT EC_Uses CONNECTION (CookingTechniques TO Equipment);

-----------------------------------Заполнение таблиц узлов-----------------------------------

-- Заполнение таблицы Recipes
INSERT INTO Recipes (RecipeID, RecipeName, Description, Rating) VALUES
(1, N'Паста Карбонара', N'Классическое итальянское блюдо с панчеттой, яйцами и сыром.', 4.5),
(2, N'Борщ', N'Традиционный славянский суп со свеклой и овощами.', 4.8),
(3, N'Яблочный пирог', N'Домашний пирог с яблоками и корицей.', 4.6),
(4, N'Салат Цезарь', N'Популярный салат с гренками, пармезаном и соусом Цезарь.', 4.3),
(5, N'Плов', N'Восточное блюдо из риса, мяса и специй.', 4.7),
(6, N'Салат Оливье', N'Традиционный русский салат с овощами и майонезом.', 4.4),
(7, N'Стейк', N'Жареный кусок мяса.', 4.9),
(8, N'Пицца Маргарита', N'Простая пицца с томатами, моцареллой и базиликом.', 4.1),
(9, N'Куриный суп', N'Легкий и полезный суп с курицей и овощами.', 4.7),
(10, N'Греческий салат', N'Свежий салат с огурцами, помидорами, фетой и оливками.', 4.6);

-- Заполнение таблицы Ingredients
INSERT INTO Ingredients (IngredientID, IngredientName, Category) VALUES
(1, N'Спагетти', N'Зерновые'),
(2, N'Яйца', N'Молочные продукты'),
(3, N'Бекон', N'Мясо'),
(4, N'Сыр', N'Молочные продукты'),
(5, N'Сливки', N'Молочные продукты'),
(6, N'Свекла', N'Овощи'),
(7, N'Морковь', N'Овощи'),
(8, N'Лук', N'Овощи'),
(9, N'Яблоки', N'Фрукты'),
(10, N'Мука', N'Зерновые'),
(11, N'Молоко', N'Молочные продукты'),
(12, N'Масло сливочное', N'Молочные продукты'),
(13, N'Гренки', N'Хлебобулочные'),
(14, N'Рис', N'Зерновые'),
(15, N'Картофель', N'Овощи'),
(16, N'Говядина', N'Мясо'),
(17, N'Томаты', N'Овощи'),
(18, N'Моцарелла', N'Молочные продукты'),
(19, N'Огурцы', N'Овощи'),
(20, N'Фета', N'Молочные продукты'),
(21, N'Курица', N'Мясо'),
(22, N'Майонез', N'Молочные продукты'),
(23, N'Салат', N'Овощи'),
(24, N'Зеленый горошек', N'Консервы');

-- Заполнение таблицы CookingTechniques
INSERT INTO CookingTechniques (TechniqueID, TechniqueName, Description) VALUES
(1, N'Варка', N'Приготовление в воде при 100°C'),
(2, N'Жарка', N'Приготовление в горячем масле'),
(3, N'Выпечка', N'Приготовление в духовке с сухим теплом'),
(4, N'Гриль', N'Приготовление на открытом огне'),
(5, N'Тушение', N'Медленное приготовление в жидкости'),
(6, N'Разделка', N'Подготовка мяса, рыбы или птицы к приготовлению'),
(7, N'Взбивание', N'Интенсивное перемешивание для насыщения воздухом'),
(8, N'Маринование', N'Сохранение продуктов в рассоле или уксусе'),
(9, N'Смешивание', N'Соединение нескольких ингредиентов вместе'),
(10, N'Нарезка', N'Разделение ингредиентов на более мелкие части');

-- Заполнение таблицы Equipment
INSERT INTO Equipment (EquipmentID, EquipmentName, Description) VALUES
(1, N'Кастрюля', N'Для варки супов, гарниров и других блюд в воде.'),
(2, N'Сковорода', N'Для жарки мяса, овощей, яиц и других продуктов.'),
(3, N'Духовка', N'Для выпечки пирогов, хлеба, запекания мяса и овощей.'),
(4, N'Электро-Гриль', N'Для жарки мяса и овощей на открытом огне или электрическом гриле.'),
(5, N'Сотейник', N'Для тушения мяса, овощей и других блюд.'),
(6, N'Нож', N'Для разделки мяса, рыбы и птицы. Для нарезки.'),
(7, N'Миксер', N'Для взбивания яиц, сливок, кремов и других ингредиентов.'),
(8, N'Емкость для маринования', N'Для маринования мяса, рыбы, овощей и других продуктов.'),
(9, N'Миска', N'Для смешивания ингредиентов.'),
(10, N'Разделочная доска', N'Для нарезки овощей, мяса, рыбы и других продуктов.'),
(11, N'Половник', N'Для наливания супов и других жидких блюд.');


----------------------------------------Заполнение таблиц ребер--------------------------------

-- Связываем рецепты с ингредиентами (ContainsIn)
INSERT INTO ConsistsOf ($from_id, $to_id, Quantity)
VALUES
-- Паста Карбонара
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 1), 200), -- Спагетти (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 2),   -- Яйца (штуки)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 3), 100), -- Бекон (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 4), 50),  -- Сыр (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM Ingredients WHERE IngredientID = 5), 50),  -- Сливки (граммы)

-- Борщ
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 6), 200),  -- Свекла (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),  -- Морковь (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 8), 1),    -- Лук (штука)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 300), -- Говядина (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 200), -- Картофель (граммы)

-- Яблочный пирог
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 2),   -- Яйца (штуки)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 9), 500),  -- Яблоки (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 10), 200), -- Мука (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 11), 100), -- Молоко (миллилитры)
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM Ingredients WHERE IngredientID = 12), 100), -- Масло сливочное (граммы)

-- Салат Цезарь
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 13), 100), -- Гренки (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 4), 50),  -- Сыр (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 23), 150), -- Салат (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 50),  -- Помидоры (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 1),   -- Яйца (штуки)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 22), 150),  -- Майонез (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM Ingredients WHERE IngredientID = 21), 300),  -- Курица (граммы)

-- Плов
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 14), 500),  -- Рис (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 500),  -- Говядина (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),   -- Морковь (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 8), 1),     -- Лук (штука)
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 100),  -- Помидоры (граммы)

-- Салат Оливье
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 300),  -- Картофель (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 2), 4),    -- Яйца (штуки)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 22), 150),  -- Майонез (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),   -- Морковь (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM Ingredients WHERE IngredientID = 24), 100),   -- Зеленый горошек (граммы)

-- Стейк
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM Ingredients WHERE IngredientID = 16), 300),  -- Говядина (граммы)

-- Пицца Маргарита
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 200),  -- Томаты (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM Ingredients WHERE IngredientID = 18), 150),  -- Моцарелла (граммы)

-- Куриный суп
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 21), 300),  -- Курица (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 7), 100),  -- Морковь (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM Ingredients WHERE IngredientID = 15), 200),  -- Картофель (граммы)

-- Греческий салат
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 19), 200), -- Огурцы (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 17), 200), -- Томаты (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 20), 100), -- Фета (граммы)
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM Ingredients WHERE IngredientID = 23), 100); -- Салат (граммы)

-- Связываем рецепты с техниками приготовления (Includes)
INSERT INTO Includes ($from_id, $to_id)
VALUES
-- Паста Карбонара
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- Варка
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2)), -- Жарка
((SELECT $node_id FROM Recipes WHERE RecipeID = 1), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- Смешивание

-- Борщ
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- Варка
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5)), -- Тушение
((SELECT $node_id FROM Recipes WHERE RecipeID = 2), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка

-- Яблочный пирог
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3)), -- Выпечка
((SELECT $node_id FROM Recipes WHERE RecipeID = 3), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 7)), -- Взбивание

-- Салат Цезарь
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- Смешивание
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2)), -- Жарка
((SELECT $node_id FROM Recipes WHERE RecipeID = 4), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка

-- Плов
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- Варка
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5)), -- Тушение
((SELECT $node_id FROM Recipes WHERE RecipeID = 5), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка

-- Салат Оливье
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- Варка
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка
((SELECT $node_id FROM Recipes WHERE RecipeID = 6), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)), -- Смешивание

-- Стейк
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 4)), -- Гриль
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6)), -- Разделка
((SELECT $node_id FROM Recipes WHERE RecipeID = 7), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 8)), -- Маринование

-- Пицца Маргарита
((SELECT $node_id FROM Recipes WHERE RecipeID = 8), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3)), -- Выпечка

-- Куриный суп
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1)), -- Варка
((SELECT $node_id FROM Recipes WHERE RecipeID = 9), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка

-- Греческий салат
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10)), -- Нарезка
((SELECT $node_id FROM Recipes WHERE RecipeID = 10), (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9)); -- Смешивание

-- Связываем техники приготовления с оборудованием (Uses)
INSERT INTO Uses ($from_id, $to_id)
VALUES
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1), (SELECT $node_id FROM Equipment WHERE EquipmentID = 1)),  -- Варка - Кастрюля
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 2), (SELECT $node_id FROM Equipment WHERE EquipmentID = 2)),  -- Жарка - Сковорода
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 3), (SELECT $node_id FROM Equipment WHERE EquipmentID = 3)),  -- Выпечка - Духовка
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 4), (SELECT $node_id FROM Equipment WHERE EquipmentID = 4)),  -- Гриль - Гриль
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 5), (SELECT $node_id FROM Equipment WHERE EquipmentID = 5)),  -- Тушение - Сотейник
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6), (SELECT $node_id FROM Equipment WHERE EquipmentID = 6)),  -- Разделка - Нож
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 7), (SELECT $node_id FROM Equipment WHERE EquipmentID = 7)),  -- Взбивание - Миксер
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 8), (SELECT $node_id FROM Equipment WHERE EquipmentID = 8)),  -- Маринование - Емкость
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 9), (SELECT $node_id FROM Equipment WHERE EquipmentID = 9)),  -- Смешивание - Миска
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10), (SELECT $node_id FROM Equipment WHERE EquipmentID = 6)), -- Нарезка - Нож
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 1), (SELECT $node_id FROM Equipment WHERE EquipmentID = 11)), -- Варка - Половник
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 6), (SELECT $node_id FROM Equipment WHERE EquipmentID = 10)), -- Разделка - Разделочная доска
( (SELECT $node_id FROM CookingTechniques WHERE TechniqueID = 10), (SELECT $node_id FROM Equipment WHERE EquipmentID = 10)); -- Нарезка - Разделочная доска

----------------------------------------Запросы с функцией MATCH---------------------------------------------------------

--1. Какое оборудование используется для приготовления рецептов, в которых есть "Томаты"?
SELECT DISTINCT EquipmentName
FROM Equipment, CookingTechniques, Recipes, Ingredients, Uses, Includes, ConsistsOf
WHERE MATCH(Ingredients<-(ConsistsOf)-Recipes-(Includes)->CookingTechniques-(Uses)->Equipment)
AND IngredientName = N'Томаты';

--2. Какие рецепты используют те же ингредиенты, что и "Паста Карбонара"? Этот запрос найдет рецепты, которые имеют общие ингредиенты с пастой карбонара.
SELECT DISTINCT R2.RecipeName
FROM Recipes AS R1, Recipes AS R2, ConsistsOf AS COF1, ConsistsOf AS COF2, Ingredients AS ING
WHERE MATCH(R1-(COF1)->ING<-(COF2)-R2)
AND R1.RecipeName = N'Паста Карбонара'
AND R2.RecipeName <> N'Паста Карбонара';

--3. Какие рецепты используют те же техники приготовления, что и "Борщ"? Этот запрос найдет рецепты, которые используют общие техники приготовления с борщом.
SELECT DISTINCT R2.RecipeName
FROM Recipes AS R1, Recipes AS R2, Includes AS I1, Includes AS I2, CookingTechniques AS CT
WHERE MATCH(R1-(I1)->CT<-(I2)-R2)
AND R1.RecipeName = N'Борщ'
AND R2.RecipeName <> N'Борщ';

--4. Какие ингредиенты используются в рецептах, которые требуют "Варки"? Этот запрос найдет ингредиенты, которые используются в рецептах, где применяется техника варки
SELECT DISTINCT I.IngredientName
FROM Ingredients AS I, Recipes AS R, Includes AS INC, CookingTechniques AS CT, ConsistsOf AS COF
WHERE MATCH(CT<-(INC)-R-(COF)->I)
AND CT.TechniqueName = N'Варка';

--5. Какие ингредиенты входят в рецепты с самым высоким рейтингом (больше 4.7)? Этот запрос найдет ингредиенты, используемые в рецептах с рейтингом выше 4.7.
SELECT DISTINCT I.IngredientName
FROM Ingredients AS I, Recipes AS R, ConsistsOf AS COF
WHERE MATCH(R-(COF)->I)
AND R.Rating > 4.7;

----------------------------------------Запросы с функцией SHORTEST_PATH---------------------------------------------------------

--1.Найти все ингредиенты для рецепта "Паста Карбонара"
SELECT 
    R.RecipeName AS StartRecipe,
    STRING_AGG(I.IngredientName, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToIngredients
FROM 
    Recipes AS R,
    ConsistsOf FOR PATH AS C,
    Ingredients FOR PATH AS I
WHERE 
    MATCH(SHORTEST_PATH(R(-(C)->I)+))
    AND R.RecipeName = 'Паста Карбонара';

-- 2. Найти все техники приготовления, которые используются для приготовления Борща
SELECT 
    R.RecipeName AS StartRecipe,
    STRING_AGG(CT.TechniqueName, ' -> ') WITHIN GROUP (GRAPH PATH) AS PathToTechniques
FROM
     Recipes AS R,
     Includes FOR PATH AS I,
     CookingTechniques FOR PATH AS CT
WHERE 
    MATCH(SHORTEST_PATH(R(-(I)->CT){1,3}))
    AND R.RecipeName = 'Борщ';

---------------------------------------------Power BI-------------------------------------

SELECT @@SERVERNAME
-- Сервер: DESKTOP-TI9JN07\SQLEXPRESS
-- База данных: RecipeNetwork
-- Путь к рисункам: --https://raw.githubusercontent.com/aluaorl/Recipe-Network/refs/heads/main/pictures/

-- 1. Рецепты и ингредиенты (ConsistsOf)
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

-- 2. Рецепты и техники приготовления (Includes)
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

-- 3. Техники приготовления и оборудование (Uses)
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