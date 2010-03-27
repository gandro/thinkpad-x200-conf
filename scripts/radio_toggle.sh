#!/bin/bash

# We can't do anything else 
if rfkill list | grep -q 'Hard blocked: yes' ; then
    exit 1
fi

# bluetooth state
BT_STATE=$(rfkill list bluetooth | grep -q 'Soft blocked: yes' ; echo $?)

# WORKAROUND: We invert the wlan state because is was toggled before
WL_STATE=$(rfkill list wlan | grep -q 'Soft blocked: no' ; echo $?)

if [ $BT_STATE = 1 ] && [ $WL_STATE = 1 ] ; then
    # BT:0 WL: 0
    rfkill block all
    ifconfig wlan0 down

elif [ $BT_STATE = 0 ] && [ $WL_STATE = 0 ] ; then
    # BT:0 WL: 1
    rfkill unblock wlan
    ifconfig wlan0 up

elif [ $BT_STATE = 0 ] && [ $WL_STATE = 1 ] ; then
    # BT:1 WL: 0
    rfkill unblock bluetooth

    rfkill block wlan
    ifconfig wlan0 down

elif [ $BT_STATE = 1 ] && [ $WL_STATE = 0 ] ; then
    # BT:1 WL: 1
    rfkill unblock wlan
    ifconfig wlan0 up

fi
