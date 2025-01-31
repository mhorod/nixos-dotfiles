#!/bin/bash

TERMINAL=$1
ACTIVE_CLASS=$(hyprctl activewindow | grep -oP "(?<=class: ).*" | tr '[:upper:]' '[:lower:]')
PID=$(hyprctl activewindow | grep -oP "(?<=pid: ).*")

if [[ $ACTIVE_CLASS == "alacritty" || $ACTIVE_CLASS == "kitty" ]]
then
    CHILD_PID=$(pgrep -P ${PID})
    pushd "/proc/${CHILD_PID}/cwd"
    SHELL_CWD=$(pwd -P)
    popd
    $TERMINAL --working-directory $SHELL_CWD
else
  $TERMINAL
fi
