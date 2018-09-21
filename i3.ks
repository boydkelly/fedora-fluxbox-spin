%post

cat > /etc/skel/.xinitrc <<FOE
dbus-run-session i3
FOE

%end
