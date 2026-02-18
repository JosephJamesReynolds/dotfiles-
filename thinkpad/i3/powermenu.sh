#!/usr/bin/env bash

chosen=$(echo -e "Lock\nLogout\nReboot\nShutdown" | rofi -dmenu -p "Power Menu")

case "$chosen" in
    Lock) i3lock ;;
    Logout) i3-msg exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
