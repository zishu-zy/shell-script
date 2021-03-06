#!/bin/bash

# =================================================================
#
#       FileName: win_ctrl.sh
#    Description: 窗口管理脚本
#
#         Author: zishu, zishu@qq.com
#        Created: 2019-10-12 14:14:34
#  Last Modified: 2020-01-08 19:47:20
#
# =================================================================

set -x
# 需要安装 wmctrl

app=$1
appRun=""

if [[ "$app" == "chrome" ]]; then
    app="google-chrome.Google-chrome"
    appRun="/opt/google/chrome/chrome"
elif [[ "$app" == "深度终端" ]] ;then
    app="deepin-terminal.Deepin-terminal"
    appRun="deepin-terminal"
elif [[ "$app" == "vscode" ]] ;then
    app="code.Code"
    appRun="code"
elif [[ "$app" == "QtCreator" ]] ;then
    app="qtcreator.QtCreator"
    appRun="qtcreator"
elif [[ "$app" == "深度编辑器" ]] ;then
    app="deepin-editor.deepin-editor"
    appRun="deepin-editor"
elif [[ "$app" == "notepadqq" ]] ;then
    app="notepadqq-bin.Notepadqq"
    appRun="notepadqq"
elif [[ "$app" == "sublime" ]] ;then
    app="sublime_text.Sublime_text"
    appRun="/opt/sublime_text/sublime_text"
elif [[ "$app" == "深度文件管理器" ]] ;then
    app="dde-file-manager.dde-file-manager"
    appRun="dde-file-manager"
elif [[ "$app" == "蓝信" ]] ;then
    # app="lxmainnew.exe.Wine"
    app="lanxin.Lanxin"
    appRun="lanxin"
elif [[ "$app" == "VirtualBox" ]] ;then
    app="VirtualBox Machine.VirtualBox Machine"
    app2="VirtualBox Manager.VirtualBox Manager"
    appRun="virtualbox"
fi

workspace=$(wmctrl -d | grep '*' | cut -d ' ' -f1)
win_list=$(wmctrl -lx | grep "$app" | grep " $workspace " | awk '{print $1}')
active_win=$(xprop -root -f _NET_ACTIVE_WINDOW 0x " \$0\\n" _NET_ACTIVE_WINDOW | awk "{print \$2}")

IDs=$(xprop -root | grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
IDs=(${IDs##*#})
for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
    for i in $win_list; do
        if [ $((i)) = $((IDs[idx])) ]; then
            echo $i
            if [ $((i)) = $((active_win)) ]; then
                xdotool windowminimize $i
            else
                wmctrl -ia $i
            fi
            exit 0
        fi
    done
done

# 蓝信的特殊处理 - 由于蓝信只能有一个，所以需要切换到对应的工作区
if [[ "$app" == "lanxin.Lanxin" ]]; then
    win_lanxin=$(wmctrl -lx | grep "$app" | awk '{print $1}')
    if [ $((win_lanxin)) = $((active_win)) ]; then
        xdotool windowminimize $win_lanxin
    else
        wmctrl -R "蓝信+"
    fi
fi

# virtualBox 的特殊处理
if [[ "$app" == "VirtualBox Machine.VirtualBox Machine" ]]; then
    win_list=$(wmctrl -lx | grep "$app2" | grep " $workspace " | awk '{print $1}')
    IDs=$(xprop -root | grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
    IDs=(${IDs##*#})
    for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list; do
            if [ $((i)) = $((IDs[idx])) ]; then
                echo $i
                if [ $((i)) = $active_win]; then
                    xdotool windowminimize $i
                else
                    wmctrl -ia $i
                fi
                exit 0
            fi
        done
    done
fi

# echo $appRun
nohup $appRun >/dev/null 2>&1 &
exit 0
