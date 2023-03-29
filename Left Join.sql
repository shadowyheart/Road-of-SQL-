SELECT Customer.CustomerID, Product.ProductID, 
concat(Customer.FirstName, ' ', Customer.LastName) as 'Customer Name', 
SalesOrderHeader.SalesOrderID
FROM [model].[Customer]
LEFT JOIN [model].[SalesOrderHeader] ON [model].[SalesOrderHeader].[CustomerID]=[model].[Customer].[CustomerID]
FULL JOIN [model].[Product] ON [model].[Product].[ProductID]=[model].[Customer].[CustomerID]
WHERE [model].[SalesOrderHeader].[SalesOrderID] IS NULL or [model].[SalesOrderHeader].[CustomerID] IS NULL;