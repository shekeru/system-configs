#!/bin/bash
xrdb -merge .Xresources
export ELECTRON_TRASH=gio
# Dbus Fixes
if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi
# Extras
feh --bg-scale /etc/nixos/wallpaper.jpg &
xmobar &
# Compton
systemctl --user import-environment &
systemctl --user start graphical-session.target &
# Start WM
exec xmonad
