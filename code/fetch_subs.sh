#!/bin/bash

set -eu

# fetch subtitles for video file(s) if there is none
for f in "$@"; do
    fbase=${f%.*}
    vtts=$(/bin/ls -d "$fbase".*.vtt 2>/dev/null || :)
    if [ ! -z "$vtts" ]; then
        echo "$fbase: already has some vtts" # : $vtts"
        continue
    fi
    url=$(git annex whereis --in web "$f" | awk '/^ *web:/{print $2;}')
    echo "$fbase: getting some for $url"
    yt-dlp --write-subs --write-auto-subs -k --sub-lang=en,ua,ru --skip-download -o "$fbase" "$url"
done
