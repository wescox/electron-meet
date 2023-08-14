#!/bin/sh

# Get URL when one is passed
url=$1
if [ -z "$url" ]; then
	url="https://meet.google.com"
fi

# Open Brave in app mode with a Meet icon when meet.google.com passed
if [[ "$url" == "https://meet.google.com"* ]]; then
	/opt/brave.com/brave/brave-browser --profile-directory='Profile 1' --app=$url
	
else
	# Open all non Meet URLs in Firefox
	firefox "$url"
fi





