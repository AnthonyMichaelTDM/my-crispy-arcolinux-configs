#!/bin/sh

#variables, storing file paths
INVALID_RESPONSE="Answer 'y' or 'n' next time, defaulting to doing nothing"
readonly INVALID_RESPONSE

CONFIG_DIRECTORY="~/my-crispy-arcolinux-configs/" #for end user: change this to be the directory you stored my configs in
readonly CONFIG_DIRECTORY

CONKY_SOURCE="${CONFIG_DIRECTORY}Conky/BloodMoon.conkyrc"
CONKY_TARGET="~/.config/conky/"
CONKY_LIST_DIR="~/.config/conky/.conky-list.txt"
readonly CONKY_SOURCE
readonly CONKY_TARGET
readonly CONKY_LIST_DIR

CURSOR_SOURCE="${CONFIG_DIRECTORY}Cursors/BloodMoon-Cursor/"
readonly CURSOR_SOURCE_DIR
CURSOR_TARGET="~/.icons/"
readonly CURSOR_TARGET_DIR

TERMITE_SOURCE="${CONFIG_DIRECTORY}termite/BloodMoon.config"
TERMITE_TARGET="~/.config/termite/themes/"
readonly TERMITE_SOURCE_DIR
readonly TERMITE_TARGET_DIR

GTK_SOURCE="${CONFIG_DIRECTORY}GTK/BloodMoon/"
GTK_TARGET="~/.themes/"
readonly GTK_SOURCE
readonly GTK_TARGET

echo "welcome to my theme install script, this will not install the SDDM theme, nor install the themes to the sudo user, this is for your safety as this is my first time writing a bash script"

# install conky
read -p "do you want to install the conky? y/n" -n 1 -r ConkyYN
echo
case $ConkyYN in
	y|Y ) #install
		cp $CONKY_SOURCE $CONKY_TARGET
		echo "BloodMoon.conkyrc" >> "${CONKY_LIST_DIR}" ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}";;
esac

# install cursor theme
read -p "do you want to install the Cursor theme? y/n" -n 1 -r CursorYN
echo
case $CursorYN in
	y|Y ) #install
		cp $CURSOR_SOURCE $CURSOR_TARGET
		#todo: build the cursors later if needed?
		echo ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}";;
esac

#install Termite theme
read -p "do you want to install the Termite theme? y/n" -n 1 -r TermiteYN
echo
case $TermiteYN in
	y|Y ) #install
		cp $TERMITE_SOURCE $TERMITE_TARGET
		echo;;
	n|N) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}";;
esac

#install GTK theme
read -p "do you want to install the GTK theme? y/n" -n 1 -r GtkYN
echo
case $GtkYN in
	y|Y ) #install
		cp $GTK_SOURCE $GTK_TARGET
		echo ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}" ;;
esac

#exit script with success message
exit 0
