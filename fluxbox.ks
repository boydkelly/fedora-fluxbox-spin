#this needs to be fixed with etc/skel
# Fedora Fluxbox config
mkdir -p /etc/skel/.fluxbox/{backgrounds,pixmaps,styles/Adwaita/pixmaps}
cp /usr/share/fluxbox/* /etc/skel/.fluxbox/

#Style stuff
cp -v /usr/share/pixmaps/* /etc/skel/.fluxbox/styles/Adwaita/pixmaps/

cat > /etc/skel/.fluxbox/styles/Adwaita/theme.cfg <<'FOE'
style.name:		Fluxbox-Adwaita
style.author:		Boyd Kelly	
style.date:		2016-08-07
style.credits:		
style.comment:          

background:				fullscreen
background.pixmap:			/usr/share/backgrounds/default.png
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
slit.pixmap:				fedora_whitelogl.xmp
FOE

#missing init stuff.  put toolbar on top for now
cat >> /etc/skel/.fluxbox/init << FOE
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
cat > /etc/skel/.fluxbox/startup << FOE
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


nitrogen --restore &
#[ -f /usr/bin/nitrogen ] && nitrogen --restore &
[ -f /usr/bin/xcompmgr ] && xcompmgr -f &
[ -f /usr/bin/plank ] && /usr/bin/plank &
[ -f /usr/bin/tilda ] && /usr/bin/tilda  &
[ -f /usr/bin/udiskie ] && /usr/bin/udeskie &
[ -f /usr/bin/nm-applet ] && /usr/bin/nm-applet &
#[ -f /usr/libexec/polkit-gnome-authentication-agent-1 ]  && /usr/libexec/polkit-gnome-authentication-agent-1 &

# exec fluxbox
# or if you want to keep a log:
exec fluxbox -log "\$fluxdir/log"
FOE

#then make a submenu with fluxbox-xdg-menu
fluxbox-xdg-menu -f /etc/skel/.fluxbox/usermenu --theme=Fedora --with-icons --submenu --with-backgrounds --bg-path=/usr/share/backgrounds
#fluxbox-xdg-menu --with-icons --theme=Fedora --submenu --with-backgrounds --bg-path=/usr/share/backgrounds -f /etc/skel/.fluxbox/menu
#and include the xdg-menu in the usermenu
#echo "[include]	(~/.fluxbox/xdg-menu)" >> /etc/skel/.fluxbox/usermenu

#Now with fluxbox-generate for the main menu
export TERM=/usr/bin/sakura
/usr/bin/fluxbox-generate_menu -t \$TERM -g -b /usr/bin/firefox -w www.getfedora.org -o /etc/skel/.fluxbox/menu -u /etc/skel/.fluxbox/usermenu -su

#Fix bug in fbgenerate menu
sed -i 's/\/share\/fluxbox/\/usr\/share\/fluxbox/g' /etc/skel/.fluxbox/menu
#todo: replace liveuser with ~/. in fluxbox-generate menu

#Plank
#The directories...
mkdir -p /etc/skel/.config/plank/dock1/launchers

cat > /etc/skel/.config/plank/dock1/settings << FOE
[PlankDockPreferences]
Position=3
Items=3
ItemsAlignment=3
Theme=Default
FOE

#script to configure plank items
cat > /usr/local/bin/plank_config.sh << 'FOE'
#!/bin/bash
DOCK="/home/liveuser/.config/plank/dock1"
LAUNCHERS="launchers.txt"
[ ! -d \$DOCK/launchers ] &&  mkdir -p \$DOCK/launchers
[ ! -f \$DOCK/\$LAUNCHERS ] && echo plank > \$DOCK/\$LAUNCHERS

cd \$DOCK/launchers || exit 1

readarray DOCKITEMS < \$DOCK/\$LAUNCHERS
for i in \${DOCKITEMS[@]};do
	echo > \$i.dockitem
	echo [PlankItemsDockItemPreferences] >> \$i.dockitem
	echo "Launcher=file:///usr/share/applications/\$i.desktop" >> \$i.dockitem
done

for ((i=0; i<\${#DOCKITEMS[@]}; i++)); do
	DOCKITEMS[\$i]=\$(echo \${DOCKITEMS[\$i]} | xargs).dockitem
	#echo ${DOCKITEMS[$i]}
done
#Doesn't see to be used anymore.  Check out gsettings.
echo DockItems=\${DOCKITEMS[@]} | sed -e "s/ /\;\;/g" >> \$DOCK/settings
FOE

#rm /etc/skel/.config/plank/dock1/settings

#Create launchers.txt for above script
cat > /etc/skel/.config/plank/dock1/launchers.txt << FOE
emacs
gvim
sakura
firefox
quodlibet
liveinst
FOE

#run it!
chmod +x /usr/local/bin/plank_config.sh
/usr/local/bin/plank_config.sh

#nitrogen
mkdir -v -p /etc/skel/.config/nitrogen/
cat > /etc/skel/.config/nitrogen/bg-saved.cfg << FOE
[:0.0]
file=/usr/share/backgrounds/default.png
mode=4
bgcolor=#000000
FOE

cat > /etc/skel/.config/nitrogen/nitrogen.cfg << FOE
[geometry]
posx=0
posy=0
sizex=450
sizey=500

[nitrogen]
view=list
recurse=true
sort=alpha
icon_caps=false
dirs=/usr/share/backgrounds;
FOE

#gtk settings
touch /etc/skel/.gtkrc-2.0.mine
cat > /etc/skel/.gtkrc-2.0 << FOE
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

mkdir -v -p /etc/skel/.config/gtkrc-2.0
mkdir -v -p /etc/skel/.config/gtkrc-3.0

cat > /etc/skel/.config/gtkrc-3.0/settings.ini << FOE
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
cat > /etc/skel/.fluxbox/fbdesk.icons << FOE
[Desktop Entry]
#Icon=/usr/share/icons/hicolor/256x256/apps/anaconda.png
Name="Install Fedora Fluxbox spin"
Exec=/usr/bin/anaconda
Pos= 600 500
[end]
FOE

