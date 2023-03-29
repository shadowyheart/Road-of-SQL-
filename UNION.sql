--Retrieve billing address
SELECT Customer.CompanyName, Address.AddressLine1, Address.City,
CASE WHEN CustomerAddress.AddressType = 'Main Office' THEN 'Billing'
ELSE 'Shipping' 
END AS 'AddressType'
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID]=[model].[CustomerAddress].[CustomerID]
JOIN [model].[Address] ON [model].[Address].[AddressID]=[model].[CustomerAddress].[AddressID]

--Retrieve Shipping Address
SELECT Customer.CompanyName, Address.AddressLine1, Address.City, CustomerAddress.AddressType as 'AddressType'
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID]=[model].[CustomerAddress].[CustomerID]
JOIN [model].[Address] ON [model].[Address].[AddressID]=[model].[CustomerAddress].[AddressID]
WHERE [model].[CustomerAddress].[AddressType] = 'Shipping';


--Combine Billing and shipping address
SELECT Customer.CompanyName, Address.AddressLine1, Address.City,
CASE WHEN CustomerAddress.AddressType = 'Main Office' THEN 'Billing'
ELSE 'Shipping' 
END AS 'AddressType'
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID]=[model].[CustomerAddress].[CustomerID]
JOIN [model].[Address] ON [model].[Address].[AddressID]=[model].[CustomerAddress].[AddressID]
UNION
SELECT Customer.CompanyName, Address.AddressLine1, Address.City, CustomerAddress.AddressType as 'AddressType'
FROM [model].[Customer]
JOIN [model].[CustomerAddress] ON [model].[Customer].[CustomerID]=[model].[CustomerAddress].[CustomerID]
JOIN [model].[Address] ON [model].[Address].[AddressID]=[model].[CustomerAddress].[AddressID]
WHERE [model].[CustomerAddress].[AddressType] = 'Shipping'
Order By CompanyName ASC, AddressType DESC;