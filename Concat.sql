SELECT 
CASE WHEN MiddleName = 'NULL' THEN concat(FirstName, ' ', LastName)
Else Concat(FirstName, ' ', MiddleName, ' ', LastName)
End as CustomerName
From [model].[Customer];