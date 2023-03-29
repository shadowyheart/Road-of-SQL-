--Retrieve sales revenue by customer and contact
WITH TotalDue AS (SELECT CustomerID, TotalDue FROM model.SalesOrderHeader) 
SELECT concat(CompanyName, '(', concat(FirstName, LastName),')'), TotalDue
FROM [model].[Customer] 
JOIN [model].[SalesOrderHeader] ON [model].[SalesOrderHeader].[CustomerID] = [model].[Customer].[CustomerID]

