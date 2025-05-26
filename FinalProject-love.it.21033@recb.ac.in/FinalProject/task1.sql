CREATE TABLE BranchMonthlySales (
    Branch VARCHAR(255),
    YearMonth DATE,
    MonthlySales DECIMAL(10, 2)
);

SELECT DISTINCT Date FROM WalmartSalesDataset LIMIT 10;

SELECT Date, 
       STR_TO_DATE(Date, '%d-%m-%Y') AS ParsedDate
FROM walmartsalesdataset;


INSERT INTO BranchMonthlySales (Branch, YearMonth, MonthlySales)
SELECT Branch, 
       DATE_FORMAT(STR_TO_DATE(Date, '%d-%m-%Y'), '%Y-%m-01') AS YearMonth,
       SUM(Total) AS MonthlySales
FROM WalmartSalesDataset
WHERE STR_TO_DATE(Date, '%d-%m-%Y') IS NOT NULL
GROUP BY Branch, YearMonth;


-- Calculate sales growth rate for each branch

SELECT a.Branch, 
       a.YearMonth, 
       a.MonthlySales, 
       ((a.MonthlySales - b.MonthlySales) / b.MonthlySales) * 100 AS GrowthRate
FROM BranchMonthlySales a
JOIN BranchMonthlySales b ON a.Branch = b.Branch AND 
DATE_FORMAT(a.YearMonth, '%Y-%m') = DATE_FORMAT(DATE_ADD(b.YearMonth, INTERVAL 1 MONTH), '%Y-%m')
ORDER BY a.Branch, a.YearMonth;


-- Find the branch with the highest average sales growth rate

SELECT Branch, 
       AVG(GrowthRate) AS AvgGrowthRate
FROM (
    SELECT a.Branch, 
           a.YearMonth, 
           ((a.MonthlySales - b.MonthlySales) / b.MonthlySales) * 100 AS GrowthRate
    FROM BranchMonthlySales a
    JOIN BranchMonthlySales b ON a.Branch = b.Branch AND 
                                 DATE_FORMAT(a.YearMonth, '%Y-%m') = DATE_FORMAT(DATE_ADD(b.YearMonth, INTERVAL 1 MONTH), '%Y-%m')
) AS GrowthRates
GROUP BY Branch
ORDER BY AvgGrowthRate DESC
LIMIT 1;

