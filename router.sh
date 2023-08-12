#!/bin/sh

# Symlink to desktop file
# It seems this is necessary to get the icon working
ln -sf /home/wally/ServiceTrade/code/brave-meet/google-meet.desktop /home/wally/.local/share/applications

# Run the application in the background
cd /home/wally/ServiceTrade/code/brave-meet/
./routes.sh &

# Wait for Brave to launch window
sleep 1

target_class="meet"

# Get the window ID using wmctrl
window_id=$(wmctrl -lx | grep "$target_class" | awk '{print $1}')

if [[ -n "$window_id" ]]; then
    # Use xprop to get the PID property
    pid_prop=$(xprop -id "$window_id" _NET_WM_PID)
    
    # Extract the PID value
    pid_value=$(echo "$pid_prop" | awk -F ' = ' '{print $2}')
    
else
    echo "Window with class '$target_class' not found."
fi

# Function to monitor the application and trigger cleanup
monitor_and_cleanup() {
    while ps -p $pid_value > /dev/null; do
        sleep 1
    done
    
    # Cleanup actions
    rm /home/wally/.local/share/applications/google-meet.desktop
}

# Run the monitor_and_cleanup function in the background
monitor_and_cleanup &

