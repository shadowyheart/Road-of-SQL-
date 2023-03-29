--Retrieve the name and approximate weight of each product
SELECT ProductID, UPPER(Name), 
CAST(ROUND(TRY_CAST(Weight AS FLOAT),0) AS NVARCHAR) AS 'Approx Weight'
FROM [model].[Product]


--Retrieve the year and month in which product were first sold
SELECT ProductID, UPPER(Name), 
CAST(ROUND(TRY_CAST(Weight AS FLOAT),0) AS NVARCHAR) AS 'Approx Weight',
YEAR(SellStartDate) AS 'SellStartDate',
DATENAME(MONTH, DATEFROMPARTS(YEAR(SellStartDate), month(SellStartDate), DAY(SellStartDate))) AS 'SellStartMonth'
FROM [model].[Product]


--extract product types from product numbers
SELECT ProductID, UPPER(Name), 
CAST(ROUND(TRY_CAST(Weight AS FLOAT),0) AS NVARCHAR) AS 'Approx Weight',
YEAR(SellStartDate) AS 'SellStartDate',
DATENAME(MONTH, DATEFROMPARTS(YEAR(SellStartDate), month(SellStartDate), DAY(SellStartDate))) AS 'SellStartMonth',
LEFT(ProductNumber, 2) AS 'Productype'
FROM [model].[Product]


--Retrieve only product with a numeric size way 01
SELECT ProductID, UPPER(Name), 
CAST(ROUND(TRY_CAST(Weight AS FLOAT),0) AS NVARCHAR) AS 'Approx Weight',
YEAR(SellStartDate) AS 'SellStartDate',
DATENAME(MONTH, DATEFROMPARTS(YEAR(SellStartDate), month(SellStartDate), DAY(SellStartDate))) AS 'SellStartMonth',
LEFT(ProductNumber, 2) AS 'Productype',
[Size]
FROM [model].[Product]
WHERE ISNUMERIC([size]) = 1

--Retrieve only product with a numeric size way 02
SELECT
    ProductID,
    Name,
    Weight,
    year(SellStartDate) AS 'SellYear',
    CONVERT(VARCHAR(2),SellStartDate,1) AS SellMonth,
    --DATENAME(mm,SellMonth) as Month
    LEFT(ProductNumber,2) AS ProductType,
    Size
FROM [model].[Product]
WHERE ISNUMERIC(Size) = 1