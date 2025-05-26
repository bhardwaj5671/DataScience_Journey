CREATE TABLE CustomerTypeProductSales AS
SELECT CustomerType, ProductLine, 
       SUM(Total) AS TotalSales
FROM WalmartSalesDataset
GROUP BY CustomerType, ProductLine;


SELECT CustomerType, ProductLine, TotalSales
FROM (
    SELECT CustomerType, ProductLine, TotalSales, 
           ROW_NUMBER() OVER (PARTITION BY CustomerType ORDER BY TotalSales DESC) AS rn
    FROM CustomerTypeProductSales
) AS RankedProductLines
WHERE rn = 1;
