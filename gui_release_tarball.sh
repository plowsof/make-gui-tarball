#!/bin/bash

TAG=v0.17.3.2

HEAD=monero-x86_64-linux-gnu-
wget "https://gui.xmr.pm/files/cli/${TAG}/monero-linux-x64-${TAG}.tar.bz2"
wget "https://github.com/monero-ecosystem/monero-GUI-guide/releases/download/v1.9/monero-gui-wallet-guide.pdf"

#create appimage
cat <<EOF >> monero-wallet-gui.AppImage
./monero-wallet-gui
EOF

chmod -R 755 monero-wallet-gui.AppImage
chmod -R 755 monero-wallet-gui

tar -xvf "monero-linux-x64-${TAG}.tar.bz2"

mkdir -p monero-gui-${TAG}/extras

mv ${HEAD}${TAG}/LICENSE monero-gui-${TAG}/.
mv ${HEAD}${TAG}/monerod monero-gui-${TAG}/.
rm ${HEAD}${TAG}/README.md
rm ${HEAD}${TAG}/ANONYMITY_NETWORKS.md

cp monero-gui-wallet-guide.pdf monero-gui-${TAG}/.
cp monero-wallet-gui monero-gui-${TAG}/.
cp monero-wallet-gui.AppImage monero-gui-${TAG}/.

chmod -R 644 monero-gui-${TAG}/monero-gui-wallet-guide.pdf 
chmod -R 644 monero-gui-${TAG}/LICENSE

for filename in ${HEAD}${TAG}/*; do
	chmod -R 755 ${filename} 
	mv ${filename} monero-gui-${TAG}/extras/. 
done

tar -cvjSf monero-gui-linux-x64-${TAG}.tar.bz2 monero-gui-${TAG}

#cleanup

rm monero-linux-x64-${TAG}.tar.bz2
rm -r monero-gui-v0.17.3.2
rm -d monero-x86_64-linux-gnu-v0.17.3.2
rm monero-gui-wallet-guide.pdf
