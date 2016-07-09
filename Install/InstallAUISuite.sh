#!/bin/bash
source AUISuiteInstaller.sh

#Script to make install of AUI Suite very easy
function dependencies() {
    #Ask to install dependencies
    install_method=`pgrep apt-get`
    if [ -z $install_method ] ; then
		echo "Install dependencies? y/n"
		echo "These are necessary for any of the options, so you should probably press y unless you absolutely know you have them already"
		read option
		if [ $option == "y" ] || [ $option == "Y" ] ; then
			installDependencies $1
		fi
    fi
}

function playvideo_install() {
    #Install playvideo script
    echo "Install playvideo? y/n"
    echo "This script indexes your movies and tv shows in order to quickly find, randomize, and/or play them. I find it extremely useful"
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		installPlayvideo_install
    else
        echo "Skipping playvideo install"
    fi
}

function download() {
    #Install downloader script
    echo "Install downloader? y/n"
    echo "This script automates the download of torrents. Ex. 'download wheezy' finds and downloads the newest debian wheezy image"
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		installDownload $1 $2
    else
        echo "Skipping downloader install"
    fi
}

function gvapi() {
    #Install gvapi
    echo "Install gvapi (googlevoice api)? y/n"
    echo "This script installs the google voice api. It is really useful for home automation/robotics enthusiasts."
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		intallGvapi $1 $2
    else
        echo "Skipping gvapi install"
    fi
}

function gtextcommand {
    #Install gtextcommand script
    echo "Install gtextcommand (google voice text command system)? y/n"
    echo "This installs gtextcommand. This uses google voice to check for system commands from your number with a passcode."
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		installGtextcommand $1 $2
    else
        echo "Skipping gtextcommand install"
    fi
}

function youtube() {
    echo "Install youtube scripts? y/n"
    echo "This installs youtube, youtube-safe, youtube-dl, and other scripts that allow you to download, stream, and browse videos from many sites"
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		installYoutube $1 $2
    else
        echo "Skipping youtube install"
    fi
}

function voicecommand_install() {
    echo "Install voicecommand? y/n"
    echo "This is probably the coolest script here and ties many of these together. It is an easily customizable voice control system. It uses speech recognition and text to speech to listen to you, respond to you, and run commands based on what you say."
    read option
    if [ $option == "y" ] || [ $option == "Y" ] ; then
		installVoicecommand_install $1 $2
	else
	    echo "I found a command file"
        fi
        echo "Would you like voicecommand to try to set itself up? y/n"
        read option
        if [ $option == "y" ] || [ $option == "Y" ] ; then
            voicecommand -s
        else
            echo "You can do this manually at any time by running voicecommand -s"
        fi
    else
        echo "Skipping voicecommand install"
    fi
}

echo "Installing AUI Suite by Steven Hickson"
echo "If you have issues, visit stevenhickson.blogspot.com or email help@stevenhickson.com"

#Get architecture
ARCH=`uname -m`
if [ "$ARCH" == "armv6l" ] ; then
    DIR=""
elif [ "$ARCH" == "x86" ] ; then
    DIR="x86/"
elif [ "$ARCH" == "x86_64" ] ; then
    DIR="x64/"
fi

if [ "$(id -u)" != "0" ]; then
    USER_HOME="$HOME"
else
    USER_HOME="/home/${SUDO_USER}"
fi

ARG="$1"
if [ "$ARG" == "dependencies" ] ; then 
    installDependencies "$ARCH"
elif [ "$ARG" == "playvideo" ] ; then 
    installPlayvideo_install
elif [ "$ARG" == "download" ] ; then 
    installDownload "$DIR" "$USER_HOME"
elif [ "$ARG" == "gtextcommand" ] ; then
    installGtextcommand "$DIR" "$USER_HOME"
elif [ "$ARG" == "gvapi" ] ; then
    intallGvapi "$DIR" "$USER_HOME"
elif [ "$ARG" == "youtube" ] ; then
    installYoutube "$DIR" "$USER_HOME"
elif [ "$ARG" == "voicecommand" ] ; then
    installVoicecommand_install "$DIR" "$USER_HOME"
else
    dependencies "$ARCH"
    playvideo_install
    download "$DIR" "$USER_HOME"
    gtextcommand "$DIR" "$USER_HOME"
    gvapi "$DIR" "$USER_HOME"
    youtube "$DIR" "$USER_HOME"
    voicecommand_install "$DIR" "$USER_HOME"
fi
