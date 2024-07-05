# autostart window manager at login
# TODO: probably need to confirm env vars being set
#
# ENVIRONMENTD="$HOME/.config/environment.d"
# set -a
# if [ -d "$ENVIRONMENTD" ]; then
#     for conf in $(ls "$ENVIRONMENTD"/*.conf)
#     do
#         . "$conf"
#     done
# fi
# set +a
#
# if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec sway > /tmp/sway.log 2>&1
# fi
