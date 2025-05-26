CREATE TABLE CustomerTotalSpending AS 
SELECT CustomerID, 
       SUM(Total) AS TotalSpending
FROM WalmartSalesDataset
GROUP BY CustomerID;

CREATE TABLE CustomerAverageSpending AS 
SELECT CustomerID, 
       AVG(TotalSpending) AS AverageSpending
FROM CustomerTotalSpending
GROUP BY CustomerID;



SELECT CustomerID, AverageSpending,
       CASE
           WHEN AverageSpending > 1000 THEN 'High'
           WHEN AverageSpending BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Low'
       END AS SpendingTier
FROM CustomerAverageSpending;
