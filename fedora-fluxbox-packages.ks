# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with the Fluxbox Desktop
#
# Maintainer(s):

%packages

-NetworkManager
-NetworkManager-*
wicd
wicd-curses
wicd-gtk
lxqt-sudo
plank
plank-docklets
lightdm
lxappearance
abattis-cantarell-fonts
xcompmgr
udiskie
nitrogen
xterm
mate-terminal
#lx-terminal
vim-enhanced
gvim
#vim-x11
#neovim
tmux
emacs
f24-backgrounds-base
fedora-icon-theme
fluxbox-vim-syntax
xorg-x11-xinit
xorg-x11-apps
xorg-x11-utils
fbdesk
anaconda-tui
quodlibet

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
system-config-printer
system-config-date

# save some space
-autofs
-acpid
-realmd                     # only seems to be used in GNOME
-aspell-*                   # dictionaries are big
-NetworkManager*
-abrt-*
%end

