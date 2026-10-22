#!/usr/bin/env bash
set -euo pipefail
: "${MYSQL_HOST:?Set MYSQL_HOST}"; : "${MYSQL_DB:?Set MYSQL_DB}"
: "${MYSQL_USER:?Set MYSQL_USER}"; : "${MYSQL_PASSWORD:?Set MYSQL_PASSWORD}"
sqoop import --connect "jdbc:mysql://${MYSQL_HOST}:3306/${MYSQL_DB}" \
  --username "$MYSQL_USER" --password "$MYSQL_PASSWORD" --table transactions \
  --target-dir /banking/sqoop/transactions --fields-terminated-by ',' --num-mappers 1
