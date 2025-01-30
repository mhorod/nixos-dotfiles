#!/bin/bash
# Spawn a new instance of Alacritty using the CWD of the currently focused
# Alacritty process.
#
# This is useful in environment like i3 where terminals are opened using a
# key-combination while another terminal is already focused.
#
# If the script is run with a non-Alacritty window in focus or a non-compliant
# version of Alacritty, an instance will be spawned in the user's $HOME.

ACTIVE_CLASS=$(hyprctl activewindow | grep -oP "(?<=class: ).*")
PID=$(hyprctl activewindow | grep -oP "(?<=pid: ).*")
if [[ $ACTIVE_CLASS == *"Alacritty"* ]]
then
    # Get PID. If _NET_WM_PID isn't set, bail.
    if [[ "$PID" == "" ]]
    then
        alacritty
    fi
    # Get first child of terminal
    CHILD_PID=$(pgrep -P $PID)
    if [[ "$PID" == "" ]]
    then
        alacritty
    fi
    # Get current directory of child. The first child should be the shell.
    pushd "/proc/${CHILD_PID}/cwd"
    SHELL_CWD=$(pwd -P)
    popd
    # Start alacritty with the working directory
    alacritty --working-directory $SHELL_CWD
else
    alacritty
fi
