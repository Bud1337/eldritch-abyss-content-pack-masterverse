#!/bin/bash

MODNAME="eldritch-abyss";
DATE=`date +"%Y-%m-%d_%T"`
CURRENT=$(pwd)
DIRECTORY="$HOME/.config/GIMP/2.10/"

function println() {
    if [[ -n $1 ]]; then
        echo -e "\n${1}\n"
    fi
}

pushd "$DIRECTORY" > /dev/null

println "Backup current gimp script-fu data..."

tar -czf "${CURRENT}/../backup/gimp_script-fu_${DATE}".tar.gz "scripts" --checkpoint=.100

popd > /dev/null

println "Sync new gimp script-fu data ..."

rsync -av ../gimp/ "${DIRECTORY}"scripts/ --delete || println "rsync not executed. check folders and whether rsync is installed or not"

println "${DATE/_/ }"
