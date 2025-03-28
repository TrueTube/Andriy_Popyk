#!/bin/bash

set -eu

# json file, output folder
# damn yarik -- do it in python

json="$1"
outfolder="$2"

IFS="&"
jq '.items[] |  .date_modified[:10] + "-" + .title + "_" + ".mkv" + "&" + .url' "$json" \
| tr ' ' '_' \
| sed -e 's,["],,g' -e 's,_*\.mkv,.mkv,g' -e 's,[:()!],_,g' \
| while read f url; do 
    url=${url//https_/https:}
    if [ -L "$outfolder/$f" ]; then 
        echo "$f exists $url"; 
    else
        git -c annex.alwayscommit=false annex addurl --no-raw --file $outfolder/$f --fast $url
        # TODO: unlike rssfeed we would not get metadata!
    fi
done 

echo "we are done with it -- removing the list"
rm "$json"
