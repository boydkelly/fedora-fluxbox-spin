%post --nochroot
cp -v /etc/ssmtp/ssmtp.conf $INSTALL_ROOT/etc/ssmtp/
#personal stuff below
tar -C /home/bkelly -cf - .vimrc .vim .local/share/nvim/site .config/nvim | ( cd $INSTALL_ROOT/etc/skel/; tar -xpf -)
cp -v /home/bkelly/.config/i3/config $INSTALL_ROOT/etc/skel/.config/i3/
cp -v /home/bkelly/.config/sway/config $INSTALL_ROOT/etc/skel/.config/sway/

%end
