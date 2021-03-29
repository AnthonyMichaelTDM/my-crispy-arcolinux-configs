assumes you have intel_backlight

works by directly modifying system files, and as such needs sudo perms, and should be used with caution

made because xbacklight didn't work on my thinkpad

usage:
sudo -n {path to script}/brightness_script.sh {command} {argument}

{path to script} == the path to the directory containing the script
{command} == either '-inc', 'inc'; '-dec', 'dec'; or '-set','set'
		-inc means the script will increase the brightness
		-dec means the script will decrease the brightness
		-set means the script will set the brightness
{argument} == an integer between 0 and 100 representing the percentage the brightness should increase by, decrease by, or be set to

to bind this to a hotkey, (like i did), you must whitelist the script with sudoers
do that by:
creating a file with the path: /etc/sudoers.d/brightness
with the following content
yourusername ALL=(ALL) NOPASSWD:path/to/script


also NOTE:
the sxhkdrc in this repo (arco-dwm/sxhkd/sxhkdrc) has the path to the script hard coded in, you will need to change this if you plan on using said configs
