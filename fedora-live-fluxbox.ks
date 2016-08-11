# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with Fluxbox desktop 
#
# Maintainer(s):
# - Boyd Kelly       <bkelly AT coastsystems  DOT .net>


#services --disabled=NetworkManager,ModemManager,network  --enabled=wicd

%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include fedora-fluxbox-packages.ks
selinux --permissive

%post

cat >> /etc/rc.d/init.d/livesys << \EOF

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<FOE
PREFERRED=/usr/bin/startfluxbox
DISPLAYMANAGER=/usr/sbin/lightdm
FOE

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set Fluxbox as default session 
sed -i 's/^#user-session=.*/user-session=fluxbox/' /etc/lightdm/lightdm.conf

#X config stuff
touch /home/liveuser/.Xdefaults
ln -s /home/liveuser/.Xdefaults /home/liveuser/.Xresources

# Fedora Fluxbox config
mkdir -p /home/liveuser/.fluxbox/backgrounds /home/liveuser/.fluxbox/pixmaps  /home/liveuser/.fluxbox/styles/Adwaita/pixmaps
cp /usr/share/fluxbox/* /home/liveuser/.fluxbox/

#Style stuff
cp /usr/share/fluxbox/styles/Nyz /home/liveuser/.fluxbox/styles/Fedora-Nyz
cp -pr /usr/share/fluxbox/styles/bloe /home/liveuser/.fluxbox/styles/Fedora-bloe
#Check these
sed -i 's/^menu.frame.justify/menu.frame.justify:\tleft/g' /home/liveuser/.fluxbox/styles/Fedora-Nyz

#We need the Adwaita window decorations.
#for x in `ls /usr/share/themes/Adwaita/gtk-2.0/assets/*.png`; do convert $x /home/liveuser/.fluxbox/styles/Adwaita/pixmaps/`basename -s .png $x`.xpm; done
cp /usr/share/pixmaps/* /home/liveuser/.fluxbox/styles/Adwaita/pixmaps/

cat > /home/liveuser/.fluxbox/styles/Adwaita/theme.cfg << FOE
style.name:		Fluxbox-Adwaita
style.author:		Boyd Kelly	
style.date:		2016-08-07
style.credits:		
style.comment:          

*.font:					Cantarell
!font-size:				20
*.frameWidth:         			0
*.bevelWidth:         			0
*.textColor:				#FFFFFF


toolbar:				flat
toolbar.textColor:			#FFFFFF
toolbar.justify:			center
!toolbar.height:				30
toolbar.borderColor:			#000000
toolbar.borderWidth:			0
toolbar.workspace:			flat
toolbar.workspace.color:                #000000
toolbar.workspace.textColor:		#FFFFFF
toolbar.iconbar.empty:			flat
toolbar.iconbar.empty.color:	        #000000
toolbar.iconbar.focused:		flat
toolbar.iconbar.focused.justify:	left
toolbar.iconbar.unfocused:		flat
toolbar.iconbar.unfocused.color:        #000000
toolbar.iconbar.unfocused.textColor:	#FFFFFF
toolbar.iconbar.unfocused.justify:	left
toolbar.iconbar.focused:		flat
toolbar.iconbar.focused.color:		#000000
toolbar.iconbar.focused.textColor:	#FFFFFF
toolbar.clock:				flat
toolbar.clock.color:                    #000000
toolbar.clock.textColor:		#FFFFFF
toolbar.button:				flat
toolbar.button.color:                   #000000
toolbar.button.picColor:		#FFFFFF
toolbar.shaped:				false

menu.title:				flat
menu.title.color:			#393F3F
menu.title.justify:			right
menu.title.textColor:			#FFFFFF
menu.frame:				flat
menu.frame.justify:			left
menu.frame.color:			#393F3F
menu.frame.textColor:			#FFFFFF
menu.frame.disableColor:		#000000
menu.hilite:				flat
menu.hilite.color:			#4A5050
menu.hilite.textColor:			#FFFFFF
menu.itemHeight:			16
menu.bevelWidth:			0
menu.titleHeight:			4
menu.borderColor:			#393F3F
menu.borderWidth:			5
menu.bullet:				empty	
menu.bullet.position:			right
menu.roundCorners:			TopRight TopLeft BottomRight BottomLeft

window.title.focus:			flat
window.title.focus.color:               #E8E8E7
window.title.textColor:			#000000
window.title.unfocus:			flat
window.title.unfocus.color:             #E8E8E7 
window.title.unfocus.text.color:        #000000
!window.title.height:			30
window.justify:				center
window.label.focus.color:               #E8E8E7
window.label.focus.textColor:		#000000
window.label.unfocus:			flat
window.label.unfocus.color:             #E8E8E7
window.label.unfocus.textColor:		#000000
window.handle.focus:			flat
window.handle.focus.color:		#E8E8E7
window.handle.unfocus:			flat
window.handle.unfocus.color:		#E8E8E7
window.handleWidth:        	        5
window.grip.focus:			flat
window.grip.focus.color:		#E8E8E7
window.grip.unfocus:			flat
window.grip.unfocus.color:		#E8E8E7
window.bevelWidth:			0
window.shade:				true
window.borderWidth:			1
window.borderColor:			#E8E8E7
window.button.focus.color:              #E8E8E7
window.button.unfocus.color:            #E8E8E7
window.tab.justify:                     center
window.tab.label.unfocus:               flat solid
window.tab.label.unfocus.color:         #E8E8E7
window.tab.label.unfocus.textColor:     #000000
window.tab.label.focus:                 flat solid
window.tab.label.focus.color:           #d64937
window.tab.label.focus.textColor:       #000000
window.roundCorners:			TopRight TopLeft BottomRight BottomLeft
window.maximize.pixmap:			maximize.png
window.close.pixmap:			checkbox-unchecked.png.xpm

slit.pixmap:				fedora_whitelogl.xmp
FOE

#missing init stuff.  put toolbar on top for now
cat >> /home/liveuser/.fluxbox/init << FOE
session.screen0.toolbar.autoHide:	false
session.screen0.toolbar.visible:	true
session.screen0.toolbar.height:	0
session.screen0.toolbar.layer:	Desktop
session.screen0.toolbar.maxOver:	false
session.screen0.toolbar.placement:	TopCenter
session.screen0.toolbar.tools:	prevworkspace, workspacename, nextworkspace, iconbar, systemtray, clock
session.screen0.toolbar.onhead:	1
session.screen0.toolbar.alpha:	255
session.screen0.toolbar.widthPercent:	100
session.screen0.tooltipDelay:	500
session.appsFile: 	~/.fluxbox/apps
session.styleFile:	~/.fluxbox/styles/Adwaita
session.styleOverlay:	~/.fluxbox/overlay
FOE


#startup script
cat > /home/liveuser/.fluxbox/startup << FOE
#!/bin/sh
#
# fluxbox startup-script:
#
# Lines starting with a '#' are ignored.

# Change your keymap:
xmodmap "$HOME/.Xmodmap"
#if you are also sing this config with gnome better to put xkeyboard stuff in /etc/X11/xorg.conf.d/

# Applications you want to run with fluxbox.
# MAKE SURE THAT APPS THAT KEEP RUNNING HAVE AN ''&'' AT THE END.
#
# unclutter -idle 2 &
# wmnd &
# wmsmixer -w &
# fbdesk &

#[ -f /usr/libexec/gnome-settings-daemon ] && gnome-settings-daemon &


[ -f /usr/bin/nitrogen ] && nitrogen --restore &
[ -f /usr/bin/xcompmgr ] && xcompmgr -f &
[ -f /usr/bin/plank ] && /usr/bin/plank &
[ -f /usr/bin/tilda ] && /usr/bin/tilda  &
[ -f /usr/bin/udiskie ] && /usr/bin/udeskie &
[ -f /usr/bin/nm-applet ] && /usr/bin/nm-applet &
#[ -f /usr/libexec/polkit-gnome-authentication-agent-1 ]  && /usr/libexec/polkit-gnome-authentication-agent-1 &

# exec fluxbox
# or if you want to keep a log:
exec fluxbox -log "$fluxdir/log"
FOE


#then make a submenu with fluxbox-xdg-menu
fluxbox-xdg-menu -f /home/liveuser/.fluxbox/usermenu --theme=Fedora --with-icons --submenu --with-backgrounds --bg-path=/usr/share/backgrounds
#fluxbox-xdg-menu --with-icons --theme=Fedora --submenu --with-backgrounds --bg-path=/usr/share/backgrounds -f /home/liveuser/.fluxbox/menu
#and include the xdg-menu in the usermenu
#echo "[include]	(~/.fluxbox/xdg-menu)" >> /home/liveuser/.fluxbox/usermenu


#Now with fluxbox-generate for the main menu
/usr/bin/fluxbox-generate_menu -t mate-terminal -B -g -b /usr/bin/firefox -o /home/liveuser/.fluxbox/menu -u /home/liveuser/.fluxbox/usermenu

#Fix bug in fbgenerate menu
sed -i 's/\/share\/fluxbox/\/usr\/share\/fluxbox/g' /home/liveuser/.fluxbox/menu
#todo: replace liveuser with ~/. in fluxbox-generate menu


#Plank
#The directories...
mkdir -p /home/liveuser/.config/plank/dock1/launchers

cat > /home/liveuser/.config/plank/dock1/settings << FOE
[PlankDockPreferences]
Position=3
Items=3
ItemsAlignment=3
Theme=Default
FOE

#script to configure plank items
cat > /usr/local/bin/plank_config.sh << \FOE
#!/bin/sh
DOCK=/home/liveuser/".config/plank/dock1"
LAUNCHERS="launchers.txt"
[ ! -d $DOCK/launchers ] &&  mkdir -p $DOCK/launchers
[ ! -f $DOCK/$LAUNCHERS ] && echo plank > $DOCK/$LAUNCHERS

cd $DOCK/launchers || exit 1

readarray DOCKITEMS < $DOCK/$LAUNCHERS
for i in ${DOCKITEMS[@]};do
	echo > $i.dockitem
	echo [PlankItemsDockItemPreferences] >> $i.dockitem
	echo "Launcher=file:///usr/share/applications/$i.desktop" >> $i.dockitem
done

for ((i=0; i<${#DOCKITEMS[@]}; i++)); do
	DOCKITEMS[$i]=`echo ${DOCKITEMS[$i]} | xargs`.dockitem
	#echo ${DOCKITEMS[$i]}
done
#Doesn't see to be used anymore.  Check out gsettings.
echo DockItems=${DOCKITEMS[@]} | sed -e "s/ /\;\;/g" >> $DOCK/settings
FOE
#rm /home/liveuser/.config/plank/dock1/settings

#Create launchers.txt for above script
cat > /home/liveuser/.config/plank/dock1/launchers.txt << FOE
sylpheed
emacs
gvim
mate-terminal
firefox
liveinst
plank
FOE

#run it!
chmod +x /usr/local/bin/plank_config.sh
/usr/local/bin/plank_config.sh

#nitrogen
mkdir -p /home/liveuser/.config/nitrogen/
cat > /home/liveuser/.config/nitrogen/bg-saved.cfg << FOE
[:0.0]
file=/usr/share/backgrounds/default.png
mode=5
bgcolor=#000000
FOE

cat > /home/liveuser/.config/nitrogen/nitrogen.cfg << FOE
[nitrogen]
view=list
icon_caps=false
dir=/usr/share/backgrounds
FOE

#gtk settings
cat > /home/liveuser/.gtkrc-2.0 << FOE
include "~/.gtkrc-2.0.mine"
gtk-theme-name="Adwaita"
gtk-icon-theme-name="Fedora"
gtk-font-name="Cantarell 11"
gtk-cursor-theme-name="Adwaita"
gtk-cursor-theme-size=48
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=0
gtk-menu-images=0
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintfull"
gtk-xft-rgba="rgb"
gtk-modules="pk-gtk-module:canberra-gtk-module"
FOE

mkdir -p /home/liveuser/.config/gtkrc-2.0
mkdir -p /home/liveuser/.config/gtkrc-3.0

cat > /home/liveuser/.config/gtkrc-3.0/settings.ini << FOE
[Settings]
gtk-theme-name=Adwaita
gtk-icon-theme-name=Fedora
gtk-font-name=Cantarell 11
gtk-cursor-theme-name=Adwaita
gtk-cursor-theme-size=48
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=0
gtk-menu-images=0
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=0
gtk-modules=pk-gtk-module:canberra-gtk-module
FOE

#fbdesk (doesn't work on my laptop...  highdpi???)
cat > /home/liveuser/.fluxbox/fbdesk.icons << FOE
[Desktop Entry]
#Icon=/usr/share/icons/hicolor/256x256/apps/anaconda.png
Name="Install Fedora Fluxbox spin"
Exec=/usr/bin/anaconda
Pos= 600 500
[end]
FOE

#We use the command line a lot in fluxbox
cp -pr /etc/skel/. /home/liveuser/
echo "export TERM=/usr/bin/mate-terminal" >> /home/liveuser/.bash_profile
cat > /home/liveuser/.bashrc << FOE
if [ -f `which powerline-daemon` ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bash/powerline.sh
fi
FOE

#tilda config
mkdir -p /home/liveuser/.config/tilda
cat > /home/liveuser/.config/tilda/config_0 << FOE
tilda_config_version = "1.3.2"
# command = ""
font = "Monospace 11"
key = "F1"
addtab_key = "<Shift><Control>t"
fullscreen_key = "F11"
toggle_transparency_key = "F12"
toggle_searchbar_key = "<Shift><Control>f"
closetab_key = "<Shift><Control>w"
nexttab_key = "<Control>Page_Down"
prevtab_key = "<Control>Page_Up"
movetableft_key = "<Shift><Control>Page_Up"
movetabright_key = "<Shift><Control>Page_Down"
gototab_1_key = "<Alt>1"
gototab_2_key = "<Alt>2"
gototab_3_key = "<Alt>3"
gototab_4_key = "<Alt>4"
gototab_5_key = "<Alt>5"
gototab_6_key = "<Alt>6"
gototab_7_key = "<Alt>7"
gototab_8_key = "<Alt>8"
gototab_9_key = "<Alt>9"
gototab_10_key = "<Alt>0"
copy_key = "<Shift><Control>c"
paste_key = "<Shift><Control>v"
quit_key = "<Shift><Control>q"
title = "Tilda"
background_color = "white"
# working_dir = ""
web_browser = "x-www-browser"
increase_font_size_key = "<Control>equal"
decrease_font_size_key = "<Control>minus"
normalize_font_size_key = "<Control>0"
# show_on_monitor = ""
word_chars = "-A-Za-z0-9,./?%&#:_"
lines = 5000
max_width = 1600
max_height = 150
min_width = 1
min_height = 1
x_pos = 0
y_pos = 30
tab_pos = 0
backspace_key = 0
delete_key = 1
d_set_title = 3
command_exit = 2
scheme = 3
slide_sleep_usec = 20000
animation_orientation = 0
timer_resolution = 200
auto_hide_time = 2000
on_last_terminal_exit = 0
palette_scheme = 0
non_focus_pull_up_behaviour = 0
cursor_shape = 0
# show_on_monitor_number = 0
title_max_length = 25
palette = {11822, 13364, 13878, 52428, 0, 0, 20046, 39578, 1542, 50372, 41120, 0, 13364, 25957, 42148, 30069, 20560, 31611, 1542, 38944, 39578, 54227, 55255, 53199, 21845, 22359, 21331, 61423, 10537, 10537, 35466, 58082, 13364, 64764, 59881, 20303, 29298, 40863, 53199, 44461, 32639, 43176, 13364, 58082, 58082, 61166, 61166, 60652}
scrollbar_pos = 2
back_red = 0
back_green = 0
back_blue = 0
text_red = 65535
text_green = 65535
text_blue = 65535
cursor_red = 65535
cursor_green = 65535
cursor_blue = 65535
scroll_history_infinite = false
scroll_on_output = false
notebook_border = false
antialias = true
scrollbar = false
grab_focus = true
above = true
notaskbar = true
bold = true
blinks = true
scroll_on_key = true
bell = false
run_command = false
pinned = true
animation = true
hidden = false
set_as_desktop = true
centered_horizontally = false
centered_vertically = false
enable_transparency = true
double_buffer = false
auto_hide_on_focus_lost = false
auto_hide_on_mouse_leave = false
title_max_length_flag = true
inherit_working_dir = true
command_login_shell = false
start_fullscreen = false
# image = ""
# scroll_background = false
# use_image = false
transparency = 0
back_alpha = 26175
FOE

cp -pr /home/liveuser/. /etc/skel/

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF
mount -t nfs4 localhost:/bkelly/ /mnt
echo fluxbox-spin  > /mnt/install/fluxbox

%end
