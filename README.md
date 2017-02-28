Fedora Fluxbox Spin

Author:  Boyd Kelly
Email:  bkelly TA coastsystems TOD net


This is a Fedora Fluxbox desktop featuring:

Adwaita Theme (As much as Fluxbox allows)
Plank dock
Tilda
Emacs
Gvim
Powerline
Tmux

As you can see there is not much installed.  I figure people using fluxbox all haver various reasons.  Install your favorite Terminal, and set $TERM in your .bash_profile.  Then run the Regenerate Menu command to add it to the Fluxbox menu.  (This command will also add in any .desktop files it finds for programs you have installed)

If the Tilda terminal bugs you, F1 toggles hide/unhide.  Or disable completely in .fluxbox/startup.

If you are running an HIDPI display add this to your .xinitrc:

!lines below for hidpi
Xft.dpi: 200
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb

Please send any suggestions or problems.  Thank you!
