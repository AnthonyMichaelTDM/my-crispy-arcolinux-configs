# my-crispy-arcolinux-configs
the configs i use with my arcolinuxd install

general instructions (assuming you are using arco linux):
  
  for the conky:
    put the file in the following directory: `/home/*user*/.config/conky/`
    then, add the following line to the top of the .conky-list.txt file in the same directory
      `BloodMoon.conkyrc`
    after than, in your terminal, do 
      `$ conky-rotate -n`
    until the conky shows up, after that you can use 
      `$ conky-toggle`
    once or twice and it should then stay there, and autolaunch when you log in
    
  for the termite theme:
    simply put the file in the following directory: `/home/*user*/.config/termite/themes/`
    and you should then be able to select the theme with the Arcolinux Tweak Tool
  
  for the SDDM theme
    put the BloodMoon folder into the following directory: `/usr/share/SDDM/themes/`
    to select the theme, you're going to have to nano (or vim, or whatever) into the SDDM config file at the following file path: 
      `/usr/lib/sddm/sddm.conf.d/default.conf`
    once that file is opened, find the [Theme] section of the file, and change the line `Current=` (should be around line 33) to `Current=BloodMoon`
    you can preview this login screen by using the following command in your terminal:
    `$ sddm-greeter --test-mode --theme /usr/share/sddm/themes/BloodMoon/`
    

There are pictures of these configs in action in the Wiki tab
also, you can find the image i used as my desktop background in the SDDM folder, named 'background.jpg'
