#!/bin/bash

playlist_id="$1"
# so if no path provided -- using feedtitle
path="${2:-\${feedtitle\}}"

git annex importfeed --force --fast "https://www.youtube.com/feeds/videos.xml?playlist_id=$playlist_id" --template "${path%/}"'/${itempubdate}-${itemtitle}.mkv'
git rm -f "${path%/}"/2_*.mkv
