CREATE TABLE CustomerTotalSales AS
SELECT CustomerID, 
       SUM(Total) AS TotalSales
FROM WalmartSalesDataset
GROUP BY CustomerID;


SELECT CustomerID, TotalSales
FROM CustomerTotalSales
ORDER BY TotalSales DESC
LIMIT 5;
