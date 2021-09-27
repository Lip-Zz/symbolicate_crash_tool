#!/bin/sh
crashPath=${1}
#Incident Identifier
incidentIdentifier=$(cat $crashPath | grep "^Incident Identifier: " | sed 's/ //g' | cut -d ":" -f2)
echo "Incident Identifier: $incidentIdentifier"

#Hardware Model:读取文件内容 | 获取Hardware Model: 开头的一行 | 去掉空格 | 截取:后面的文字
hardwareModel=$(cat $crashPath | grep "^Hardware Model: " | sed 's/ //g' | cut -d ":" -f2)
echo "Hardware Model: $hardwareModel"

#Process
process=$(cat $crashPath | grep "^Process: " | sed 's/ //g' | cut -d ":" -f2)
echo "Process: $process"

#Path
path=$(cat $crashPath | grep "^Path: " | sed 's/ //g' | cut -d ":" -f2)
echo "Path: $path"

#Identifier
identifier=$(cat $crashPath | grep "^Identifier: " | sed 's/ //g' | cut -d ":" -f2)
echo "Identifier: $identifier"

#Version
version=$(cat $crashPath | grep "^Version: " | sed 's/ //g' | cut -d ":" -f2)
echo "Version: $version"
#Build
build=$(cat $crashPath | grep "^Version: " | sed 's/ //g' | cut -d ":" -f2 | cut -d "(" -f2 | cut -d ")" -f1)
echo "Build: $build"

#Code Type
codeType=$(cat $crashPath | grep "^Code Type: " | sed 's/ //g' | cut -d ":" -f2)
echo "Code Type: $codeType"

#Parent Process
parentProcess=$(cat $crashPath | grep "^Parent Process: " | sed 's/ //g' | cut -d ":" -f2)
echo "Parent Process: $parentProcess"

#Date/Time:读取文件内容 | 获取Date/Time: 开头的一行 | 获取Date/Time后面的文字 | 去除头部空格
#1.awk -F'package:' '{print $2}' 2.sed 's/^package://' 3.cut -d':' -f2
dateTime=$(cat $crashPath | grep "^Date/Time: " | sed 's/^Date\/Time://' | sed 's/^[ \t]*//g')
echo "Date/Time: $dateTime"

#OS Version
osVersion=$(cat $crashPath | grep "^OS Version: " | sed 's/^OS Version://' | sed 's/^[ \t]*//g')
echo "OS Version: $osVersion"
#Firmware Version
firmwareVersion=$(echo $osVersion | grep -Eo '[0-9]+.+')
echo -n "Firmware Version:$firmwareVersion"

#Report Version
reportVersion=$(cat $crashPath | grep "^Report Version: " | sed 's/ //g' | cut -d ":" -f2)
echo "Report Version: $reportVersion"

#Exception Type
exceptionType=$(cat $crashPath | grep "^Exception Type: " | sed 's/ //g' | cut -d ":" -f2)
echo "Exception Type: $exceptionType"

#Exception Codes
exceptionCodes=$(cat $crashPath | grep "^Exception Codes: " | sed 's/^Exception Codes://' | sed 's/^[ \t]*//g')
echo "Exception Codes: $exceptionCodes"

#Crashed Thread
crashedThread=$(cat $crashPath | grep "^Crashed Thread: " | sed 's/ //g' | cut -d ":" -f2)
echo "Crashed Thread: $crashedThread"
