
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi




# This is supposed to help the minecraft launcher remember credentials
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK



# Set screen resolution
# xrandr -s 2560x1440

# GDK_SCALE needs to be scaled up because the screen is so big
# but then the text (GDK_DPISCALE) needs to be scaled down to counterract it
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# Turn off numlock
numlockx

# Set wallpaper with 'feh'  !! This is done in the i3 config now so the wallpaper will refresh when i3 is reloaded
# feh --bg-fill $HOME/wallpapers/lofi/umbrella.jpg

# Start the compositor
picom -f &

# Launch the window manager
exec i3
