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
tab ~/code/birta "docker run -it -w /var/www -v ~/code/birta:/var/www -v '$HOME/.ssh:/root/.ssh' businessinsider/birta:build /bin/bash"