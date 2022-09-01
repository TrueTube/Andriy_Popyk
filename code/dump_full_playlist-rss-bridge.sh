#!/bin/bash

# give playlist ID

playlist_id="$1"

for i in 1 2 3; do
    curl --silent "https://feed.eugenemolotov.ru/?action=display&bridge=Youtube&context=By+playlist+Id&p=${playlist_id}&duration_min=&duration_max=&format=json" >| "$2" && exit 0
    echo "we failed on $i-th try -- let's sleep and try again"
    sleep 10
done
