# Jai’s Dotfiles

All my Linux configuration lives here and is managed with **chezmoi** – a dot-file manager that templates, encrypts secrets and applies everything idempotently.

---

## Screenshots

![Screenshot 1](https://raw.github.com/JaINTP/dotfiles/main/Screenshots/Screenshot_1.png)
![Screenshot 2](https://raw.github.com/JaINTP/dotfiles/main/Screenshots/Screenshot_2.png)
![Screenshot 3](https://raw.github.com/JaINTP/dotfiles/main/Screenshots/Screenshot_3.png)

---

## Quick install

```bash
# 1) Install chezmoi (if it's not present) and pull + apply this repo
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/jaintp/dotfiles.git
```

Re-run `chezmoi apply` any time to sync local changes.

---

## Directory layout (excerpt)

| Path | Purpose |
|------|---------|
| `dot_config/hypr/`           | Core Hyprland configs (`hyprland.conf`, `execs.conf`, `keybinds.conf`, `rules.conf`, `mocha.conf`) |
| `dot_config/hyprpanel/`      | Bar & dashboard JSON (`config.json`, `theme.json`) + launcher `hyprpanel.sh` |
| `dot_config/hypridle/`       | Idle-daemon settings |
| `dot_config/hyprlock/`       | GPU lock-screen config |
| `dot_config/btop/`           | `btop.conf` + Catppuccin theme file |
| `dot_config/kitty/`          | Terminal theming & scratch-pad configs |
| `dot_oh-my-zsh/themes/`      | `jaintp.zsh-theme` |
| `private_dot_local/bin/`     | Helper scripts (auto-chmod via chezmoi) |

---

## Hyprland stack

* **`hyprland.conf`** sources modular files; **`execs.conf`** sets env-vars (cursor, GTK/Qt themes) and autostarts `hypridle`, `swaync`, `hyprpanel`, `wl-paste`, etc.  
* **`keybinds.conf`** – Super-driven shortcuts for launching apps, rofi menus, tiling helpers like `window_offset_center`.  
* **`rules.conf`** – workspace pinning, float rules, opacity tweaks, layer blur/dim.  
* **`mocha.conf`** – Catppuccin Mocha colour variables reused across the stack.  

### Hyprpanel

Hyprpanel is an AGS-based bar written for Hyprland.  
Key bits in `config.json` / `theme.json` include:

* **Docking**: `theme.bar.floating = false` (bar is pinned).  
* **Workspaces**: five slots with occupied/empty icons.  
* **Modules**: update checker (24-min cadence), weather block, storage graphs.  
* **Typography**: JetBrainsMono Nerd Font at `0.9rem`; radius & padding tuned under `theme.bar.buttons.*`.

`hyprpanel.sh` safely restarts the bar after config edits.

---

## Kitty terminal

* Fast GPU-accelerated terminal with **JetBrainsMono Nerd Font** and Catppuccin Mocha theme (`theme.conf`).  
* `kitty-scratchpad.conf` defines an 80 × 24 drop-down terminal toggled via Hyprland.  
* Personal tweaks live in `userprefs.conf` (no close-prompt, zero padding, taller glyphs).

---

## Btop

`btop.conf` switches to `catppuccin_moch.theme`, enables true-color & transparency, updates every 2 s and shows CPU / MEM / NET / PROC / GPU boxes.

---

## Zsh

Oh My Zsh with a custom prompt in `jaintp.zsh-theme` (git branch, exit code, timer).  
Plugins: `git`, `fzf`, `z`, plus Wayland-specific env-vars and aliases in `dot_zshrc`.

---

## Helper scripts (`~/.local/bin`)

| Script | What it does |
|--------|--------------|
| `brightness`          | Adjust back-light via `brightnessctl`. |
| `check-update`        | Returns yay update count (used by Hyprpanel “updates” module). |
| `grimblast`           | Screenshot helper for Hyprland. |
| `playerctl-helper`    | Caches album art + exposes rich metadata for bar widgets. |
| `random-wallpapers`   | Picks a random wallpaper and sets it via **swww**. |
| `walld`               | Ensures `swww-daemon` is running, then sets `$HOME/.config/background`. |
| `weatherfetch`        | Fetches / caches Open-Meteo JSON; prints a friendly forecast. |
| `window_offset_center`| Nudges a floating window left/right of centre to avoid pile-ups. |

---

## Secrets & templating

A `.chezmoiignore` keeps host-specific secrets out of git.  
Encrypt blobs with:

```bash
chezmoi secret add <name>
```

Preview safely with `chezmoi diff`.

---

## Credits

* [**chezmoi**](https://www.chezmoi.io/) - dot-file management powerhouse  
* [**Hyprland**](https://github.com/hyprwm/Hyprland/) + **[hypridle](https://github.com/hyprwm/hypridle) / [hyprlock](https://github.com/hyprwm/hyprlock) / [hyprpanel](https://hyprpanel.com/)** - slick Wayland desktop  
* [**kitty**](https://sw.kovidgoyal.net/kitty), [**btop**](https://github.com/aristocratos/btop), [**Oh My Zsh**](https://ohmyz.sh/) - daily-driver tools  
* [**Catppuccin**](https://catppuccin.com/) - cohesive theming
* **Gramblast Script** Author: [Misterio](https://github.com/misterio77)

Happy dot-fiddling!  
– Jai
