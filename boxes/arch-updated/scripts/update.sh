#!/usr/bin/env bash

set -eu

echo "Installing updates..."
sudo pacman -Syu --noconfirm

echo "Installing paru..."
sudo pacman -S --noconfirm base-devel git
cat > /home/vagrant/install-paru.sh <<EOS
#!/usr/bin/env bash
set -eu
cd /home/vagrant
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg --syncdeps --install --noconfirm
popd
rm -Rf paru
EOS
sudo -u vagrant bash /home/vagrant/install-paru.sh
