# Jai’s Dotfiles

All my Linux configuration lives here and is managed with **chezmoi** – a dot-file manager that templates, encrypts secrets and applies everything idempotently.

---

## Screenshots
![Screenshot 1](/../main/Screenshots/Screenshot_1.png?raw=true)
![Screenshot 2](/../main/Screenshots/Screenshot_2.png?raw=true)
![Screenshot 3](/../main/Screenshots/Screenshot_3.png?raw=true)

---

## Quick install

```bash
# 1) Comprehensive installation for a fresh Arch machine
# Installs base-devel, yay, chezmoi, rebos-git, and pulls all dotfiles
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jaintp/dotfiles/main/install.sh)"
```

Re-run `chezmoi apply` any time to sync local changes.

---

## Directory layout (excerpt)

| Path | Purpose |
|------|---------|
| `dot_config/rebos/`          | Nix-like generation manager for Arch/AUR packages (`gen.toml`, `managers/`) |
| `dot_config/hypr/`           | Core Hyprland configs (`hyprland.conf`, `execs.conf`, `keybinds.conf`, `rules.conf`, `mocha.conf`) |
| `dot_config/hyprpanel/`      | Bar & dashboard JSON (`config.json`, `theme.json`) + launcher `hyprpanel.sh` |
| `dot_config/hypridle/`       | Idle-daemon settings |
| `dot_config/hyprlock/`       | GPU lock-screen config |
| `dot_config/btop/`           | `btop.conf` + Catppuccin theme file |
| `dot_config/kitty/`          | Terminal theming & scratch-pad configs |
| `dot_config/fresh/`          | Fresh editor configuration |
| `dot_config/Antigravity/`    | Antigravity (VS Code fork) settings & snippets |
| `dot_oh-my-zsh/themes/`      | `jaintp.zsh-theme` |
| `private_dot_local/bin/`     | Helper scripts (auto-chmod via chezmoi) |

---

## Rebos (Nix-like Package Management)

I use [**rebos**](https://gitlab.com/Oglo12/rebos) to manage my Arch Linux and AUR packages declaratively. 
* **`gen.toml`** tracks 80+ explicitly installed applications, including the Hyprland stack, dev tools (Python, Go, Node, Rust), and security utilities.
* **`managers/system.toml`** is configured to use `yay` for seamless official/AUR management.

---

## Development Environment

My workflow is centered around modern, fast tools:
* **Python**: Managed exclusively via `uv`.
* **Rust**: System-wide `rust` and `cargo` for building performance-critical tools.
* **Node.js**: Global packages managed with `pnpm` and `yarn`.
*   **Editor**: [**Antigravity**](https://github.com/antigravity-editor/antigravity) (VS Code fork) and [**Fresh**](https://github.com/fresh-editor/fresh) (fast, native editor) for high-performance coding.
*   **Security**: Integrated tools like `subfinder`, `nmap`, `sqlmap`, `ghidra`, and `jadx`.

---

## Hardware & System

*   **Graphics**: NVIDIA handled via `nvidia-open-dkms` with `nvidia-container-toolkit` for Docker GPU passthrough.
*   **CPU**: Intel-specific optimizations with `intel-ucode`.
*   **Audio**: Pipewire/Wireplumber with `pavucontrol` and `alsa-utils`.
*   **Power**: Managed by `power-profiles-daemon`.
*   **Maintenance**: Automated mirror updates via `reflector` and snapshot management with `snapper`.

---

## Media & Productivity

*   **PDF/Docs**: **Okular** for rich document viewing.
*   **Browsers**: **Zen Browser** (primary) and **Google Chrome** (secondary/testing).
*   **Video**: **VLC** and **OBS Studio** for playback and recording.
*   **Audio**: **Spotify** and `playerctl` integration for bar widgets.


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
