#!/bin/bash

# =================================================================
#
#       FileName: win_site.sh
#    Description: 改变窗口大小 - 左边半屏和右边半屏
#
#         Author: zishu, zishu@qq.com
#        Created: 2019-10-12 16:40:18
#  Last Modified: 2020-01-11 21:14:23
#
# =================================================================

set -x

com=$1

# 获取当前激活窗口名称
active_win_name=`xprop -id $(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) _NET_WM_NAME`
active_win_id=$(xprop -root -f _NET_ACTIVE_WINDOW 0x " \$0\\n" _NET_ACTIVE_WINDOW | awk "{print \$2}")

SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {print $2}')
SCREEN_WIDTH=1920
SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {print $2}')


n_width=$(($SCREEN_WIDTH/2))
n_height=$(($SCREEN_HEIGHT))
if [[ $com == "left_size" ]]; then
    n_x=0
    n_y=0
    if [[ ${active_win_name} =~ "深度终端" ]]; then
        n_x=-50
        n_y=-50
        n_width=$(($n_width+100))
        n_height=$(($n_height+110))
    elif [[ ${active_win_name} =~ "深度文件管理器" ]]; then
        n_x=-59
        n_y=-44
        n_width=$(($n_width+121))
        n_height=$(($n_height+120))
    fi
    # 将最大化窗口还原，否则无法调整大小
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,$n_x,$n_y,$n_width,$n_height
elif [[ $com == "right_size" ]]; then
    n_x=$n_width
    n_y=0
    if [[ ${active_win_name} =~ "深度终端" ]]; then
        n_x=$(($n_x-50))
        n_y=-50
        n_width=$(($n_width+100))
        n_height=$(($n_height+110))
    elif [[ ${active_win_name} =~ "深度文件管理器" ]]; then
        n_x=$(($n_x-59))
        n_y=-44
        n_width=$(($n_width+121))
        n_height=$(($n_height+120))
    fi
    # 将最大化窗口还原，否则无法调整大小
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,$n_x,$n_y,$n_width,$n_height
elif [[ $com == "left_site" ]]; then
    n_x=0
    n_y=0
    # 将最大化窗口还原，否则无法调整大小
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,$n_x,$n_y,$n_width,$n_height
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
elif [[ $com == "right_site" ]]; then
    n_x=$(($SCREEN_WIDTH*2))
    n_y=0
    # 将最大化窗口还原，否则无法调整大小
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e 0,$n_x,$n_y,$n_width,$n_height
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
elif [[ $com == "mini" ]]; then
    xdotool windowminimize $active_win_id
fi

#define the height in px of the top system-bar:
# TOPMARGIN=-88

# #sum in px of all horizontal borders:
# RIGHTMARGIN=10

# # get width of screen and height of screen
# SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {print $2}')
# SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {print $2}')
# echo $SCREEN_WIDTH
# echo $SCREEN_HEIGHT

# # new width and height
# W=$(( $SCREEN_WIDTH / 2 - $RIGHTMARGIN ))
# H=$(( $SCREEN_HEIGHT - 2 * $TOPMARGIN ))

# # X, change to move left or right:
# if [[ $com == "left" ]]; then
#     X=-120;
# elif [[ $com == "right" ]]; then
#     X=$(( $SCREEN_WIDTH / 2 ))
# fi

# Y=$TOPMARGIN

# echo $X,$Y,$W,$H

# wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,$X,$Y,$W,$H

