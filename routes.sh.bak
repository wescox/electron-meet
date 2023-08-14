#!/bin/sh

# get url input
url=$1
if [ -z "$url" ]; then
	url="https://meet.google.com"
fi

# route to electron app if url is a google meet link otherwise send to firefox
if [[ "$url" == "https://meet.google.com"* ]]; then
	cd /home/wally/.local/share/applications
	#export NVM_DIR="$HOME/.nvm"
	#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	#npm start $url
	gio launch google-meet.desktop
else
	firefox "$url" & disown
fi


