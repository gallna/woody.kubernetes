#!/bin/bash

# Usage:
# export grafana_url=http://grafana.url
# export api_key=123456789...
# ./grafana-api.sh <func-name>

test -z "${api_key-}" && auth="" || auth="-H 'Authorization: Bearer $api_key'"

function _curl() {
  eval "curl -qSfs -H 'Content-Type: application/json' -H 'Accept: application/json' $auth $*"
}

# Get all dashboards
search-dashboards() {
  _curl "${grafana_url}/api/search?query=$1" | jq -r '.[].uri'
}

get-dashboard() {
  _curl "${grafana_url}/api/dashboards/$1" | jq '.dashboard.id = null'
}

create-dashboard(){
  echo -n >&2 ">>> $(basename $dash) "
	_curl -k -XPOST "${grafana_url}/api/dashboards/db" --data-binary @./$1
}

delete-dashboard() {
  _curl -k -XDELETE  "${grafana_url}/api/dashboards/$1"
}

import_dashboards() {
  for dash in $(search-dashboards); do
    get-dashboard $dash > "$(dirname $0)/backup/${dash##*/}.json"
  done
}

export_dashboards() {
  for dash in $(dirname $0)/backup/*; do
    create-dashboard $dash
  done
}
exec $@

# search-dashboards ""
# get-dashboard ""
# delete-dashboard ""
# search-dashboards
# import_dashboards
# export_dashboards
