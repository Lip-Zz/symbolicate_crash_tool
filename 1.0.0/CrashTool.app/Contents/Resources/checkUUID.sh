#!/bin/sh
typeStr=${1}
path=${2}
if [ ${typeStr} == "dSYM" ]; then
    #获取dSYM文件的uuid并且去掉横杆和转小写
    dSYMUUID=`/Library/Developer/CommandLineTools/usr/bin/dwarfdump -u ${path} | perl -ne 'print $1 if /UUID: (.*) \(arm64\)/s' | cut -c 1-42 | tr -d '-' | awk '{ print tolower($0) }'`
    echo -n $dSYMUUID
elif [ ${typeStr} == "crash" ]; then
    #获取.crash文件的uuid
    crashUUID=$(echo $(grep --after-context=1 "Binary Images:" ${path}) | cut -d "<" -f2 | cut -d ">" -f1)
    echo -n $crashUUID
fi
