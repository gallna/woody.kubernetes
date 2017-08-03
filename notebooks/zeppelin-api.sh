#!/usr/bin/env bash

# http://[zeppelin-server]:[zeppelin-port]/api/notebook-repositories
# http://[zeppelin-server]:[zeppelin-port]/api/notebook/import
# http://[zeppelin-server]:[zeppelin-port]/api/notebook

# curl -sL https://github.com/... | exists
function exists() {
  name=$(jq '.body[].name')
  http http://${zeppelin_url}/api/notebook | jq ".body[] | select(.name == \"$name\")"
}

function import_file() {
  while read line; do
    echo >&2 "Importing $(basename $line)"
    cat $line | http POST http://${zeppelin_url}/api/notebook/import
  done
}

function import_url() {
  while read line; do
    echo >&2 "Importing $(basename $line)"
    curl -sl $line | http POST http://${zeppelin_url}/api/notebook/import
  done
}

function clean_notebooks() {
  http http://${zeppelin_url}/api/notebook | jq -r '.body[] | select(.name == "") | .id' | \
    parallel http DELETE http://${zeppelin_url}/api/notebook/{}
}

function import_zepl() {
  http "https://www.zepl.com/api/v1/viewer/search?q=$1" | \
    jq -r '.[] | [(.id|tostring), .title, .showcases, .url] | join("~")' | \
    while read line; do
      id=$(awk -F"~" '{print $1}' <<< "$line")
      title=$(awk -F"~" '{print $2}' <<< "$line")
      showcases=$(awk -F"~" '{print $3}' <<< "$line")
      url=$(awk -F"~" '{print $4}' <<< "$line")
      echo >&2 "zepl/$id.json - $title"
      curl -sSL "https://www.zepl.com/api/v1/viewer/fetch?url=$(base64 -w 0 <<< $url)" > zepl/$id.json || {
        rm -f zepl/$id.json && echo >&2 "zepl/$id.json deleted"
      }
  done
}


# Import notebooks from https://www.zepl.com/explore
# Visualization
# Spark
# http "https://www.zepl.com/api/v1/viewer/search?q=Spark" | import_zepl
# import_zepl Spark
find zepl -type f -name "*.json" | import_file
exit
# Import notebooks from url
cat <<IMPORTS | import_url
https://github.com/pmhargisNG10/zeppelin-notebooks/blob/pmhargis/2BXSE1MV8/note.json
IMPORTS


# notebooks from hortonworks-gallery
test -d zeppelin-notebooks || \
  git clone git@github.com:hortonworks-gallery/zeppelin-notebooks.git zeppelin-notebooks

# Import notebooks from files
find zeppelin-notebooks -type f -name "*.json" | import_file

http http://${zeppelin_url}/api/notebook
http http://${zeppelin_url}/api/notebook-repositories
