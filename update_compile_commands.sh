#!/bin/bash

# =================================================================
#
#       FileName: update_compile_commands.sh
#    Description: 更新compile_commands.json
#
#         Author: zishu, zishu@qq.com
#        Created: 2019-11-04 18:23:01
#  Last Modified: 2019-11-05 16:35:14
#
# =================================================================

# set -x

cudir=$1
if [[ $1 == "" ]]; then
    cudir=`pwd`
fi


makefils=`find ./ -name "Makefile"`
for makefile in ${makefils[@]} ; do
    dir=${makefile%/*}
    echo $dir
    cd $cudir && cd $dir && compiledb -n make
done
