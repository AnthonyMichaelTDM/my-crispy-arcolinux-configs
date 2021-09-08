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
CURSOR_TARGET="~/.icons/"
readonly CURSOR_SOURCE
readonly CURSOR_TARGET

TERMITE_SOURCE="${CONFIG_DIRECTORY}termite/BloodMoon.config"
TERMITE_TARGET="~/.config/termite/themes/"
readonly TERMITE_SOURCE_DIR
readonly TERMITE_TARGET_DIR

GTK_SOURCE="${CONFIG_DIRECTORY}GTK/BloodMoon/"
GTK_TARGET="~/.themes/"
readonly GTK_SOURCE
readonly GTK_TARGET

VIMRC_SOURCE="${CONFIG_DIRECTORY}vimrc"
VIMRC_TARGET="/etc/"
readonly VIMRC_SOURCE
readonly VIMRC_TARGET

ZSHRC_PERSONAL_SOURCE="${CONFIG_DIRECTORY}.zshrc-personal"
ZSHRC_PERSONAL_TARGET="~/"
readonly ZSHRC_PERSONAL_SOURCE
readonly ZSHRC_PERSONAL_TARGET

DWM_SOURCE="${CONFIG_DIRECTORY}arco-dwm/"
ST_SOURCE="${CONFIG_DIRECTORY}arco-st/"
SLSTATUS_SOURCE="${CONFIG_DIRECTORY}arco-slstatus/"
SUCKLESS_TARGET="~/.config/"
DWM_MAKE_DIR="${SUCKLESS_TARGET}arco-dwm/"
ST_MAKE_DIR="${SUCKLESS_TARGET}arco-st/"
SLSTATUS_MAKE_DIR="${SUCKLESS_TARGET}arco-slstatus/"
readonly DWM_SOURCE
readonly ST_SOURCE
readonly SLSTATUS_SOURCE
readonly SUCKLESS_TARGET
readonly DWM_MAKE_DIR
readonly ST_MAKE_DIR
readonly SLSTATUS_MAKE_DIR

BRIGHTNESS_SCRIPT_SOURCE="${CONFIG_DIRECTORY}Scripts/configure-brightness.sh"
BRIGHTNESS_SCRIPT_TARGET="~.bin/my-scripts"
readonly BRIGHTNESS_SCRIPT_SOURCE
readonly BRIGHTNESS_SCRIPT_TARGET
CLEAN_DIR="${CONGIF_DIRECTORY}Scripts/clean/"
readonly CLEAN_DIR

echo "welcome to my theme install script, this will not install the SDDM theme, nor install themes to the root user, this is for your safety as this is my first time writing a bash script"

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
		cp -r $CURSOR_SOURCE $CURSOR_TARGET
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
		cp -r $GTK_SOURCE $GTK_TARGET
		echo ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}" ;;
esac

#install vim configs
read -p "do you want to install the vim configs? y/n" -n 1 -r vimrcYN
echo
case $vimrcYN in
	y|Y ) #install
		sudo cp $VIMRC_SOURCE $VIMRC_TARGET
		echo ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}" ;;
esac

#install personal zsh alias's
read -p "do you want to install the personal zsh alias's? y/n" -n 1 -r zshPersonalYN
echo
case $zshPersonalYN in
	y|Y ) #install
		cp $ZSHRC_PERSONAL_SOURCE $ZSHRC_PERSONAL_TARGET
		echo ;;
	n|N ) #do not install
		echo ;;
	* ) #invalid
		echo "${INVALID_RESPONSE}" ;;
esac

#install suckless utilies
read -p "do you want to install and build the suckless utilities (DWM,SLSTATUS, and ST)\nthis also overwrites your sxhkd keybinds, and autostart script, make sure to back thos up before running this as those tend to be very hardware specific (only do this if you use dwm or know what you're doing, needs SUDO)? y/n" -n 1 -r sucklessYN
echo
case $sucklessYN in
	y|Y ) #install
		#copy the files into the install location
		cp -r $DWM_SOURCE $ST_SOURCE $SLSTATUS_SOURCE $SUCKLESS_TARGET 
		#build the untilities
		sudo make clean install -C $DWM_MAKE_DIR
		sudo make clean install -C $ST_MAKE_DIR
		sudo make clean install -C $SLSTATUS_MAKE_DIR
		echo;;
	n|N ) #do not install
		echo;;
	* ) #invalid
		echo "${INVALID_RESPONSE}" ;;
esac

#install brightness changing script
read -p "do you want to install my brightness script? y/n" -n 1 -r brightnessScriptYN
echo
case $brightnessScriptYN in
	y|Y ) #install
		cp $BRIGHTNESS_SCRIPT_SOURCE $BRIGHTNESS_SCRIPT_TARGET
		echo "follow the instructions in Scripts/configure-brightness-README.md"
		echo ;;
	n|N ) #do not install 
		#overwrite some key files with "clean" versions
		#does the sxhkd config need to be overwritten
		case $sucklessYN in
			y|Y ) # need to overwrite sxhkdrc
				cp '${CLEAN_DIR}sxhkdrc' '${DWM_MAKE_DIR}sxhkd/'
				echo ;;
			* )
				echo ;;
		esac
		#does the .zshrc-personal need to be overwritten?
		case $zshPersonalYN in
			y|Y ) #need to overwrite .zshrc-personal
				cp '${CLEAN_DIR}.zshrc-personal' $ZSHRC_PERSONAL_TARGET
				echo ;;
			* ) 
				echo ;;
		esac
esac
#exit script with success message
exit 0
