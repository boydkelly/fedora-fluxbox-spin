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

cat >> /etc/rc.d/init.d/livesys << EOF
mkdir /run/rpcbind
chown rpc:rpc /run/rpcbind

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
sed -i 's/^#autologin-session=.*/autologin-session=fluxbox/' /etc/lightdm/lightdm.conf

#X config stuff
touch /home/liveuser/.Xdefaults
ln -s /home/liveuser/.Xdefaults /home/liveuser/.Xresources
#chown -R liveuser:liveuser /home/liveuser/.Xdefaults /home/liveuser/.Xresources

%include fluxbox.ks

#We use the command line a lot in fluxbox
#cp -r /etc/skel /home/liveuser/
echo "export TERM=/usr/bin/mate-terminal" >> /home/liveuser/.bash_profile
cat >> /home/liveuser/.bashrc << 'FOE'
if [ -f \$(which powerline-daemon) ]; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/share/powerline/bash/powerline.sh
fi
FOE

#tilda config
mkdir -v -p /home/liveuser/.config/tilda
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

#maybe enter settings to /etc/skel manually? For new users...
#will need .fluxbox files too
#check for refs to liveuser
rsync -aupr /home/liveuser/.config /etc/skel/
rsync -aupr /home/liveuser/.fluxbox /etc/skel/
chown -R root:root /etc/skel

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF
mount -t nfs4 localhost:/bkelly/ /mnt
echo $(date -I)-fluxbox-spin  > /mnt/install/fluxbox

%end
