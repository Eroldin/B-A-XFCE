#!/bin/zsh

scriptuser="$USER"
echo "permit persist :wheel" | sudo tee /etc/doas.conf >/dev/null
trizen -S opendoas opendoas-sudo --noedit
trizen -S autofs --noedit --skipinteg
doas rm -rf /etc/sudoers.* -v
trizen -Rns xarchiver mupdf mousepad xfce4-taskmanager
trizen -S engrampa atril gnome-system-monitor xed onlyoffice-bin masterpdfeditor-free plank vimix-icon-theme dracula-gtk-theme whatsapp-for-linux hunspell-nl aspell-en aspell-nl lightdm-gtk-greeter-settings pipewire pipewire-pulse gst-plugin-pipewire blueberry ttf-roboto popsicle-bin --noedit
doas pacman -Rns $(pacman -Qdqt)
doas pacman -Syu
trizen -Sc
doas usermod "$scriptuser" -aG rfkill
doas localectl set-x11-keymap us pc105 intl
git clone https://github.com/dracula/plank /tmp/plank
doas mv /tmp/plank/Dracula /usr/share/plank/themes/ -v
doas chown root:root /usr/share/plank/themes/Dracula
doas mv /Basic_Arch/*.jpg /usr/share/backgrounds -v
doas chmod 644 /usr/share/backgrounds/*.jpg -v
doas chmod 755 /usr/share/plank/themes/Dracula -v
doas chmod 644 /usr/share/plank/themes/Dracula/* -v
mkdir -vp "$HOME/.config/Thunar"
mkdir -v "$HOME/.config/gtk-3.0"

echo "Creating usefull aliases for zsh"
cat <<-\EOF >> "$HOME/.zshrc"

	alias trizen="trizen --noedit"
	rmdeps () {
	    doas pacman -Rns $(pacman -Qdqt)
	}
EOF

echo "Creating Thunar actions..."
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

"Crating basic bookmarks for thunar"
cat <<-EOF >> "$HOME/.config/gtk-3.0/bookmarks"
	"file:///home/$scriptuser/Documents"
	"file:///home/$scriptuser/Pictures"
	"file:///home/$scriptuser/Music"
	"file:///home/$scriptuser/Videos"
	"file:///home/$scriptuser/Downloads"
EOF
