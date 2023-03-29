--Retrieve Product Price Information
SELECT ProductID, Product.Name, ListPrice
FROM [model].[Product]
WHERE ListPrice > (SELECT AVG(ListPrice) FROM [model].[Product])

--Retrieve Products with a list price of $100 or more that have been sold for less than $100
SELECT ProductID, Name, ListPrice
FROM [model].[Product]
WHERE ListPrice >= 100 
(SELECT model.SalesORderDetail.UnitPrice 
FROM model.SalesOrderDetail 
WHERE model.SalesOrderDetail.UnitPrice < 100)

--Retrieve the cost, list price, and average selling price for each product
SELECT ProductID, Name, StandardCost, ListPrice, (SELECT AVG(model.SalesOrderDetail.UnitPrice) FROM model.SalesOrderDetail)
FROM [model].[Product]
WHERE ProductID IN (SELECT model.SalesOrderDetail.ProductID FROM model.SalesOrderDetail)

--Retrieve products that have an average selling price that is lower than the cost
SELECT ProductID, Name, StandardCost, ListPrice, (SELECT AVG(model.SalesOrderDetail.UnitPrice) FROM model.SalesOrderDetail)
FROM [model].[Product]
WHERE ProductID IN (SELECT model.SalesOrderDetail.ProductID FROM model.SalesOrderDetail) 
AND (StandardCost > (SELECT AVG(model.SalesOrderDetail.UnitPrice) FROM model.SalesOrderDetail))