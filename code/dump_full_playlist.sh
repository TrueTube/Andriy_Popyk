#!/bin/bash

# just provide URL as in the browser, e.g. https://www.youtube.com/playlist?list=PLIa3r7AIaTikMGfiZlIuArLujETxVfOKP
# and output file

url="$1"
if ! echo "$url" | grep youtube.com; then
    url="https://www.youtube.com/playlist?list=$url"
    echo "Assuming that only ID was provided. URL is $url"
fi

youtube-dl --dump-json --flat-playlist "$1" >| "$2"
