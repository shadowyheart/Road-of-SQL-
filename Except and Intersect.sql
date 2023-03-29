--Retrieve customers with only a main office address
SELECT Customer.CompanyName, CustomerAddress.AddressType
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID] = [model].[CustomerAddress].[CustomerID]
EXCEPT
SELECT Customer.CompanyName, CustomerAddress.AddressType
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID] = [model].[CustomerAddress].[CustomerID]
WHERE [model].[CustomerAddress].[AddressType] = 'Shipping'

--Retrieve only customers with both a main office address and a shipping address
SELECT Customer.CompanyName, CustomerAddress.AddressType
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID] = [model].[CustomerAddress].[CustomerID]
INTERSECT
SELECT Customer.CompanyName, CustomerAddress.AddressType
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID] = [model].[CustomerAddress].[CustomerID]