# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with i3/sway/fluxbox
#
# Maintainer(s):

%packages
-lightdm
-libcrypt
libcrypt-nss
network-manager-applet
#wicd
#wicd-curses
#wicd-gtk
#lxqt-sudo
plank
plank-docklets
lxappearance
abattis-cantarell-fonts
xcompmgr
udiskie
nitrogen
xterm
mate-terminal
vim-enhanced
gvim
#neovim
tmux
emacs
screen
f25-backgrounds-base
fedora-icon-theme
fluxbox-vim-syntax
xorg-x11-xinit
xorg-x11-apps
xorg-x11-utils
fbdesk
anaconda-tui
i3
#suggested for i3
i3lock
i3status
dunst
feh
xautolock
scrot
network-manager-applet
blueman
sway
glances
procps-ng

# unlock default keyring. FIXME: Should probably be done in comps
# gnome-keyring-pam #Maybe add if gnome stuff
# Admin tools are handy to have
@admin-tools
wget
rfkill
curl 

-firefox
chromium
elinks
lynx
#system-config-printer
#system-config-date

# save some space
-autofs
-acpid
-realmd                     # only seems to be used in GNOME
-aspell-*                   # dictionaries are big
-abrt-*
%end

