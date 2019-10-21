#!/bin/bash

# =================================================================
#
#       FileName: win_ctrl.sh
#    Description: 窗口管理脚本
#
#         Author: zhaiyu, zhaiyu@qianxin.com
#        Created: 2019-10-12 14:14:34
#  Last Modified: 2019-10-21 17:33:53
#
# =================================================================

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
elif [[ "$app" == "深度文件管理器" ]] ;then
    app="dde-file-manager.dde-file-manager"
    appRun="dde-file-manager"
elif [[ "$app" == "蓝信" ]] ;then
    app="lxmainnew.exe.Wine"
    appRun="" # 蓝信暂时不知道
    wmctrl -R "蓝信"
    exit 0
elif [[ "$app" == "VirtualBox" ]] ;then
    app="VirtualBox Machine.VirtualBox Machine"
    app2="VirtualBox Manager.VirtualBox Manager"
    appRun="virtualbox"
fi
workspace=$(wmctrl -d | grep '*' | cut -d ' ' -f1)
win_list=$(wmctrl -lx | grep "$app" | grep " $workspace " | awk '{print $1}')

IDs=$(xprop -root | grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
IDs=(${IDs##*#})
for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
    for i in $win_list; do
        if [ $((i)) = $((IDs[idx])) ]; then
            wmctrl -ia $i
            exit 0
        fi
    done
done

if [[ "$app" == "VirtualBox Machine.VirtualBox Machine" ]]; then
    win_list=$(wmctrl -lx | grep "$app2" | grep " $workspace " | awk '{print $1}')

    IDs=$(xprop -root | grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
    IDs=(${IDs##*#})
    for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
        for i in $win_list; do
            if [ $((i)) = $((IDs[idx])) ]; then
                wmctrl -ia $i
                exit 0
            fi
        done
    done
fi

`$appRun`
exit 0
