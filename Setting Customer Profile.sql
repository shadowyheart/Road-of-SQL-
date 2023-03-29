SELECT C.Customer_ID, VIPs.isVIP
FROM Customer AS C
LEFT JOIN 
(
SELECT DISTINCT C.Customer_ID,
CASE WHEN RP.Customer_ID IS NULL 
THEN 'N'
ELSE 'Y'
END AS isVIP
FROM [Customer] AS C
LEFT JOIN [Recurring Purchase] AS RP ON C.[Customer_ID] = RP.[Customer_ID]) AS VIPs 
ON C.Customer_ID = VIPs.Customer_ID