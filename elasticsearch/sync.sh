#!/bin/bash
set -e
# Usage: sync.sh <target-elasticsearch-url>

input=http://production.es.com:9200
target=${1-"staging.es.com:9200"}
output=http://${target##*/}

echo "$input -> $output [$target]"

for index in $(curl -sL "$input/_cat/indices?h=index" | sed -e '/^\..*/d'); do
  {
    echo "--------- $index ---------"
    elasticdump \
      --input=$input/$index \
      --output=$output/$index \
      --type mapping \
      && echo "~~~~~~~~~ done ~~~~~~~~~" \
      || echo "~~~~~~~~~ failed ~~~~~~~~~"
  } 2>&1 | buffer -m 1M | cat & pids="$pids $!"
done
wait $pids

# sudo sysctl -w vm.max_map_count=262144;
# docker run --rm -ti taskrabbit/elasticsearch-dump \
#   --input=http://production.es.com:9200/my_index \
#   --output=http://staging.es.com:9200/my_index \
#   --type=mapping
