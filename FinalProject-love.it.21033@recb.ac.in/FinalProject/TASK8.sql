CREATE TABLE SortedTransactions AS
SELECT CustomerID, 
       STR_TO_DATE(Date, '%d-%m-%Y') AS PurchaseDate, 
       InvoiceID
FROM WalmartSalesDataset
ORDER BY CustomerID, PurchaseDate;

CREATE TABLE PurchaseIntervals AS
SELECT a.CustomerID, a.PurchaseDate AS CurrentPurchaseDate, b.PurchaseDate AS NextPurchaseDate, 
       DATEDIFF(b.PurchaseDate, a.PurchaseDate) AS DaysBetweenPurchases
FROM SortedTransactions a
JOIN SortedTransactions b ON a.CustomerID = b.CustomerID AND a.PurchaseDate < b.PurchaseDate;


SELECT DISTINCT CustomerID
FROM PurchaseIntervals
WHERE DaysBetweenPurchases <= 30;
