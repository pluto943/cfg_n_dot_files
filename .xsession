# Damit im Hintergrund nicht die "normale"
# X Wallpaper zu sehen bleibt.
# Sonst kleines Flackern bei Logout.
#xsetroot -solid grey20


/usr/local/bin/feh --bg-center   pic/background/Candair.jpg

xrdb -merge ~/.Xresources


# German lazout
setxkbmap de

# Trackpad langsamer machen
xinput set-prop 10 "libinput Scrolling Pixel Distance" 40 



if ! [ -S "$DBUS_SESSION_BUS_ADDRESS" ]; then 
      # not found launch one
      eval `dbus-launch --sh-syntax`
      echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

if ! [ -S "$SSH_AUTH_SOCK" ]; then 
      # no ssh-agent found launch one
      eval `ssh-agent`
fi

# Load ssh keys to the agent
ssh-add .ssh/id_ed25519 < /dev/null

xterm -geometry 100X40 &

exec  /usr/local/bin/cwm
#exec  /usr/local/bin/icewm

#   EOF 
