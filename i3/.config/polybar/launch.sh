#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# polybar-msg cmd quit   # If all your bars have ipc enabled, you can also use this

# Launch Polybar, using default config location ~/.config/polybar/config
polybar topbar 2>&1 | tee -a /tmp/polybar.log &
disown
polybar bottombar 2>&1 | tee -a /tmp/polybar.log &
disown

echo "Polybar launched..."
