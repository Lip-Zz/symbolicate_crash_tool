#!/bin/sh
projectPath=${1}
developerDIR=${2}
symbolicatecrash=${3}
crashPath=${4}
dSYMPath=${5}
savePath=${6}

#echo "-----------------------导入开发路径-------------------------"
export DEVELOPER_DIR=$developerDIR

#echo "-----------------------查找是否有第三方framework-------------------------"
#查找.framework路径 | 排除pod下面的framework
#``包围表示存成数组,不能用()包围，因为碰到空格会被拆分成两个元素(https://stackoverflow.com/questions/23356779/how-can-i-store-the-find-command-results-as-an-array-in-bash/54561526)
shStr="$symbolicatecrash $crashPath $dSYMPath "
IFS=$'\n' array=($(find "$projectPath" -name '*.framework' -print | grep -v 'Pods'))
for i in ${!array[@]}
do
    shStr="${shStr} \"${array[i]}\""
done

eval "$shStr > $savePath"

#if [ -s $savePath ]; then
#    #"不为空"
#    echo true
#else
#    #"为空"
#    echo false
#fi
