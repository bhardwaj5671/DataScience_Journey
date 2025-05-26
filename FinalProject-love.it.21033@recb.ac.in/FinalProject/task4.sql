CREATE TABLE ProductLineStats AS
SELECT ProductLine, 
       AVG(Total) AS AvgSales, 
       STDDEV(Total) AS StdDevSales
FROM WalmartSalesDataset
GROUP BY Productline;


SELECT ws.InvoiceID, ws.Branch, ws.ProductLine, ws.Total, pls.AvgSales, pls.StdDevSales,
       CASE
           WHEN ws.Total > pls.AvgSales + 2 * pls.StdDevSales THEN 'High Anomaly'
           WHEN ws.Total < pls.AvgSales - 2 * pls.StdDevSales THEN 'Low Anomaly'
           ELSE 'Normal'
       END AS AnomalyStatus
FROM WalmartSalesDataset ws
JOIN ProductLineStats pls ON ws.ProductLine = pls.ProductLine
WHERE ws.Total > pls.AvgSales + 2 * pls.StdDevSales
   OR ws.Total < pls.AvgSales - 2 * pls.StdDevSales;


