# my-crispy-arcolinux-configs
the configs i use with my arcolinuxd install

general instructions (assuming you are using arco linux):
  
## for the conky:
put the file in the following directory: `/home/*user*/.config/conky/`

then, add the following line to the top of the .conky-list.txt file in the same directory
`BloodMoon.conkyrc`

after that, in your terminal, do `$ conky-rotate -n` until the conky shows up, 

after that you can use `$ conky-toggle` once or twice and it should then stay there, and autolaunch when you log in
    
## for the termite theme:
simply put the file in the following directory: `/home/*user*/.config/termite/themes/`and you should then be able to select the theme with the Arcolinux Tweak Tool
  
## for the SDDM theme:
put the BloodMoon folder into the following directory: `/usr/share/SDDM/themes/`

to select the theme, you're going to have to nano (or vim, or whatever) into the SDDM config file at the following file path: 
`/usr/lib/sddm/sddm.conf.d/default.conf`

once that file is opened, find the [Theme] section of the file, and change the line `Current=` (should be around line 33) to `Current=BloodMoon`

you can preview this login screen by using the following command in your terminal:
`$ sddm-greeter --test-mode --theme /usr/share/sddm/themes/BloodMoon/`
  
## for the GTK theme:
put the BloodMoon folder into one or both of the following directories:

-`/home/*user*/.themes/` if you only want one user to be able to use it,

-`/usr/share/themes/` if you want all users (including root) to be able to use it

to turn on the theme, simply open your DE's version of the Appearance app, the BloodMoon theme should show up in the menu, select it, 		

[if you use XFCE] (other DE's may have similar issues aswell, i don't know)
from there, you're going to want to open the panel customization gui, navigate to the appearence tab, and turn off dark mode (i know, it doesn't really make sense)

## misc info
-There are pictures of these configs in action in the Wiki tab

-also, you can find the image i used as my desktop background in the SDDM folder, named 'background.jpg'

-if you have any suggestions, feel free to let me know in the issues tab
