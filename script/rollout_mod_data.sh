#!/bin/bash

MODNAME="eldritch-abyss-content-pack-masterverse";
DATE=`date +"%Y-%m-%d_%T"`
CURRENT=$(pwd)
DIRECTORY="$HOME/.local/share/Paradox Interactive/Stellaris/mod"

function println() {
    if [[ -n $1 ]]; then
        echo -e "\n${1}\n"
    fi
}

pushd "$DIRECTORY" > /dev/null

while getopts "bp" OPTION
do
    case $OPTION in
        b)
            println "Backup current mod data..."
            tar -czf "${CURRENT}/../backup/${MODNAME}_${DATE}".tar.gz "${MODNAME}" --checkpoint=.100
            ;;
    esac
done


popd > /dev/null

println "Sync new mod data ..."

rsync -av ../src/ "${DIRECTORY}/${MODNAME}"/ --delete || println "rsync not executed. check folders and whether rsync is installed or not"

println "Create mod meta data ..."

cp "${DIRECTORY}/${MODNAME}/descriptor.mod" "${DIRECTORY}/${MODNAME}.mod"
echo "" >> "${DIRECTORY}/${MODNAME}.mod"
echo "path=\"${DIRECTORY}/${MODNAME}\"" >> "${DIRECTORY}/${MODNAME}.mod"

println "${DATE/_/ }"
