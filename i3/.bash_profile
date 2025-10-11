[[ -f ~/.bashrc ]] && . ~/.bashrc

# Automatically start X server on login.
# This will launch the WM stated in ~/.xinitrc (which is i3-gaps)
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
