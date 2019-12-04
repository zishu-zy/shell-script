#!/bin/bash

# =================================================================
#
#       FileName: win_size.sh
#    Description: 改变窗口大小 - 左边半屏和右边半屏
#
#         Author: zishu, zishu@qq.com
#        Created: 2019-10-12 16:40:18
#  Last Modified: 2019-12-04 11:02:59
#
# =================================================================

com=$1

# 获取当前激活窗口名称
active_win_name=`xprop -id $(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) _NET_WM_NAME`

# 将最大化窗口还原，否则无法调整大小
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz

if [[ $com == "left" ]]; then
    if [[ ${active_win_name} =~ "深度" ]]; then
        wmctrl -r :ACTIVE: -e 0,-50,-50,1060,1190
    else
        wmctrl -r :ACTIVE: -e 0,0,0,960,1080
    fi
elif [[ $com == "right" ]]; then
    if [[ ${active_win_name} =~ "深度" ]]; then
        wmctrl -r :ACTIVE: -e 0,910,-50,1060,1190
    else
        wmctrl -r :ACTIVE: -e 0,960,0,960,1080
    fi
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

