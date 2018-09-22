%post --nochroot
#personal stuff below
cp -v /etc/ssmtp/ssmtp.conf $INSTALL_ROOT/etc/ssmtp/
tar -C /home/bkelly -cf - .vimrc .vim .local/share/nvim/site .config/nvim | ( cd $INSTALL_ROOT/etc/skel/; tar -xpf -)
mkdir -p $INSTALL_ROOT/etc/skel/.config/i3
cp -v /home/bkelly/.config/i3/* $INSTALL_ROOT/etc/skel/.config/i3/
mkdir  $INSTALL_ROOT/etc/skel/.config/sway
cp -v /home/bkelly/.config/sway/* $INSTALL_ROOT/etc/skel/.config/sway/

%end
