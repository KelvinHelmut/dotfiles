# DOTFILES

![enviroment](./screenshots/enviroment.png)

## Window manager

### i3

![i3](./screenshots/i3.png)

[Ver más](./i3/README.md)

#### X11

##### ~/.xinitrc

Configuraciones cuando se inicia con `startx`. [Ver](./.xinitrc)

##### ~/.xprofile

Configuraciones de inicio generales. [Ver](./.xprofile)

##### $WM/autostart

Configuraciones de inicio especificos para `$WM (i3 | qtile | awesome | otro)`. [Ver](./i3/autostart)

##### ~/.zprofile

Configuración para el inicio automático del gestor de ventanas al iniciar sesión. [Ver](./.zprofile)
> Si usa bash cambiar el nombre a ~/.bash_profile

## Terminal

![tmux](./screenshots/tmux.png)

##### Alacritty
```
$ pacman -S alacritty
```

##### Tmux
```
$ pacman -S tmux
```

##### Zsh
```
$ pacman -S zsh
```
- [Oh my zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel 10k](https://github.com/romkatv/powerlevel10k)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

---

## Aplicaciones

#### Rofi (launcher)

![rofi](./screenshots/rofi.png)
![rofi run](./screenshots/rofi_run.png)

```bash
$ yay -S rofi
$ yay -S rofi-calc # Optional for calc
```

Nombre | Tipo | Instalar
-- | -- | --
yay | gestor de paquetes | [Github](https://github.com/Jguer/yay)
nm-applet | net | `$ pacman -S nm-applet`
picom | compositor | `$ pacman -S picom`
redshift | screen | `$ pacman -S redshift`
xclip | clipboard | `$ pacman -S xclip`
hsetroot | set wallpaper | `$ pacman -S hsetroot`
[chromecast_wallpaper](https://gist.github.com/KelvinHelmut/1f0413337ad91620e3e7ba1e4553ca5d) | wallpaper | [Gist](https://gist.github.com/KelvinHelmut/1f0413337ad91620e3e7ba1e4553ca5d)
flameshot | screenshot | `$ pacman -S flameshot`

### Nvim

![nvim](./screenshots/nvim.png)

[Ver más](./nvim/README.md)

### Fonts

- [Powerline](https://github.com/powerline/fonts)

```
$ yay -S powerline-fonts-git
```

- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts)

```bash
# Download font and extract, example mononoki
$ sudo cp -r Downloads/mononoki /usr/share/fonts/
$ fc-cache # optional
```
