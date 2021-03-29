#!/bin/sh
# author: Anthony Michael
#changes the brightness of the monitor, either increases or decreases, by a passed percentage

# command format. $ brightness $1 $2
# $1 is either -inc, -dec, or -set this will determine whether the brightness is increased by, decreased by, or set to
# $2 is a number, which represents the percentage the brightness is increased / decreased by, or set to

# need: some logic to determine whether to increase or decrease
#       some sort of catch, basically, something to make sure that $2 is a number
#       functions to increase brightness by a percent of the maximum
#       functions to decrease brightness by a percent of the maximum

# min brightness is 1, 
#max brightness is stored in /sys/class/backlight/intel_backlight/max_brightness
#current brightness is stored in /sys/class/backlight/intel_backlight/brightness

#lock or something, prevents more than one instance of the script from running at the same time
me="$(basename "$0")";
running=$(ps h -C "$me" | grep -wv $$ | wc -l);
[[ $running > 1 ]] && exit;

#some directories
pathToBacklight="/sys/class/backlight/intel_backlight/"
#pathToBacklight="/home/ruby/backlight-tests/"
maxBrightnessPath="${pathToBacklight}max_brightness"
maxBrightness=$(<${maxBrightnessPath})
brightnessPath="${pathToBacklight}brightness"
readonly maxBrightnessPath
readonly pathToBacklight
readonly brightnessPath
numericRE='^[0-9]+$'
if ! [[ ${2} =~ ${numericRE} ]] ;  then
	#is not numeric, return with an error
	echo "passed number is not a numeric integer"
	exit 1
fi

#check if $2 is a valid percentage
#if [[ $2 > 100 ]] ; then 
#	#greater than 100
#	echo "invalid argument $2, too big"
#	exit 1
if [[ $2 < 0 ]] ; then
	#shouldn't ever occur, but just incase $2 is negative
	echo "invalid argument $2, too small"
	exit 1
fi

#actually changes the brightness
bright() {
	echo $newBrightness | tee ${brightnessPath}
}

curBrightness=$(<${brightnessPath})
newBrightness=$(<${brightnessPath})
change=$2
#increase brightness by $2 %
increaseBrightness() {
	local postIncBrightness=$(( ${curBrightness}+$(( $(( $maxBrightness*$change ))/100  )) ))
	#if the new brightness is too high just set it to the max
	#works by subtracting the new value by the max, if it is negative (new value is less than max), the check fails, otherwise (new value greater than max) it sets is to the max
	if [[ $((postIncBrightness - maxBrightness)) =~ ${numericRE} ]] ; then
		newBrightness=$(($maxBrightness-1))
	else
		newBrightness=${postIncBrightness}
	fi
	bright
}
#decrease brightness by $2 %
decreaseBrightness() {
	local postDecBrightness=$(( $curBrightness-$(( $(( $maxBrightness*$change  ))/100 )) ))
	#if the new brightness is to low, just set it to 1
	postDecBrightness=$((postDecBrightness--))
	if ! [[ $postDecBrightness =~ ${numericRE} ]] ; then
		newBrightness=1
	else
		postDecBrightness=$((postDecBrightness++))
		newBrightness=${postDecBrightness}
	fi
	bright
}

# set brightness to $2 %
setBrightness() {
	local postSetBrightness=$(( $(( maxBrightness*$change ))/100 ))
	if ! [[ $postSetBrightness =~ ${numericRE} ]] ; then
		newBrightness=curBrightness
	elif [[ $((postSetBrightness - maxBrightness)) =~ ${numericRE} ]] ; then
		newBrightness=curBrightness 
	else 
		newBrightness=postSetBrightness
	fi
	bright
}

#select the command
case $1 in
	-inc|inc|+) increaseBrightness;;
	-dec|dec|-) decreaseBrightness;;
	-set|set|=) setBrightness;;
	*) echo "invalid argument ${1}" ; exit 1;; 
esac

#exit the script
exit 0
