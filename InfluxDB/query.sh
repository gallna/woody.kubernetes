#!/usr/bin/env bash

# Usage: query.sh 10.192.0.1:8086

influxdb=$1
db=telegraf
db=k8s

# SHOW MEASUREMENTS
# SHOW FIELD KEYS
# SELECT usage_idle FROM cpu WHERE cpu = 'cpu-total' LIMIT 5

while read query; do
  http --ignore-stdin --pretty=all --verbose -f POST "http://${influxdb}/query" db="${db}" q="${query}"
done < <(
cat <<SQL
SHOW TAG KEYS
SQL
)

exit
# Multiline
http --ignore-stdin --pretty=all --verbose -f POST "http://${influxdb}/query" db="${db}" q="$(cat <<SQL
SELECT usage_idle
FROM cpu
WHERE cpu = 'cpu-total' LIMIT 5
SQL
)"
