# fedora-startx.ks
#
# Description:
# - Fedora Live Spin with i3/sway
#
# Maintainer(s):

%packages
#-@
#remove this for making key; then find out what individual packages needed for kvm
@guest-desktop-agents

@standard
-@printing
-@fonts
-@input-methods
-@dial-up
-@multimedia
-@firefox
@hardware-support
@anaconda-tools

-abrt-*
-hyperv*
-open-vm-*
-autofs
-acpid
-aspell-*
-abrt-*

liberation-mono-fonts
liberation-sans-fonts
liberation-serif-fonts
terminus-fonts-console
powerline-fonts

network-manager-applet
NetworkManager-tui
NetworkManager-wifi
nm-tray
ModemManager
wpa_supplicant
iw
wireless-tools

sakura
mate-terminal
vim-enhanced
neovim
emacs-nox
tmux
ranger
powerline
tmux-powerline
f29-backgrounds-base
xorg-x11-xinit
xorg-x11-apps
xterm
xorg-x11-utils
xorg-x11-drv-libinput
xorg-x11-xauth
#only for kvm
xorg-x11-drv-qxl

#error with sway
mesa-libgbm
#error with startx i3
libxshmfence

i3
dbus-x11
sway
i3lock
i3status
dunst
feh
xcompmgr
udiskie
xautolock
scrot

pulseaudio
pulseaudio-utils
pulseaudio-module-x11
blueman

#monitoring
glances
procps-ng

rfkill

wget
curl 
elinks

#mail support
ssmtp
mailx

#passwd error on spin
libffi
#system-config-printer
#system-config-date

#
libXtst
libSM

# save some space
%end
