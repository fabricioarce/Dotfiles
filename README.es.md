<h1 align="center"> ⛩️FaAR Project⛩️ </h1>

# Resumen

En esta guia te voy a enseñar como instalar mi entorno de escritorio,
tambien en el caso de que quisieras podrais modificar las configuraciones mias
para lograr un entorno mas personal debido que te voy a decir cada comando
y la mayoria de las ediciones a documentos especificos

# Instalacion de Arch Linux

Esta instalacion parte de donde la **[wiki de arch](https://wiki.archlinux.org/index.php/Installation_guide)** en la parte de la contraseña del superusuario
tambien la wiki sugiero instalar un cargador de arranque pero primero vamos a empesar por el internet y luego seguimos con mas temas

```bash
pacman -S networkmanager
systemctl enable NetworkManager
```

Ahora instalamos el cargador de arranque, 
este comando solo funciona con equipos modernos que usen EFI
y tambien suponiendo que has [montado la partición efi en /boot](https://wiki.archlinux.org/index.php/Installation_guide#Example_layouts)
podemos instalar grub:

```bash
useradd -m username
passwd username
usermod -aG wheel,video,audio,storage username
```

Ahora puedes crear tu usuario:

```bash
useradd -m USERNAME
passwd username
usermod -aG wheel,video,audio,storage username
```

Luego para poder tener privilegios de superusuario tenemos que descargar sudo y modificar un texto

```bash
pacman -S sudo
```

Edita **/etc/sudoers** con *nano* o *vim* y descomenta la línea con "wheel":

```bash
## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL
```

En este momento ya puedes reiniciar la maquina luego de hacer esto:

```bash
# Sal de la imagen ISO, desmóntala y extráela
exit
umount -R /mnt
reboot
```

En este momento si estas utilizando internet por cable no deberias tener problema
pero en el caso de que ocupes internet inalambrico puedes usar **[NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager)**,
debido a que **[iwctl](https://wiki.archlinux.org/index.php/Iwd#iwctl)** ya no esta disponible
a menos de que lo hayas descargargado manualmente, y para conectarnos a internet 
lo que se debe hacer es seguir los siguientes pasos

```bash
# Lista las redes disponibles
nmcli device wifi list
# Conéctate a tu red
nmcli device wifi connect TU_SSID password TU_CONTRASEÑA
```

Échale un vistazo a
[esta página](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples)
para otras opciones proporcionadas por *nmcli*. Lo último que tenemos que hacer
antes de pensar en entornos de escritorio es instalar
**[Xorg](https://wiki.archlinux.org/index.php/Xorg)**:

```bash
sudo pacman -S xorg
```

# Instalar Entorno grafico

## Inicio de sesion

### Instalacion de *lightdm*

Primero necesitamos alguna forma de iniciar sesion
y para ello utilizare **[lighdm](https://wiki.archlinux.org/index.php/LightDM)**
el cual no funciona si no instalamos un: **[greeter](https://wiki.archlinux.org/index.php/LightDM#Greeter)**.
ademas de esto descargare un navegador, tambien puedes elejir cualquira

```bash
sudo pacman -S lightdm lightdm-gtk-greeter firefox
```

Activa el servicio de *lightdm*

```bash
sudo systemctl enable lightdm
```

Antes de reiniciar el equipo vamos a instalar un administrador de tareas y 
dejaremos para despues la instalacion de temas para *lightdm*

## Insalacion de un gestor de ventanas
Para el gestor de ventas usare bspwm junto a otros complementos 
los cuales instalaremos y configuraremos mas tarde.
Primero instalaremos bspwm y unos complementos

```bash
sudo pacman -S bspwm xorg-xinit sxhkd firefox rxvt-unicode
```

luego instalaremos drivers graficos:

```bash
sudo pacman -S xf86-video-qxl
```

Ya para este punto podemos reiniciar o apagar el equipo

### Configuracion basica

| Combinación              | Acción                              |
| ------------------------ | ----------------------------------- |
| **super + enter**        | Abre la terminal                    |
| **super + escape**       | Reinicia el sxhkd                   |
| **super + alt + r**      | reinicia el bspwm                   |
| **super + w**            | cierra la ventana                   |
| **super + h**            | ventana izquierda                   |
| **super + l**            | ventana derecha                     |
| **super + k**            | ventana de arriba                   |
| **super + j**            | ventana de abajo                    |
| **super + [1234567890]** | ir al espacio de trabajo [12345678] |

## Configuracion de la terminal 

Primero tendremos que instalar una terminal de nuestra preferencia
en mi caso usare **[alacritty](https://wiki.archlinux.org/title/Alacritty)**
por lo que la configuracion sera para alacritty
```bash
sudo pacman -S alacritty
```
Ahora haremos un directorio dentro de .config para poner nuestra conifuracion
```bash
mkdir .config/alacritty/
```
luego crearemos y editaremos el archivo con el editor de texto que quieras
```bash
code .config/alacritty/alacritty.toml 
```
mi configuracion en la siguiente
```toml
[window]
opacity = 0.9
padding = { x = 3, y = 3}

[colors]
[colors.primary]
background = "#1B021B"
foreground = "#F2F2F2"
```
y por ultimo para agregar blur usare picom,
con esta configuracion picom tambien agregara transpariencia a otras aplicaiones

```bash
code .config/picom/picom.conf
```

y copiamos el texto del archivo de picom

# Utilidades basicas

## Fuentes

Las fuentes en Arch son básicamente un meme, antes de que te den problemas
puedes simplemente instalar estos paquetes:

```bash
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
```

Para listar todas las fuentes disponibles:

```bash
fc-list
```

## Fondo de pantalla
Este es uno de los mas sencillos para el cual usare **[feh](https://wiki.archlinux.org/index.php/Feh)**
tambine se puede usar **[nitrogen](https://wiki.archlinux.org/index.php/Nitrogen)**
entonces depues de descargar feh o nitrogen buscaremos un fondo de pantalla en firefox
y pondrmos en siguiente comando en bspwmrc

```bash
sudo pacman -S feh
feh --bg-scale ruta/al/fondo/de/pantalla
```

y eso seria todo para el fondo de pantalla

## Audio y brillo

### Brillo
Para este punto todavia no tenemos audio asi que vamos a usar **[pulseaudio](https://wiki.archlinux.org/title/PulseAudio)**
y **[pavucontrol](https://wiki.archlinux.org/title/PulseAudio)** pulseaudio nos permitira poder usar el audio
y pavucontrol lo usaremos para ajustar el volumen 

dentro luego de descargar en la parte de sxhkd ponemos lo siguiente


```bash
# Alternar silencio
XF86AudioMute
    pactl set-sink-mute @DEFAULT_SINK@ toggle

# Alterar volumen
XF86AudioLowerVolume
    pactl set-sink-volume @DEFAULT_SINK@ -2%

XF86AudioRaiseVolume
    pactl set-sink-volume @DEFAULT_SINK@ +2%
```

### brillo

si tienes portatil probablemente te interesa subir y bajar el brillo
y para esto usaremos **[brightnessctl](https://man.archlinux.org/man/brightnessctl.1.en)**
y pondremos los siguientes comandos en el mismo archivo de antes

```bash
# Brillo
XF86MonBrightnessUp
    brightnessctl set +10%
XF86MonBrightnessDown
    brightnessctl set -10%
```

## Monitores

Para poder configurar varios monitores usaremos dos programas
**[xrandr](https://wiki.archlinux.org/title/Xrandr)** y
**[arandr](https://archlinux.org/packages/extra/any/arandr/)**
```bash
sudo pacman -S xrandr arandr
```

luego abriremos arandr con rofi y acomodaremos la pantallas como queramos
para luego darle en el icono de guardar el cual es el ultimo de derecha a izquierda
despues de guardar el archivo lo abriremos y copiaremos la segunda linea de codigo 
y la pegaremos en bspwmrc 

## Utilidades extra y rapidos

### Video y imagenes 
para ver videos utilizaremos vlc y para imgenes imv
```bash
sudo pacman -S vlc imv
```
y para utilizarlo es tan sencillo como poner:
```bash
imv/vlc ruta/a/la/imagen_o_video
```

### screenshoot 
###

# Tema de GTK
Primero debemos escojer un tema en [GTK Theme](https://www.gnome-look.org/browse?cat=135)
en mi caso usare [este](https://www.gnome-look.org/p/1333360) y tambien ocupare [este otro](https://www.gnome-look.org/p/1316887)
del cual escojere el Material-Black-Blueberry y lo descargamos, luego lo descomprimes con unzip
y copiamos lo configuracion de GTK de mis archivos, las configuraciones irian en ~/.gtkrc-2.0 y ~/.config/gtk-3.0/settings.ini respectivamente
si eso no funciona recomiendo usar **[lxappearance]()** donde tambien se pueden personalizar mas cosas
# Cursor
Para cambiar el cursor primero tenemos que descargar un programa que se llama xcb-util-cursor
```bash
sudo pacman -S xcb-util-cursor
```

y luego descargamos el tema que queramos yo usare **[breeze](https://www.gnome-look.org/p/999927)**
luego de descargarlo lo descoprimimos poniendo el siguiente comando `tar -xf nombre-del-archivo`
y movemos una carpeta dentro del fichero breeze al siguiente directorio
```bash
sudo mv Breeze/ /usr/share/icons
```
y editamos el siguiente archivo `sudo nano /usr/share/icons/default/index.theme`
y cambiamos el la segunda linea por la siguiente
```bash
Inherits=Breeze
```
por si quieres ponerte algun otro el la misma pagina de gnome-look hay mas 

# Polybar
Para polybar unicamente debemos descargar polybar y poner mis archivos del .config/polybar
en un directorio llamado polybar el cual va dentro de .config/polybar







