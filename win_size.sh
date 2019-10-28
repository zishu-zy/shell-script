#!/bin/bash

# =================================================================
#
#       FileName: win_size.sh
#    Description: 改变窗口大小 - 左边半屏和右边半屏
#
#         Author: zhaiyu, zhaiyu@qianxin.com
#        Created: 2019-10-12 16:40:18
#  Last Modified: 2019-10-28 20:31:39
#
# =================================================================

com=$1
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
if [[ $com == "left" ]]; then
    wmctrl -r :ACTIVE: -e 0,0,0,960,1080
elif [[ $com == "right" ]]; then
    wmctrl -r :ACTIVE: -e 0,960,0,960,1380
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

