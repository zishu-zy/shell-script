#!/bin/bash

# =================================================================
#
#       FileName: update_compile_commands.sh
#    Description: 更新compile_commands.json
#
#         Author: zhaiyu, zhaiyu@qianxin.com
#        Created: 2019-11-04 18:23:01
#  Last Modified: 2019-11-04 20:25:46
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
