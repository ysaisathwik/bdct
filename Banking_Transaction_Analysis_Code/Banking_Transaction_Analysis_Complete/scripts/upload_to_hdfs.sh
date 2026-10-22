#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CSV="$ROOT/data/raw/bank_transactions.csv"
if [[ ! -f "$CSV" ]]; then echo "Run python src/data_generation/generate_data.py first"; exit 1; fi
hdfs dfs -mkdir -p /banking/input
hdfs dfs -put -f "$CSV" /banking/input/bank_transactions.csv
hdfs dfs -ls /banking/input
