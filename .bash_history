paru -S ly
sudo systemctl enable ly.service sudo systemctl start ly.service sudo systemctl disable sddm.service sudo systemctl stop sddm.service
pacman -Qs '^ly$'
sudo systemctl disable sddm.service sudo systemctl stop sddm.service
sudo systemctl enable ly.service sudo systemctl start ly.service sudo systemctl
paru ly
sudo pacman -S ly
reboot
ldd /usr/local/bin/vxwm | grep "not found"
sudo nvim /usr/local/bin/start-vxwm
history
sudo nano /usr/share/xsessions/vxwm.desktop
nano ~/.xprofile
chmod +x ~/.xprofile
nvim .xinitrc
chmod +x ~/.xinitrc
cat /usr/share/sddm/scripts/Xsession
firefox
btop
paru -S btop
btop
yazi
yazi
grep -n "status\|bar" ~/vxwm/modules.h
grep -n "status" ~/vxwm/config.h
xsetroot -name "Hello VXWM!"
[optimist23@archOser ~]$ xsetroot -name "Hello VXWM!"
bash: xsetroot: command not found
paru xsetroot
nvim .xprofile 
grep -R "bar_height\|barheight\|bh =" .
grep -R "HEIGHT" .
nvim ~/vxwm/config.h
cd ~/vxwm
make clean
make
sudo make install
yazi
nvim ~/vxwm/config.h
cd ~/vxwm
make clean
make
sudo make install
cd ~/vxwm
make
# yes, run make first and only then
sudo make clean install
cd ~/vxwm
nvim ~/vxwm/config.h
vxm
sudo make clean install
cd ~/vxwm
nvim ~/vxwm/config.h
sudo make clean install
paru thunar-volman
yazi
yazi
chmod +x wallpaper-theme.sh 
yazi
paru -S gvfs gvfs-mtp
paru -S gnome-polkit-agent
paru gnome-polkit-agent
paru gnome-polkit
paru polkit
paru fastfetch
yazi
polkit-gnome-authentication-agent-1 &
nvim
yazi
acpi -b
paru -S acpi
acpi -b
yazi
which clipboard
sudo pacman -S xclip
paru -Rns clipboard
paru -Rns clipboard-bin
yazi
cd vxwm
sudo make clean install
yazi
yazi
cd vxwm
sudo make clean install
yazi
sudo make clean install
yazi
sudo make clean install
yazi
yazi
sudo make clean install
parau clipboard
paru clipboard
paru -S clipboard
sudo pacman -S clipboard
paru -S clipboard
yazi
yazi
ls ~/.cache/wal
grep -n "background_opacity" ~/.cache/wal/colors-kitty.conf
grep -n "include.*colors-kitty\|background_opacity" ~/.config/kitty/kitty.conf
find ~/.cache/wal/templates ~/.config/wal/templates -type f 2>/dev/null | grep kitty
find /usr -type f 2>/dev/null | grep kitty | grep wal
~/.cargo/bin/tsukiyomi-fetch
tsukiyomi-fetch wrapper github
paru -S tsukiyomi-fetch
find /usr -name "*tsukiyomi-fetch*" 2>/dev/null
hash -r
tsukiyomi-fetch wrapper github
paru mbpfan
yazi
history 
source ~/.bashrc
paru alacritty
fastfetch
paru fastfetch
paru -Rns tsukiyomi-fetch
paru fastfetch
fastfetch 
nvim .bashrc 
ls -la
curl -s https://ohmyposh.dev/install.sh | bash -s
paru -S unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
nvim .bashrc 
nvim .bashrc 
# Fetch and print GitHub statistics
tsukiyomi-fetch wrapper github
# Fetch and print Codeforces statistics 
tsukiyomi-fetch wrapper codeforces
systemctl enable mbpfan
systemctl start mbpfan
yazi
yazi
history
yazi
clear
yazi
source ~/.bashrc
yazi
source ~/.bashrc
sudo install zathura
sudo paru -S zathura
yazi
source ~/.bashrc
install zathura
yazi
source ~/.bashrc
search zathura
install mpd mpc rmpc
search nwg-look
search ffmpegthu
search ffmpegthu
install tumbler evince
cat ~/.xinitrc
cat ~/.xprofile 
yazi
yazi
history 
  319  cat /usr/share/sddm/scripts/Xsession
cat /usr/share/sddm/scripts/Xsession
yazi
echo $XDG_SESSION_TYPE
yazi
cd vxwm
sudo make clean install
echo $DISPLAY 
echo $XDG_SESSION_TYPE 
yazi 
systemctl status ly
search xdg-u
systemctl status ly
systemctl status display-manager
loginctl show-session "$XDG_SESSION_ID" -p Type -p Name -p Display -p Remote
systemctl enable ly@tty2.service
systemctl status display-manager
systemctl status ly
# For LightDM
sudo systemctl disable lightdm.service
# For SDDM (if you use that instead)
sudo systemctl disable sddm.service
sudo systemctl enable ly.service
# 1. Enable Ly on TTY 2
sudo systemctl enable ly@tty2.service
# 2. Disable the default text login prompt on TTY 2 to prevent overlapping
sudo systemctl disable getty@tty2.service
yazi
cd vxwm
sudo make clean install
yazi
sudo make clean install
yazi
sudo make clean install
yazi
yazi
yazi
yazi
search mixer
nvim ~/volume.sh
yazi
install xdg-user-dirs
xdg-user-dirs-update
yazi
pacman -Qs pywal
pacman -Qs nwg-look
ls ~/.cache/wal/colors-oomox
sudo pacman -S kvantum qt5ct qt6ct
yazi
source ~/.bashrc 
cd ~/.config/wal/templates
curl -O https://githubusercontent.com
curl -O https://githubusercontent.com
# Create symlink
ln -s ~/.cache/wal/pywal.json 
cd 
cd .cache/wal/
ls
ln -s ~/.cache/wal/pywal.json 
ln -s ~/.cache/wal/pywal.json # Move to Kvantum directory
cd ~/.config/Kvantum
touch ~/.config/Kvantum
mkdir ~/.config/Kvantum
cd
cd .config/
ls
yazi
install discord
discord
yazi
mpd
rmpc
rmpc
mpc update
ls
ls .themes/
kvantummanager
pywalfox install --manifest-path ~/.mozilla/native-messaging-hosts --profile-path ~/.config/librewolf/librewolf
pywal
cava
exit
yazi 
source ~/.bashrc
yazi
mpd
rmpc
yazi
mkdir -p ~/.config/wal/templates
cat << 'EOF' > ~/.config/wal/templates/gtk.css
/******************
 * GTK Colors Enhanced
 * Automatically updated by Pywal Template
 ******************/

/* الألوان الأساسية */
@define-color accent_color {color1};          
@define-color accent_bg_color {color2};       
@define-color accent_fg_color {foreground};   

/* ألوان نافذة التطبيق */
@define-color window_bg_color {background};   
@define-color window_fg_color {foreground};   

/* ألوان شريط العنوان */
@define-color headerbar_bg_color {color0};    
@define-color headerbar_fg_color {foreground};
@define-color headerbar_border_color {color8};
@define-color headerbar_shade_color {color0};

/* ألوان العناصر المنبثقة */
@define-color popover_bg_color {color0};
@define-color popover_fg_color {foreground};

/* ألوان العرض */
@define-color view_bg_color {background};
@define-color view_fg_color {foreground};

/* ألوان البطاقات */
@define-color card_bg_color {color0};
@define-color card_fg_color {foreground};
@define-color card_shade_color rgba(0, 0, 0, 0.5);

/* ألوان الشريط الجانبي */
@define-color sidebar_bg_color @window_bg_color;
@define-color sidebar_fg_color @window_fg_color;
@define-color sidebar_border_color @window_bg_color;
@define-color sidebar_backdrop_color @window_bg_color;

/* ألوان الخلفية والنص */
@define-color bg_color {background};
@define-color fg_color {foreground};
@define-color text_color {foreground};
@define-color text_color_disabled {color8};   

/* ألوان الأزرار */
@define-color button_bg_color {color8};       
@define-color button_fg_color {foreground};
@define-color button_hover_color {color4};    
@define-color button_active_color {color5};   
@define-color button_checked_bg_color {color2};
@define-color button_checked_fg_color {foreground};

/* ألوان الإطارات */
@define-color borders {color8};
@define-color outline_color {color8};
@define-color outline_variant_color {color0};

/* ألوان الروابط */
@define-color link_color {color6};            
@define-color link_visited_color {color5};

/* ألوان التحذير والخطأ */
@define-color warning_color {color3};         
@define-color warning_bg_color {color0};
@define-color warning_fg_color {foreground};
@define-color error_color {color1};           
@define-color error_bg_color {color0};
@define-color error_fg_color {foreground};
@define-color success_color {color2};         
@define-color success_bg_color {color0};
@define-color success_fg_color {foreground};

/* ألوان الحالة النشطة والمحددة */
@define-color selected_bg_color {color1};     
@define-color selected_fg_color {foreground};
@define-color selected_text_color {foreground};

/* ألوان التفاعلية */
@define-color hover_color {color4};
@define-color focus_color {color1};

/* ألوان وضع الظلام المخصصة */
@define-color dark_fill_color {color0};
@define-color light_fill_color {color8};

/* ألوان الاشعارات */
@define-color info_color {color4};
@define-color info_bg_color {color0};
@define-color info_fg_color {foreground};

/* ألوان الشفافية */
@define-color shade_color rgba(0, 0, 0, 0.3);
@define-color backdrop_color rgba(0, 0, 0, 0.5);
@define-color overlay_color rgba(0, 0, 0, 0.2);

/******************
 * Structural Force Fixes
 ******************/
window, .background, dialog, messagedialog, headerbar, notebook {
    background-color: @window_bg_color !important;
    color: @window_fg_color !important;
}
EOF

yazi
yazi
mkdir -p ~/.config/gtk-4.0
echo '@import url("file:///home/optimist23/.cache/wal/gtk.css");' > ~/.config/gtk-4.0/gtk.css
yazi
acpi -b
yazi
sudo pacman -Syu exfatprogs
search ttf-jetbrains-mono-nerd
yazi
  yazi
yazi
yazi
yazi
yazi
mpd
rmpc
yazi
# Safely restarts the notification loop to pick up new colors
killall dunst; dunst &
yazi
# Ensure the config folder exists
mkdir -p ~/.config/dunst
# Remove your existing static config file safely
rm -f ~/.config/dunst/dunstrc
# Create a symlink pointing directly to Pywal's runtime output cache
ln -s ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
yazi
cat ~/.cache/wal/dunstrc
yazi
mkdir -p ~/.config/wal/templates
cat << 'EOF' > ~/.config/wal/templates/dunstrc
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 200
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 0

    # Swapped Monospace for your newly installed JetBrainsMono Nerd Font!
    font = JetBrainsMono Nerd Font 10
    line_height = 0
    format = "<b>%s</b>\n%b"
    alignment = left
    word_wrap = yes
    stack_duplicates = true

    frame_width = 3
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    separator_color = frame

[urgency_low]
    background = "{background}"
    foreground = "{foreground}"
    frame_color = "{color8}"
    timeout = 10

[urgency_normal]
    background = "{background}"
    foreground = "{foreground}"
    frame_color = "{color1}"
    timeout = 10

[urgency_critical]
    background = "{background}"
    foreground = "{foreground}"
    frame_color = "{color9}"
    timeout = 10
EOF

cat ~/.cache/wal/dunstrc
cat ~/.cache/wal/dunstrc
cat ~/.config/wal/dunstrc
yazi
chmod 
chmod +x wal-dunst.sh 
# 4. Send a test notification to verify the purple theme!
notify-send "Theme Sync" "Dunst is now matching your wallpaper colors!"
yazi
yazi
mpd
rmpc
./wal-dunst.sh 
yazi
install xdotool
yazi
yazyazi
yazi 
yazi
search pywal
yazi
yazi
install figlet
figlet VXWM
figlet vxwm
showfigfonts
figlet -f banner vxwm
figlet -f banner vxwm
figlet -f slant vxwm
figlet -f standard vxwm
search awd
search adw
ls
eza
install eza
ls
ls
yazi
search bibata
search gruvbox-plus
search gruvbox-plus
c
fastfetch 
acpi -b
./wal-dunst.sh 
c
fastfetch 
install ttf-nerd-fonts-symbols
fc-cache -f -v
fast fetch
fastfetch
yazi
sudo pacman -S ttf-nerd-fonts-symbols-common otf-nerd-fonts-symbols-mono
fc-cache -f -v
sudo pacman -S ttf-nerd-fonts-symbols-mono
fc-cache -fv
fastfetch 
ls
ls -la
yazi
c
cd .config/
tree -d
tree -h
c
yazi
history 
ln -s ~/.cache/wal/gtk.css ~/.config/gtk-4.0/
ln -s ~/.cache/wal/gtk.css ~/.config/gtk-3.0/
yazi
yazi
yazi
