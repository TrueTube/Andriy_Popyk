#!/bin/bash

playlist_id="$1"

git annex importfeed --fast "https://www.youtube.com/feeds/videos.xml?playlist_id=$playlist_id" --template '${feedtitle}/${itempubdate}-${itemtitle}.mkv'
