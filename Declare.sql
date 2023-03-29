--Create a table of distinct colors
DECLARE @Colors AS TABLE (Color nvarchar(20))
INSERT INTO @Colors
SELECT DISTINCT Color 
FROM Product
SELECT ProductID, Name, Color
FROM Product