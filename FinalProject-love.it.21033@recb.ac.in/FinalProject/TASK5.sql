CREATE TABLE PaymentCounts
SELECT City, Payment, 
       COUNT(*) AS PaymentCount
FROM WalmartSalesDataset
GROUP BY City, Payment;


SELECT City, Payment, PaymentCount
FROM (
    SELECT City, Payment, PaymentCount,
           ROW_NUMBER() OVER (PARTITION BY City ORDER BY PaymentCount DESC) AS rn
    FROM PaymentCounts
) AS RankedPayments
WHERE rn = 1;


