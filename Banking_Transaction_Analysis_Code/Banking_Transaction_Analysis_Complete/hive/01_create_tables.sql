CREATE DATABASE IF NOT EXISTS banking_analysis;
USE banking_analysis;
CREATE EXTERNAL TABLE IF NOT EXISTS transactions (
 transaction_id STRING, customer_id STRING, transaction_date STRING,
 transaction_type STRING, amount DOUBLE, merchant STRING, city STRING, status STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/banking/input'
TBLPROPERTIES ('skip.header.line.count'='1');
