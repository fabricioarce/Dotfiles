# ⛩️ FaAR Project ⛩️

## Summary

In this guide, you will learn how to install and configure my desktop environment on Arch Linux. You can also customize it to your liking, as I will detail each command and most modifications in specific files.

---

## Arch Linux Installation

This installation starts from the **[Arch wiki](https://wiki.archlinux.org/index.php/Installation_guide)** at the superuser password section. The wiki also suggests installing a bootloader, but first, we will configure the internet connection.

### 1. Configure the Internet Connection

```bash
pacman -S networkmanager
systemctl enable NetworkManager
```

### 2. Create a User

```bash
useradd -m username
passwd username
usermod -aG wheel,video,audio,storage username
```

### 3. Install and Configure sudo

```bash
pacman -S sudo
```

Edit **/etc/sudoers** with *nano* or *vim* and uncomment the line with `wheel`:

```bash
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
```

### 4. Restart the System

```bash
exit
umount -R /mnt
reboot
```

If you are using a wired connection, you should not have issues. For wireless connections, use **[NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager)**:

```bash
nmcli device wifi list
nmcli device wifi connect YOUR_SSID password YOUR_PASSWORD
```

More options in the [nmcli wiki](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples).

### 5. Install Xorg

```bash
sudo pacman -S xorg
```

---

## Graphical Environment Installation

### 1. Install LightDM (Display Manager)

```bash
sudo pacman -S lightdm lightdm-gtk-greeter firefox
sudo systemctl enable lightdm
```

### 2. Install BSPWM (Window Manager)

```bash
sudo pacman -S bspwm xorg-xinit sxhkd firefox rxvt-unicode
```

Install graphics drivers:

```bash
sudo pacman -S xf86-video-qxl
```

### 3. Basic BSPWM Configuration

| Key Combination     | Action                    |
| ------------------- | ------------------------- |
| **super + enter**   | Open terminal             |
| **super + escape**  | Restart sxhkd             |
| **super + alt + r** | Restart bspwm             |
| **super + w**       | Close window              |
| **super + h**       | Move window left          |
| **super + l**       | Move window right         |
| **super + k**       | Move window up            |
| **super + j**       | Move window down          |
| **super + [1-9]**   | Switch to workspace [1-9] |

---

## Terminal Configuration (Alacritty)

```bash
sudo pacman -S alacritty
mkdir -p ~/.config/alacritty/
code ~/.config/alacritty/alacritty.toml
```

Example configuration:

```toml
[window]
opacity = 0.9
padding = { x = 3, y = 3}

[colors]
[colors.primary]
background = "#1B021B"
foreground = "#F2F2F2"
```

To add blur, install and configure **picom**:

```bash
code ~/.config/picom/picom.conf
```

---

## Basic Utilities

### 1. Fonts

```bash
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
fc-list  # List available fonts
```

### 2. Wallpaper

Install **feh** and set the wallpaper in `bspwmrc`:

```bash
sudo pacman -S feh
feh --bg-scale path/to/wallpaper
```

### 3. Audio and Brightness

#### Volume Configuration with PulseAudio

```bash
sudo pacman -S pulseaudio pavucontrol
```

Add these lines to *sxhkd* configuration:

```bash
# Toggle mute
XF86AudioMute
    pactl set-sink-mute @DEFAULT_SINK@ toggle

# Adjust volume
XF86AudioLowerVolume
    pactl set-sink-volume @DEFAULT_SINK@ -2%
XF86AudioRaiseVolume
    pactl set-sink-volume @DEFAULT_SINK@ +2%
```

#### Brightness Configuration

```bash
sudo pacman -S brightnessctl
```

Add these lines to *sxhkd*:

```bash
# Brightness
XF86MonBrightnessUp
    brightnessctl set +10%
XF86MonBrightnessDown
    brightnessctl set -10%
```

### 4. Monitor Configuration with Xrandr and Arandr

```bash
sudo pacman -S xrandr arandr
```

Use *arandr* to arrange monitors and save the configuration in *bspwmrc*.

### 5. Video and Images

```bash
sudo pacman -S vlc imv
```

Example usage:

```bash
imv path/to/image
vlc path/to/video
```

---

## Customization

### 1. GTK Theme

Download a theme from [GTK Themes](https://www.gnome-look.org/browse?cat=135) and save it in `~/.themes/`.

```bash
sudo pacman -S lxappearance
```

Use *lxappearance* to apply the theme.

### 2. Cursor

```bash
sudo pacman -S xcb-util-cursor
```

Download a cursor theme and move it to `/usr/share/icons`. Then edit:

```bash
sudo nano /usr/share/icons/default/index.theme
```

Change:

```bash
Inherits=Breeze
```

### 3. Polybar

Install Polybar and place the configuration in `~/.config/polybar/`.

```bash
sudo pacman -S polybar
```

Example minimal configuration (`~/.config/polybar/config.ini`):

```ini
[bar/example]
width = 100%
height = 30
background = #282c34
foreground = #abb2bf
modules-left = date
modules-right = battery

[module/date]
type = internal/date
interval = 5
format = "%Y-%m-%d %H:%M:%S"

[module/battery]
type = internal/battery
full-at = 99
low-at = 20
format-full = "Battery: %percentage%%"
format-low = "Battery: %percentage%%!"
```

Start Polybar with:

```bash
polybar example &
```

Install Polybar and place the configuration in `~/.config/polybar/`.

```bash
sudo pacman -S polybar
```

In my files there is my config&#x20;

This guide will help you install and customize Arch Linux with BSPWM. You can modify and improve the configuration according to your needs.

