#!/bin/zsh

scriptuser="$USER"
echo "permit persist :wheel" | sudo tee /etc/doas.conf >/dev/null
trizen -S opendoas opendoas-sudo autofs --noedit --skipinteg
doas rm -rf /etc/sudoers.*
trizen -Rns xarchiver mupdf mousepad xfce4-taskmanager
# gpg --import /Basic_Arch/spotify.gpg/pubkey_0D811D58.gpg
trizen -S engrampa atril gnome-system-monitor xed onlyoffice-bin masterpdfeditor-free plank vimix-icon-theme dracula-gtk-theme whatsapp-for-linux spotify hunspell-nl aspell-en aspell-nl lightdm-gtk-greeter-settings pipewire pipewire-pulse gst-plugin-pipewire blueberry ttf-roboto popsicle-bin --noedit
doas pacman -Rns $(pacman -Qdqt)
doas pacman -Syu
trizen -Sc
doas usermod "$scriptuser" -aG rfkill
doas localectl set-x11-keymap us pc105 intl
git clone https://github.com/dracula/plank /tmp/plank >/dev/null 2>&1
doas mv /tmp/plank/Dracula /usr/share/plank/themes/
doas chown root:root /usr/share/plank/themes/Dracula
doas mv /Basic_Arch/*.jpg /usr/share/backgrounds
doas chmod 644 /usr/share/backgrounds/*.jpg
doas chmod 755 /usr/share/plank/themes/Dracula
doas chmod 644 /usr/share/plank/themes/Dracula/*
mkdir -p "$HOME/.config/Thunar"
mkdir -p "$HOME/.config/gtk-3.0"

cat <<-\EOF >> "$HOME/.zshrc"

	alias trizen="trizen --noedit"
	rmdeps () {
	    doas pacman -Rns $(pacman -Qdqt)
	}
EOF

cat <<-\EOF >> "$HOME/.dmrc"
	[Desktop]
	Session=xfce
EOF

cat <<-\EOF > "$HOME/.config/Thunar/uca.xml"
	<?xml version="1.0" encoding="UTF-8"?>
	<actions>
	<action>
		<icon>utilities-terminal</icon>
		<name>Open Terminal Here</name>
		<unique-id>1634989481715879-1</unique-id>
		<command>exo-open --working-directory %f --launch TerminalEmulator</command>
		<description>Open the Terminal Emulator</description>
		<patterns>*</patterns>
		<startup-notify/>
		<directories/>
	</action>
	<action>
		<icon>package-broken</icon>
		<name>Open as root</name>
		<unique-id>1635251963072619-1</unique-id>
		<command>thunar admin://%f</command>
		<description>Open with admin privileges</description>
		<patterns>*</patterns>
		<directories/>
		<other-files/>
		<text-files/>
		<startup-notify/>
	</action>
	</actions>
EOF

cat <<-EOF >> "$HOME/.config/gtk-3.0/bookmarks"
	file:///home/$scriptuser/Documents
	file:///home/$scriptuser/Pictures
	file:///home/$scriptuser/Music
	file:///home/$scriptuser/Videos
	file:///home/$scriptuser/Downloads
EOF
