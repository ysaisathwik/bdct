USE banking_analysis;

-- Totals by transaction type
SELECT transaction_type, COUNT(*) AS transaction_count, ROUND(SUM(amount),2) AS total_amount
FROM transactions GROUP BY transaction_type ORDER BY total_amount DESC;

-- Successful transactions
SELECT transaction_type, COUNT(*) AS successful_count, ROUND(SUM(amount),2) AS successful_amount
FROM transactions WHERE UPPER(status)='SUCCESS'
GROUP BY transaction_type ORDER BY successful_amount DESC;

-- Top 10 customers by successful transaction amount
SELECT customer_id, COUNT(*) AS transaction_count, ROUND(SUM(amount),2) AS total_amount
FROM transactions WHERE UPPER(status)='SUCCESS'
GROUP BY customer_id ORDER BY total_amount DESC LIMIT 10;

-- Daily trend
SELECT SUBSTR(transaction_date,1,10) AS transaction_day, COUNT(*) AS transaction_count,
ROUND(SUM(amount),2) AS total_amount
FROM transactions GROUP BY SUBSTR(transaction_date,1,10) ORDER BY transaction_day;

-- Failed and pending transactions
SELECT status, COUNT(*) AS transaction_count, ROUND(SUM(amount),2) AS total_amount
FROM transactions WHERE UPPER(status) IN ('FAILED','PENDING') GROUP BY status;

-- Review high-value transactions (threshold is illustrative, not proof of fraud)
SELECT transaction_id, customer_id, transaction_date, transaction_type, amount, city, status
FROM transactions WHERE amount >= 50000 ORDER BY amount DESC;

-- Totals by city
SELECT city, COUNT(*) AS transaction_count, ROUND(SUM(amount),2) AS total_amount
FROM transactions GROUP BY city ORDER BY total_amount DESC;
