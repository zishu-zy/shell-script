#!/bin/bash

# =================================================================
#
#       FileName: rename_zishu.sh
#    Description: 
#
#         Author: zishu, zishuzy@qq.com
#        Created: 2019-11-05 16:42:58
#  Last Modified: 2019-11-05 17:05:44
#
# =================================================================


name=$1
cudir=`pwd`
files=`find $cudir -name "*.h" -o -name "*.cpp" -o -name "*.sh"`

for file in ${files[@]} ; do
    echo $file
    if [[ "$name" == "zishu" ]]; then
        sed -i '8 s/zhaiyu, zhaiyu@qianxin.com/zishu, zishuzy@qq.com/g' $file
    elif [[ "$name" == "zhaiyu" ]]; then
        sed -i '8 s/zishu, zishuzy@qq.com/zhaiyu, zhaiyu@qianxin.com/g' $file
    fi
done

