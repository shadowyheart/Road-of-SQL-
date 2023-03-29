--Retrieve companies ranked by sales totals
SELECT Customer.CompanyName, SalesOrderHeader.TotalDue, 
RANK() OVER( ORDER BY SalesOrderHeader.TotalDue DESC) as 'Company Rank'
FROM [model].[Customer]
JOIN [model].[SalesOrderHeader] ON [model].[Customer].[CustomerID] = [model].[SalesOrderHeader].[CustomerID];