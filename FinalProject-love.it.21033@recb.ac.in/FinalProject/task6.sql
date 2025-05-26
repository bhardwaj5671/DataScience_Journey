/*
CREATE TABLE WalmartSalesFormatted AS
SELECT InvoiceID, Branch, City, CustomerType, Gender, ProductLine, UnitPrice, Quantity, Tax, Total,
       STR_TO_DATE(Date, '%d/%m/%Y') AS Date, Time, Payment, COGS, GrossMarginPercentage, GrossIncome, Rating, CustomerID,
       DATE_FORMAT(STR_TO_DATE(Date, '%d/%m/%Y'), '%Y-%m-01') AS YearMonth
FROM WalmartSalesDataset;
*/

CREATE TABLE WalmartSalesFormatted AS 
SELECT InvoiceID, Branch, City, CustomerType, Gender, ProductLine, UnitPrice, Quantity, Tax, Total,
       CASE
           WHEN Date LIKE '%/%/%' THEN STR_TO_DATE(Date, '%d/%m/%Y')
           WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
           ELSE NULL
       END AS Date,
       Time, Payment, COGS, GrossMarginPercentage, GrossIncome, Rating, CustomerID,
       DATE_FORMAT(
           CASE
               WHEN Date LIKE '%/%/%' THEN STR_TO_DATE(Date, '%d/%m/%Y')
               WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
               ELSE NULL
           END, '%Y-%m-01'
       ) AS YearMonth
FROM WalmartSalesDataset
WHERE (CASE
           WHEN Date LIKE '%/%/%' THEN STR_TO_DATE(Date, '%d/%m/%Y')
           WHEN Date LIKE '%-%-%' THEN STR_TO_DATE(Date, '%d-%m-%Y')
           ELSE NULL
       END) IS NOT NULL;








SELECT YearMonth, Gender, 
       SUM(Total) AS MonthlySales
FROM WalmartSalesFormatted
GROUP BY YearMonth, Gender
ORDER BY YearMonth, Gender;

