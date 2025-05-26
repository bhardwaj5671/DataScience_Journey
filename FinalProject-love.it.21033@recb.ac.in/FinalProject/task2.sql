CREATE TABLE BranchProductProfit AS
SELECT Branch, Productline, 
       (grossincome - cogs) AS Profit
FROM WalmartSalesDataset;



SELECT Branch, ProductLine, 
       SUM(Profit) AS TotalProfit
FROM BranchProductProfit
GROUP BY Branch, ProductLine;


SELECT Branch, ProductLine, TotalProfit
FROM (
    SELECT Branch, ProductLine, TotalProfit, 
           ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY TotalProfit DESC) AS rn
    FROM (
        SELECT Branch, ProductLine, 
               SUM(Profit) AS TotalProfit
        FROM BranchProductProfit
        GROUP BY Branch, ProductLine
    ) AS BranchProductProfits
) AS RankedProfits
WHERE rn = 1;
