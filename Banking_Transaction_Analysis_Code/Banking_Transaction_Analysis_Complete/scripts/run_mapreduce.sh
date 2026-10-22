#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JAR="${HADOOP_STREAMING_JAR:-}"
INPUT="/banking/input/bank_transactions.csv"
OUTPUT="/banking/output/type_summary"
LOCAL="$ROOT/output/mapreduce/type_summary"
if [[ -z "$JAR" || ! -f "$JAR" ]]; then
  echo "Set HADOOP_STREAMING_JAR to your Hadoop Streaming JAR path"; exit 1
fi
hdfs dfs -test -e "$INPUT" || { echo "Upload dataset first"; exit 1; }
hdfs dfs -rm -r -f "$OUTPUT" >/dev/null 2>&1 || true
hadoop jar "$JAR" -input "$INPUT" -output "$OUTPUT" \
  -mapper "python3 mapper.py" -reducer "python3 reducer.py" \
  -file "$ROOT/src/mapreduce/mapper.py" -file "$ROOT/src/mapreduce/reducer.py"
mkdir -p "$LOCAL"
hdfs dfs -get -f "$OUTPUT/part-00000" "$LOCAL/part-00000"
echo "Output saved to $LOCAL/part-00000"
echo "Columns: type, count, total_amount, successful_count, successful_amount"
cat "$LOCAL/part-00000"
