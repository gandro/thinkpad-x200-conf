#!/bin/bash

# 0 = closed, 1 = open
LID=$(grep -q 'closed' /proc/acpi/button/lid/LID/state ; echo $?)

# 0 = battery 1 = ac-adapter
AC=$(grep -q 'off-line' /proc/acpi/ac_adapter/AC/state ; echo $?)

if [ $LID = 0 ] && [ $AC = 0 ] ; then
    pgrep mplayer && exit
    pm-suspend
fi
