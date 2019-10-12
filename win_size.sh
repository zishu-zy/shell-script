#!/bin/bash

# =================================================================
#
#       FileName: win_size.sh
#    Description: 改变窗口大小 - 左边半屏和右边半屏
#
#         Author: zhaiyu, zhaiyu@qianxin.com
#        Created: 2019-10-12 16:40:18
#  Last Modified: 2019-10-12 16:52:05
#
# =================================================================

com=$1
if [[ $com == "left" ]]; then
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,-50,-100,1060,1190
elif [[ $com == "right" ]]; then
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,1050,-100,1060,1190
fi
