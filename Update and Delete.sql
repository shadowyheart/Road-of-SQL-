UPDATE model.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM model.ProductCategory WHERE Name = 'Bells and Horns')


-- Discontinue products 
UPDATE model.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37
AND ProductNumber <> 'LT-L123'


--Delete a product category and its products 
DELETE FROM model.Product
WHERE ProductCategoryID = (SELECT ProductCategoryID FROM model.ProductCategory WHERE Name = 'Bells and Horns')
