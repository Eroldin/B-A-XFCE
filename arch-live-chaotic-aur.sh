#!/bin/zsh

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
cat <<-\EOF >> /etc/pacman.conf

	[chaotic-aur]
	Include = /etc/pacman.d/chaotic-mirrorlist
EOF
pacman -Sy
