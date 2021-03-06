#!/bin/bash

[ `uname -s` != "Darwin" ] && return

function tab () {
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    osascript &>/dev/null <<EOF
        tell application "System Events"
            tell process "Terminal" to keystroke "t" using command down
        end tell
        tell application "Terminal"
            activate
            do script with command "cd \"$cdto\"; $args" in selected tab of the front window
        end tell
EOF
}

tab ~/code/birta
clear
tab ~/code/birta "docker-compose up"
clear
sleep 2
tab ~/code/birta "docker exec -it birta_build_1 /bin/bash"
