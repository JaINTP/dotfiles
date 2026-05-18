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
| `dot_config/hypr/`           | Core Hyprland 0.55.* Lua configs (`hyprland.lua`, `execs.lua`, `keybinds.lua`, `rules.lua`, `settings.lua`, `vars.lua`) |
| `dot_config/wayle/`          | Wayle bar configuration (`config.toml`, `themes/`, `tombi.toml`) |
| `dot_config/btop/`           | `btop.conf` + Catppuccin theme file |
| `dot_config/kitty/`          | Terminal theming & scratch-pad configs |
| `dot_config/fresh/`          | Fresh editor configuration |
| `dot_config/Antigravity/`    | Antigravity (VS Code fork) settings & snippets |
| `dot_oh-my-zsh/themes/`      | `jaintp.zsh-theme` |
| `private_dot_local/bin/`     | Helper scripts (auto-chmod via chezmoi) |

---

## Rebos (Nix-like Package Management)

I use [**rebos**](https://gitlab.com/Oglo12/rebos) to manage my Arch Linux and AUR packages declaratively. 
* **`gen.toml`** tracks 80+ explicitly installed applications, including the Hyprland stack (v0.55+), dev tools (Python, Go, Node, Rust), and security utilities.
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

## Hyprland stack (Lua)

* **`hyprland.lua`** sources modular files; **`execs.lua`** sets env-vars (cursor, GTK/Qt themes) and autostarts services like `wayle panel`, `swaync`, `wl-paste`, etc.  
* **`keybinds.lua`** – Super-driven shortcuts for launching apps, vicinae menus, tiling helpers.  
* **`rules.lua`** – workspace pinning, float rules, opacity tweaks, layer blur/dim.  
* **`vars.lua`** – Single source of truth for variables (monitors, apps, paths).
* **`settings.lua`** – Core configuration (animations, decoration, input, monitors).
* **`colors.lua`** – Catppuccin Mocha colour variables reused across the stack.  

---

## Wayle (Bar)

Wayle is a lightweight, high-performance bar for Wayland.
Key bits in `config.toml`:

* **Layout**: Flexible module placement (left/middle/right).
* **Modules**: Custom script integration (e.g., `check-update`), system monitors, and workspace indicators.
* **Theming**: Configurable via `themes/` and `tombi.toml`.

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
| `check-update`        | Returns yay update count (used by Wayle “updates” module). |
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
* [**Hyprland**](https://github.com/hyprwm/Hyprland/) + **[hypridle](https://github.com/hyprwm/hypridle) / [hyprlock](https://github.com/hyprwm/hyprlock) / [Wayle](https://github.com/wayle-org/wayle)** - slick Wayland desktop  
* [**kitty**](https://sw.kovidgoyal.net/kitty), [**btop**](https://github.com/aristocratos/btop), [**Oh My Zsh**](https://ohmyz.sh/) - daily-driver tools  
* [**Catppuccin**](https://catppuccin.com/) - cohesive theming
* **Gramblast Script** Author: [Misterio](https://github.com/misterio77)

Happy dot-fiddling!  
– Jai
