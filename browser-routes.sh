#!/bin/sh

# Desktop file symlinks
#file="google-meet.desktop"

# Window class
target_class="meet"

# Get URL when one is passed
url=$1
if [ -z "$url" ]; then
	url="https://meet.google.com"
fi

# Set pattern for text replacement
pattern="'https://meet\.google\.com.*'"

# Function to monitor the application and trigger cleanup
monitor_and_cleanup() {
    while ps -p $pid_value > /dev/null; do
        sleep 1
    done
    
    # Cleanup actions
    rm /home/wally/.local/share/applications/google-meet.desktop
}

# Open Brave in app mode with a Meet icon when meet.google.com passed
if [[ "$url" == "https://meet.google.com"* ]]; then
	
	## Make sure desktop file is updated with passed URL
	#cd $HOME/ServiceTrade/code/brave-meet/
	#sed -i "s|$pattern|'$url'|g" $file

	## Set symlinks - required for icon
	#ln -sf $HOME/ServiceTrade/code/brave-meet/$file $HOME/.local/share/applications/
	
	# Open Brave with new URL
	#cd $HOME/.local/share/applications/
	#gio launch google-meet.desktop
	/opt/brave.com/brave/brave-browser --profile-directory='Profile 1' --app=$url
	
	# Wait for Brave to launch window
	sleep 1

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
	
	# Run the monitor_and_cleanup function in the background
	monitor_and_cleanup &
else
	# Open all non Meet URLs in Firefox
	firefox "$url" & disown
fi





