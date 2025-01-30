# ⛩️ FaAR Project ⛩️

## Resumen

En esta guía aprenderás a instalar y configurar mi entorno de escritorio en Arch Linux. También puedes personalizarlo a tu gusto, ya que detallaré cada comando y la mayoría de las modificaciones en archivos específicos.

---

## Instalación de Arch Linux

Esta instalación parte desde la **[wiki de Arch](https://wiki.archlinux.org/index.php/Installation_guide)** en la sección de la contraseña del superusuario. La wiki también sugiere instalar un cargador de arranque, pero primero configuraremos la conexión a internet.

### 1. Configurar la conexión a internet
```bash
pacman -S networkmanager
systemctl enable NetworkManager
```

### 2. Crear un usuario
```bash
useradd -m username
passwd username
usermod -aG wheel,video,audio,storage username
```

### 3. Instalar y configurar sudo
```bash
pacman -S sudo
```
Edita **/etc/sudoers** con *nano* o *vim* y descomenta la línea con `wheel`:
```bash
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
```

### 4. Reiniciar el sistema
```bash
exit
umount -R /mnt
reboot
```

Si usas conexión por cable, no deberías tener problemas. Para conexión inalámbrica, usa **[NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager)**:
```bash
nmcli device wifi list
nmcli device wifi connect TU_SSID password TU_CONTRASEÑA
```
Más opciones en la [wiki de nmcli](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples).

### 5. Instalar Xorg
```bash
sudo pacman -S xorg
```

---

## Instalación del entorno gráfico

### 1. Instalación de LightDM (gestor de sesión)
```bash
sudo pacman -S lightdm lightdm-gtk-greeter firefox
sudo systemctl enable lightdm
```

### 2. Instalación de BSPWM (gestor de ventanas)
```bash
sudo pacman -S bspwm xorg-xinit sxhkd firefox rxvt-unicode
```

Instalar drivers gráficos:
```bash
sudo pacman -S xf86-video-qxl
```

### 3. Configuración básica de BSPWM

| Combinación              | Acción                              |
|-------------------------|-----------------------------------|
| **super + enter**        | Abre la terminal                    |
| **super + escape**       | Reinicia el sxhkd                   |
| **super + alt + r**      | Reinicia el bspwm                   |
| **super + w**            | Cierra la ventana                   |
| **super + h**            | Ventana izquierda                   |
| **super + l**            | Ventana derecha                     |
| **super + k**            | Ventana de arriba                   |
| **super + j**            | Ventana de abajo                    |
| **super + [1-9]**        | Ir al espacio de trabajo [1-9]      |

---

## Configuración de la terminal (Alacritty)
```bash
sudo pacman -S alacritty
mkdir -p ~/.config/alacritty/
code ~/.config/alacritty/alacritty.toml
```
Ejemplo de configuración:
```toml
[window]
opacity = 0.9
padding = { x = 3, y = 3}

[colors]
[colors.primary]
background = "#1B021B"
foreground = "#F2F2F2"
```
Para agregar desenfoque, instala y configura **picom**:
```bash
code ~/.config/picom/picom.conf
```

---

## Utilidades básicas

### 1. Fuentes
```bash
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
fc-list  # Para listar las fuentes disponibles
```

### 2. Fondo de pantalla
Instala **feh** y configura el fondo en `bspwmrc`:
```bash
sudo pacman -S feh
feh --bg-scale ruta/al/fondo/de/pantalla
```

### 3. Audio y brillo
#### Configuración de volumen con PulseAudio
```bash
sudo pacman -S pulseaudio pavucontrol
```
Añadir estas líneas a la configuración de *sxhkd*:
```bash
# Alternar silencio
XF86AudioMute
    pactl set-sink-mute @DEFAULT_SINK@ toggle

# Ajustar volumen
XF86AudioLowerVolume
    pactl set-sink-volume @DEFAULT_SINK@ -2%
XF86AudioRaiseVolume
    pactl set-sink-volume @DEFAULT_SINK@ +2%
```
#### Configuración de brillo
```bash
sudo pacman -S brightnessctl
```
Añadir estas líneas a *sxhkd*:
```bash
# Brillo
XF86MonBrightnessUp
    brightnessctl set +10%
XF86MonBrightnessDown
    brightnessctl set -10%
```

### 4. Configuración de monitores con Xrandr y Arandr
```bash
sudo pacman -S xrandr arandr
```
Usa *arandr* para organizar monitores y guarda la configuración en *bspwmrc*.

### 5. Video e imágenes
```bash
sudo pacman -S vlc imv
```
Ejemplo de uso:
```bash
imv ruta/a/imagen
vlc ruta/a/video
```

---

## Personalización

### 1. Tema GTK
Descarga un tema desde [GTK Themes](https://www.gnome-look.org/browse?cat=135) y guárdalo en `~/.themes/`.
```bash
sudo pacman -S lxappearance
```
Usa *lxappearance* para aplicar el tema.

### 2. Cursor
```bash
sudo pacman -S xcb-util-cursor
```
Descarga un tema de cursor y muévelo a `/usr/share/icons`. Luego edita:
```bash
sudo nano /usr/share/icons/default/index.theme
```
Cambia:
```bash
Inherits=Breeze
```

### 3. Polybar
Instala Polybar y coloca la configuración en `~/.config/polybar/`.
```bash
sudo pacman -S polybar
```

---

Esta guía te ayudará a instalar y personalizar Arch Linux con BSPWM. Puedes modificar y mejorar la configuración según tus necesidades.







