--Retrieve Regional Sales Totals
SELECT Address.CountryRegion, Address.StateProvince, SUM(SalesOrderHeader.TotalDue) AS Revenue
FROM model.Address
JOIN model.CustomerAddress ON Address.AddressID = CustomerAddress.AddressID
JOIN model.Customer ON CustomerAddress.CustomerID = Customer.CustomerID
JOIN model.SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
GROUP BY ROLLUP (Address.CountryRegion, Address.StateProvince)
ORDER BY Address.CountryRegion, Address.StateProvince


--Indicate the grouping level in the results
SELECT Address.CountryRegion, Address.StateProvince, 
CASE WHEN GROUPING_ID(Address.CountryRegion) = 1 AND GROUPING_ID(Address.StateProvince) = 1 THEN 'Total'
WHEN GROUPING_ID(Address.StateProvince) = 1 THEN Address.CountryRegion + ' Subtotal' 
ELSE Address.StateProvince + 'Subtotal'
END AS Level,
SUM(SalesOrderHeader.TotalDue) AS Revenue
FROM model.Address
JOIN model.CustomerAddress ON Address.AddressID = CustomerAddress.AddressID
JOIN model.Customer ON CustomerAddress.CustomerID = Customer.CustomerID
JOIN model.SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
GROUP BY ROLLUP (Address.CountryRegion, Address.StateProvince)
ORDER BY Address.CountryRegion, Address.StateProvince


--Add a grouping level for cities
SELECT Address.CountryRegion, Address.StateProvince, Address.City,
CHOOSE (1+ GROUPING_ID(Address.CountryRegion) + GROUPING_ID(Address.StateProvince) + GROUPING_ID(Address.City),
Address.City + ' Subtotal', 
Address.StateProvince + ' Subtotal',
Address.CountryRegion + ' Subtotal',
'Total') AS Level,
SUM(SalesOrderHeader.TotalDue) AS Revenue
FROM model.Address
JOIN model.CustomerAddress ON Address.AddressID = CustomerAddress.AddressID
JOIN model.Customer ON CustomerAddress.CustomerID = Customer.CustomerID
JOIN model.SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
GROUP BY ROLLUP (Address.CountryRegion, Address.StateProvince, Address.City)
ORDER BY Address.CountryRegion, Address.StateProvince;
