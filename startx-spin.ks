# fedora-livecd-startx.ks
#
# Description:
# - Fedora Live Spin with Fluxbox i3 and sway!
#
# Maintainer(s):
# - Boyd Kelly       <bkelly AT coastsystems  DOT .net>

#services --disabled=NetworkManager,ModemManager,network  --enabled=wicd

%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include extrarepos.ks
%include lang.ks
%include post-nochroot.ks

#%include fluxbox-packages.ks
%include startx-packages.ks
%include gui-packages.ks
%include tui-packages.ks
#%include rescue-packages.ks

#these two machine specific
%include firmware.ks
%include vm-guest.ks

%include liveuser.ks
%include xorg.ks
%include hidpi.ks
%include sway.ks
%include i3.ks

part / --size 6168 
timezone --utc UTC
selinux --disabled
rootpw --plaintext root

%post

#/usr/sbin/useradd bkelly
#/usr/bin/passwd -d bkelly > /dev/null
#/usr/sbin/usermod -aG wheel bkelly > /dev/null
#echo "FONT=ter-v32n" >> /etc/vconsole.conf

cat >> /etc/rc.d/init.d/livesys << EOF

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

mount -t nfs4 localhost:/bkelly/ /mnt
echo $(date -I)-starx-spin  > /mnt/livecd/install.log

%end
