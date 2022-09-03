#!/bin/bash

cd $(dirname $0)
cd ..

config() {
    git config -f .datalad/config "$@"
}

git config -f .datalad/config -l | awk -F. '/^playlist\./{print $2}' | sort | uniq \
| while read name; do
   path=$(config playlist.$name.path 2>/dev/null || echo $name/)
   id=$(config playlist.$name.id)
   echo "Updating feed $name"
   datalad run -m "Updated feed $name ($id) under $path" bash -c "code/import_feed.sh '$id' $path && code/fetch_subs.sh ${path%/}/*.mkv"
done

datalad push
