#!/bin/bash

function installDependencies() {
	ARCH=$1
	if [ "$ARCH" == "armv6l" ] ; then
		sudo apt-get install locate curl libboost-dev libboost-regex-dev xterm xfonts-base xfonts-utils youtube-dl axel mpg123 libcurl4-openssl-dev flac sox
	else
		sudo apt-get install locate curl libboost-dev libboost-regex-dev xterm xfonts-base xfonts-utils youtube-dl axel mpg123 libcurl4-openssl-dev flac sox
	fi
}

function installPlayvideo_install() {
	echo "Installing playvideo"
	echo "Enter movie/video root folder location, ex: /media/External/movies"
	read media_path
	`../PlayVideoScripts/playvideo -set "$media_path"`
	sudo cp ../PlayVideoScripts/playvideo /usr/bin/playvideo
	sudo cp ../PlayVideoScripts/playvideo.8.gz /usr/share/man/man8/
	echo "Done installing playvideo!"
}

function installDownload() {
	DIR=$1
	USER_HOME="$2"

	echo "Installing downloader script"
	echo "Enter host: ex, localhost (this is probably what it is)"
	read host
	echo "Enter Port: default is 9091 I believe"
	read port
	echo "Enter username, press enter if none"
	read user
	echo "Enter password, press enter if none"
	read passwd
	#print commands to $USER_HOME/.down.info
	if [ -e "$USER_HOME/.down.info" ] ; then
		sudo rm -f "$USER_HOME/.down.info"
	fi
	echo "$host"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
	echo "$port"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
	echo "$user"   | sudo tee -a "$USER_HOME/.down.info" >/dev/null
	echo "$passwd" | sudo tee -a "$USER_HOME/.down.info" >/dev/null
	tmp="../DownloadController/"
	tmp+="$DIR"
	tmp+="download"
	sudo cp "$tmp" /usr/bin/download
	echo "Done installing download!"
}

function intallGvapi() {
	DIR=$1
	USER_HOME="$2"

	echo "Installing Text Command Script"
	echo "Enter google voice username: "
	read user
	echo "Enter google voice password: "
	read passwd
	#print commands to $USER_HOME/.gtext
	if [ -e "$USER_HOME/.gv" ] ; then
		sudo rm -f "$USER_HOME/.gv"
	fi
	echo "$user"   | sudo tee -a "$USER_HOME/.gv" >/dev/null
	echo "$passwd"   | sudo tee -a "$USER_HOME/.gv" >/dev/null
	tmp="../TextCommand/"
	tmp+="$DIR"
	tmp+="gvapi"
	sudo cp "$tmp" /usr/bin/gvapi
	sudo cp ../TextCommand/gvapi.8.gz /usr/share/man/man8/
	echo "Done installing gvapi!"
}

function installGtextcommand {
	DIR=$1
	USER_HOME="$2"

	echo "Installing Text Command Script"
	echo "Enter google voice username: "
	read user
	echo "Enter google voice password: "
	read passwd
	echo "Enter command keyword, ex: Cmd (this will proceed every vaild command)"
	read key
	echo "Enter valid number to accept commands from (make sure to put the country code but not the +) ex: 15553334444"
	read number
	#print commands to $USER_HOME/.gtext
	if [ -e "$USER_HOME/.gtext" ] ; then
		sudo rm -f "$USER_HOME/.gtext"
	fi
	echo "$user"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
	echo "$passwd"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
	echo "$key"   | sudo tee -a "$USER_HOME/.gtext" >/dev/null
	echo "$number" | sudo tee -a "$USER_HOME/.gtext" >/dev/null
	tmp="../TextCommand/"
	tmp+="$DIR"
	tmp+="gtextcommand"
	sudo cp "$tmp" /usr/bin/gtextcommand
	#Add to cron.d
	echo "Done installing, setting up cron script ..."
	if [ -e "/etc/cron.d/gtextcommand" ] ; then
		sudo rm -f "/etc/cron.d/gtextcommand"
	fi
	cronjob="#!/bin/sh
	#
	# cron script to check google voice.
	#
	# Written by Steven Hickson <help@stevenhickson.com> for the gtextcommand script.
	#
	DISPLAY=:0

	* * * * * $USER gtextcommand

	"
	echo "$cronjob" | sudo tee -a /etc/cron.d/gtextcommand >/dev/null
	sudo sh -c 'chmod +x /etc/cron.d/gtextcommand'
	echo "Done installing gtextcommand!"
}

function installYoutube() {
	DIR=$1
	USER_HOME="$2"

	tmp="../Youtube/"
	tmp+="$DIR"
	tmp+="youtube-search"
	sudo cp ../Youtube/youtube /usr/bin/
	sudo cp ../Youtube/youtube-safe /usr/bin/
	sudo cp ../Youtube/youtube-dlfast /usr/bin/
	sudo cp "$tmp" /usr/bin/
	sudo cp ../Youtube/update-youtubedl /etc/cron.daily/
	sudo cp ../Youtube/yt.desktop /usr/share/applications/
	sudo cp ../Youtube/ytb.desktop /usr/share/applications/
	mkdir -p "$USER_HOME/.local/share/midori/scripts"
	cp ../Youtube/yt.js "$USER_HOME/.local/share/midori/scripts/" 
	cp ../Youtube/ytb.js "$USER_HOME/.local/share/midori/scripts/" 
	#This however, I'm fairly certain I need
	sudo update-desktop-database
	sudo youtube-dl -U
}

function installVoicecommand_install() {
	DIR=$1
	USER_HOME="$2"

	tmp="../VoiceCommand/"
	tmp+="$DIR"
	tmp+="voicecommand"
	sudo cp "$tmp" /usr/bin/
	sudo cp ../VoiceCommand/google /usr/bin/
	sudo cp ../VoiceCommand/tts /usr/bin/
	sudo cp ../VoiceCommand/speech-recog.sh /usr/bin/
	sudo cp ../VoiceCommand/voicecommand.8.gz /usr/share/man/man8/
	if [[ ! -f "$USER_HOME/.commands.conf" ]] ; then
	echo "No commands found, using default"
		cp ../VoiceCommand/commands.conf "$USER_HOME/.commands.conf"
}