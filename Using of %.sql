--Filter products by product number
SELECT ProductNumber, Name, ListPrice
FROM [model].[Product]
WHERE ProductNumber like 'BK%'

--Retrieve specific products by product number
SELECT ProductNumber, Name, ListPrice
FROM [model].[Product]
WHERE ProductNumber like 'BK%' and ProductNumber not like '___R%'