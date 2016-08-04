# fedora-livecd-fluxbox.ks
#
# Description:
# - Fedora Live Spin with the Fluxbox Desktop
#
# Maintainer(s):

%packages

wicd
wicd-curses
wicd-gtk
lxqt-sudo
plank
lightdm
lxappearance
abattis-cantarell-fonts
xcompmgr
udiskie
nitrogen
xterm
mate-terminal
vim-enhanced
gvim
emacs
f24-backgrounds-base
fluxbox-vim-syntax
xorg-x11-apps
xorg-x11-utils
fbdesk
anaconda-tui

# unlock default keyring. FIXME: Should probably be done in comps
# gnome-keyring-pam #Maybe add if gnome stuff
# Admin tools are handy to have
@admin-tools
wget
# Handy for debugging
#rfkill
firefox
elinks
lynx
system-config-printer

# save some space
-autofs
-acpid
-realmd                     # only seems to be used in GNOME
-aspell-*                   # dictionaries are big
-NetworkManager*
-abrt-*
%end

