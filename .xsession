# Damit im Hintergrund nicht die "normale"
# X Wallpaper zu sehen bleibt.
# Sonst kleines Flackern bei Logout.
#xsetroot -solid grey20


#feh --bg-fill   pic/background/ISS-Transporter.jpg
#feh --bg-fill   pic/background/Candair_Water_Drop.jpg
/usr/local/bin/feh --bg-center   pic/background/Candair_Water_Drop.jpg

xrdb -merge ~/.Xresources


# German lazout
setxkbmap de

# Trackpad langsamer machen
xinput set-prop 10 "libinput Scrolling Pixel Distance" 40 



#if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
#      ## if not found, launch a new one
#      eval `dbus-launch --sh-syntax`
#      echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
#fi


if ! [ -S "$DBUS_SESSION_BUS_ADDRESS" ]; then 
      # if not found, launch a new one
      eval `dbus-launch --sh-syntax`
      echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

if ! [ -S "$SSH_AUTH_SOCK" ]; then 
      # no ssh-agent found launch one
      eval `ssh-agent`
fi

# Load ssh keys to the agent
ssh-add .ssh/id_ed25519 < /dev/null
ssh-add .ssh/id_mario_internet < /dev/null
ssh-add .ssh/id_root_hera_rsa < /dev/null

xterm -geometry 100X40 &

#exec  /usr/local/bin/cwm

exec  /usr/local/bin/icewm

#   EOF 
