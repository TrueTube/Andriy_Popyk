#!/bin/bash

set -eu -o pipefail

cmd=$(readlink -f $0)
cd $(dirname $cmd)
cd ..

source ~/miniconda3.sh
conda activate deno 

function do_update_all () {

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

}

# might want to redo and use lockfile as described in
# https://www.baeldung.com/linux/bash-ensure-instance-running#using-lockfile
if [ -n "${_UPDATE_LOCKED:-}" ]; then
    do_update_all
    git annex get -J5  --not --metadata unavailable=*  .
else
    # lock itself and if already running -- exit as nothing happened
    _UPDATE_LOCKED=1 flock -n -E 0 .git/update.lck "$cmd"
fi
