repo --name=winehq --baseurl=https://dl.winehq.org/wine-builds/fedora/27
#repo --name=local --baseurl=file:///var/www/html/localrepo
repo --name=heikoada-gtk --baseurl=https://copr-be.cloud.fedoraproject.org/results/heikoada/gtk-themes/fedora-$releasever-$basearch/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
repo --name=rpmfusion-free --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os/
repo --name=rpmfusion-free --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-29&arch=x86_64
repo --name=rpmfusion-free-updates-testing --baseurl=http://download1.rpmfusion.org/free/fedora/updates/testing/$releasever/Everything/$basearch/os/
repo --name=xkeyboard-config-ci --baseurl=https://copr-be.cloud.fedoraproject.org/results/boydkelly/xkeyboard-config-ci/fedora-$releasever-$basearch/
repo --name=anki21 --baseurl=https://copr-be.cloud.fedoraproject.org/results/boydkelly/anki21/fedora-$releasever-$basearch/
repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch

#Above for installation repositories; Below for repos installed into image

%post
cat > /etc/yum.repos.d/localnet.repo <<FOE
[localnet]
name=localnet
type=rpm-md
baseurl=http://localhost:8080/localrepo/
gpgcheck=0
gpgkey=
enabled=1
priority=1
FOE

cat > /etc/yum.repos.d/_copr_boydkelly-xkeyboard-config-ci.repo <<'FOE'
[boydkelly-xkeyboard-config-ci]
name=Copr repo for xkeyboard-config-ci owned by boydkelly
baseurl=https://copr-be.cloud.fedoraproject.org/results/boydkelly/xkeyboard-config-ci/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/boydkelly/xkeyboard-config-ci/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
FOE

cat > /etc/yum.repos.d/_copr_boydkelly-anki21.repo <<'FOE'
[boydkelly-anki21]
name=Copr repo for anki21 owned by boydkelly
baseurl=https://copr-be.cloud.fedoraproject.org/results/boydkelly/anki21/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/boydkelly/anki21/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
FOE

cat > /etc/yum.repos.d/_copr_heikoada-gtk-themes.repo <<'FOE'
[heikoada-gtk-themes]
name=Copr repo for gtk-themes owned by heikoada
baseurl=https://copr-be.cloud.fedoraproject.org/results/heikoada/gtk-themes/fedora-28-$basearch/
#baseurl=https://copr-be.cloud.fedoraproject.org/results/heikoada/gtk-themes/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/heikoada/gtk-themes/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
FOE

%end
