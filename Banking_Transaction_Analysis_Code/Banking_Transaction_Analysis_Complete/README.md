# Banking Transaction Analysis
Stack: HDFS, Hadoop Streaming (Python MapReduce), Hive, optional Sqoop.

## Run
1. `python src/data_generation/generate_data.py`
2. `python src/analysis/validate_data.py`
3. `bash scripts/upload_to_hdfs.sh`
4. Set `HADOOP_STREAMING_JAR` to your Hadoop Streaming JAR, then `bash scripts/run_mapreduce.sh`
5. Run Hive SQL: `hive -f hive/01_create_tables.sql` then `hive -f hive/02_analysis_queries.sql`

Hadoop/Hive commands require a configured Hadoop environment (Linux/WSL is often easiest). Sqoop is optional and may be incompatible with modern installs. Dataset is synthetic; do not use real customer data.
