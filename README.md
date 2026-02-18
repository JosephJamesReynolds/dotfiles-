# dotfiles

Personal Linux desktop configs for i3 window manager, Polybar, Kitty, Rofi, and GTK theming.

## Machines

- **thinkpad** — Arch Linux on ThinkPad P52 (multi-monitor, Nvidia hybrid GPU)
- **zorin** — Zorin OS school desktop (single monitor)

## Structure

```
dotfiles/
├── shared/              # Configs that work on any machine
│   ├── kitty/           # Terminal emulator
│   ├── rofi/            # App launcher
│   ├── gtk-3.0/         # Dark theme + disable event sounds
│   └── polybar-launch.sh
├── thinkpad/            # Arch ThinkPad specific
│   ├── i3/              # i3 config + powermenu + monitor switching
│   └── polybar/         # Full bar with battery, backlight, wifi, bluetooth
├── zorin/               # Zorin desktop specific
│   ├── i3/              # i3 config (single monitor, no autorandr)
│   └── polybar/         # Desktop bar (no battery/backlight/wifi)
└── install.sh           # Install packages + symlink configs
```

## Install

```bash
git clone https://github.com/YOURUSERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The script asks which machine you're on and handles the rest.

## Zorin First-Time Setup

After running `install.sh` on the Zorin machine, update these placeholders before logging into i3:

1. `xrandr --query | grep " connected"` → update `CHANGEME` in `~/.config/i3/config`
2. `ip link` → update `CHANGEME` in `~/.config/polybar/config.ini`
3. Place a wallpaper at `~/Pictures/wallpaper.jpg`

Then log out, select **i3** at the login screen, and log in.

## Keybindings

| Key | Action |
|-----|--------|
| Super+Return | Terminal (Kitty) |
| Super+D | App launcher (Rofi) |
| Super+E | File manager (Thunar) |
| Super+Q | Close window |
| Super+F | Fullscreen |
| Super+1-9 | Switch workspace |
| Super+Shift+1-9 | Move window to workspace |
| Super+Arrow/HJKL | Focus direction |
| Super+Shift+Arrow | Move window |
| Super+. | Screenshot (area) |
| Super+/ | Screenshot (window) |
| Super+Shift+Q | Power menu |
| Super+Shift+R | Reload i3 |
| Super+R | Resize mode |

## Theme

- Colors: Catppuccin Mocha / Wallust
- Terminal: Hipster Green on Kitty
- GTK: Breeze-Dark + Papirus-Dark icons
- Font: JetBrainsMono Nerd Font (bar), FantasqueSansM Nerd Font (terminal)
