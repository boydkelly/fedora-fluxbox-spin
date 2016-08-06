# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with Fluxbox desktop 
#
# Maintainer(s):
# - Boyd Kelly       <bkelly AT coastsystems  DOT .net>

selinux --permissive
services --disabled=NetworkManager,ModemManager,network  --enabled=wicd

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
mkdir -p /home/liveuser/.fluxbox/backgrounds /home/liveuser/.fluxbox/pixmaps  /home/liveuser/.fluxbox/styles
cp /usr/share/fluxbox/* /home/liveuser/.fluxbox/
cp /usr/share/fluxbox/styles/Nyz /home/liveuser/.fluxbox/styles/Fedora-Nyz
cp -pr /usr/share/fluxbox/styles/bloe /home/liveuser/.fluxbox/styles/Fedora-bloe
#Check these

sed -i 's/^menu.frame.justify/menu.frame.justify\tleft/g' /home/liveuser/.fluxbox/styles/Fedora-Nyz
sed -i 's/session.styleFile/session.stylefile\t~/.fluxbox/styles/Fedora-Nyz' /home/liveuser/.fluxbox/init
echo "session.appsFile: ~/.fluxbox/apps" >> /home/liveuser/.fluxbox/init

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
/usr/bin/plank &
/usr/bin/udiskie &

[ -f /usr/libexec/polkit-gnome-authentication-agent-1 ]  && /usr/lib/exec/polkit-gnome-authentication-agent-1 &

exec fluxbox
# or if you want to keep a log:
# exec fluxbox -log "$fluxdir/log"
FOE

touch /home/liveuser/.fluxbox/usermenu
/usr/bin/fluxbox-generate_menu -t mate-terminal -B -g -b /usr/bin/firefox -o /home/liveuser/.fluxbox/menu -u /home/liveuser/.fluxbox/usermenu

#Fix bug in fbgenerate menu
sed -i 's/\/share\/fluxbox/\/usr\/share\/fluxbox/g' /home/liveuser/.fluxbox/menu
#replace liveuser with ~/. in fluxbox-generate menu


#Put some sysadmin stuff into fluxbox menu

cat > /home/liveuser/.fluxbox/menu_sysconfg << FOE
[submenu] (System-config)
	[exec] (Network) {system-config-network}
	[exec] (Date) {system-config-date}
	[exec] (Users) {system-config-users}
	[exec] (Printers)	{system-config-printer}
	[exec] (Keyboard)	{system-config-keyboard}
	[exec] (Samba)	{system-config-samba}
[end]
FOE

echo "[include]	(~/.fluxbox/menu_sysconfig)" >> /home/liveuser/.fluxbox/menu
echo "[include]	(~/.fluxbox/usermenu)" >> /home/liveuser/.fluxbox/menu

#Plank
#The directories...
mkdir -p /home/liveuser/.config/plank/dock1/launchers

cat > /home/liveuser/.config/plank/dock1/settings << FOE
[PlankDockPreferences]
CurrentWorkspaceOnly=false
IconSize=20
HideMode=2
UnhideDelay=1
HideDelay=1
Monitor=
Position=left
Offset=0
Theme=Default
Alignment=0
ItemsAlignment=1
LockItems=false
PressureReveal=false
PinnedOnly=false
AutoPinning=true
ShowDockItem=true
ZoomEnabled=true
ZoomPercent=100
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

echo DockItems=${DOCKITEMS[@]} | sed -e "s/ /\;\;/g" >> $DOCK/settings
FOE
rm /home/liveuser/.config/plank/dock1/settings

#Create launchers.txt for above script
cat > /home/liveuser/.config/plank/dock1/launchers.txt << FOE
gvim
emacs
mate-terminal
chromium
system-config-date
lxappearance
liveinst
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
gtk-icon-theme-name="Adwaita"
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
gtk-icon-theme-name=Adwaita
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
Icon=/usr/share/icons/hicolor/256x256/apps/anaconda.png
Name="Install Fedora Fluxbox spin"
Exec=/usr/bin/anaconda
Pos= 600 500
[end]
FOE

#We use the command line a lot in fluxbox
cp -pr /etc/skel/. /home/liveuser/
cp -pr /home/liveuser/. /etc/skel/

#exclude NetworkManger in fedora-fluxbox.ks does't seem to work
#rpm -e --nodeps NetworkManager-* --force
#rpm -e --nodeps NetworkManager --force

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser


EOF
mount -t nfs4 localhost:/bkelly/ /mnt
echo fluxbox-spin  > /mnt/install/fluxbox-`date`

%end

