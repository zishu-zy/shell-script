#!/bin/bash

# =================================================================
#
#       FileName: win_ctrl.sh
#    Description: 窗口管理脚本
#
#         Author: zhaiyu, zhaiyu@qianxin.com
#        Created: 2019-10-12 14:14:34
#  Last Modified: 2019-10-12 16:30:04
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
fi
workspace=$(wmctrl -d | grep '*' | cut -d ' ' -f1)
win_list=$(wmctrl -lx | grep $app | grep " $workspace " | awk '{print $1}')
findFlag=0

for window in $win_list
do
    `wmctrl -ia $window`
    findFlag=1
    break
done

if [[ $findFlag == 0 ]] ;then
    `$appRun`
fi
