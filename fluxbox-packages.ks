# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with the Fluxbox Desktop
#
# Maintainer(s):

%packages

#-libcrypt
#avoid an error on boot
rpcbind 
libcanberra-gtk2
libcanberra-gtk3


plank
plank-docklets
lightdm
abattis-cantarell-fonts
xcompmgr
udiskie
nitrogen
xterm
sakura
glances
tilda
vim-enhanced
gvim
#vim-x11
tmux
emacs
f25-backgrounds-base
fedora-icon-theme
fluxbox-vim-syntax
xorg-x11-xinit
xorg-x11-apps
xorg-x11-utils
fbdesk
anaconda-tui
network-manager-applet
#utilities
#alacarte
redhat-menus
ImageMagick

#apps
alpine
quodlibet
sylpheed

# unlock default keyring. FIXME: Should probably be done in comps
# gnome-keyring-pam #Maybe add if gnome stuff
# Admin tools are handy to have
#@admin-tools
wget
rfkill
curl 
powerline
tmux-powerline
vim-powerline
powerline-docs

firefox
#chromium
elinks
lynx
#system-config-printer
#system-config-date

# save some space
-autofs
-acpid
-aspell-*                   # dictionaries are big
-abrt-*

%end

