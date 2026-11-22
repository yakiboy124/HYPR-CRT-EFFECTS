# HYPR-CRT-EFFECTS
CRT window open/close shaders and DPMS screen wake/off animations for Hyprland.

# Hyprland CRT Window & DPMS Effects

CRT collapse/expand shaders for window open/close and DPMS screen power-off/wake animations in Hyprland[cite: 1, 2, 3, 4, 5].

> **Note on My Setup (Caelestia Shell):** I use **Caelestia Shell**, so my config uses Lua (`hypr-user.lua`) and `hl.*` helpers rather than a plain `hyprland.conf` / `hyprland.lua` file or standard `exec-once` syntax. Some file paths, config hooks, and `hyprctl eval` / `hyprctl dispatch` calls in this repo are written for my setup and may differ on a standard non-Caelestia Hyprland setup.

---

## Requirements

- **Hyprland** (with `hyprpm` plugin manager installed)
- **HyprWindowShade** (`ManofJELLO/HyprWindowShade`) — **required** for `+shader_open:` and `+shader_close:` per-window shader tags
- **Standard CLI tools** for the screen DPMS script: `bash`, `sed`, `grep`, and `hyprctl`

---

## Installation

### Step 1: Install HyprWindowShade
Install and enable the plugin via `hyprpm`:

```bash
hyprpm update
hyprpm add [https://github.com/ManofJELLO/HyprWindowShade](https://github.com/ManofJELLO/HyprWindowShade)
hyprpm enable HyprWindowShade
hyprpm reload -n

(Whenever Hyprland updates, run hyprpm update so the plugin stays compatible with your Hyprland build.)
