BANKING TRANSACTION ANALYSIS DASHBOARD
======================================

Files:
- banking_transaction_dashboard.html : self-contained dashboard; open in a browser.
- transaction_dashboard_data.csv      : type-wise summary data for Excel or other tools.
- dashboard_data.json                 : dashboard data in JSON format.
- charts/transaction_count_by_type.png
- charts/transaction_amount_by_type.png
- charts/success_status.png

No application installation is required to open the HTML dashboard. Copy the HTML file
into your existing project folder and double-click it to open in your default browser.

The dashboard uses the verified summary rows previously produced by the local Python
mapper/reducer. The source dataset is synthetic. It does not connect to live banking,
Hadoop, HDFS, Hive or Sqoop. Amount currency was not specified, so amounts are shown
without a currency symbol.
