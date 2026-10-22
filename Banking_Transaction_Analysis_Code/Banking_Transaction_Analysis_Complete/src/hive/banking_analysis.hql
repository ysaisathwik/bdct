
CREATE DATABASE IF NOT EXISTS banking_db;

USE banking_db;

CREATE EXTERNAL TABLE IF NOT EXISTS bank_transactions (
    transaction_id STRING,
    customer_id STRING,
    transaction_date STRING,
    transaction_type STRING,
    amount DOUBLE,
    account_balance DOUBLE,
    location STRING,
    status STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/banking/data'
TBLPROPERTIES ('skip.header.line.count'='1');

-- Query 1: Count transactions by type
SELECT transaction_type, COUNT(*) AS total_transactions
FROM bank_transactions
GROUP BY transaction_type;

-- Query 2: Total amount by transaction type
SELECT transaction_type, SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_type;

-- Query 3: Successful transaction rate
SELECT
    status,
    COUNT(*) AS transaction_count,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM bank_transactions), 2) AS percentage
FROM bank_transactions
GROUP BY status;

-- Query 4: Find the highest-value transactions
SELECT transaction_id, customer_id, transaction_type, amount
FROM bank_transactions
ORDER BY amount DESC
LIMIT 10;
