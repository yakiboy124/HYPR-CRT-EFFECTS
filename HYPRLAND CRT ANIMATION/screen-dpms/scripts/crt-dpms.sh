#!/usr/bin/env bash
TEMPLATE="/home/yakie/.config/hypr/shaders/screen_crt.glsl"
TMP_SHADER="/tmp/crt_active.glsl"
LOCK_FILE="/tmp/crt_anim.lock"

[ -f "$LOCK_FILE" ] && exit 0
touch "$LOCK_FILE"

# Always clear the shader on exit so you can never get stuck on a black screen
cleanup() {
    hyprctl eval 'hl.config({ decoration = { screen_shader = "" } })' >/dev/null 2>&1
    rm -f "$LOCK_FILE"
}
trap cleanup EXIT

play_anim() {
    local steps=("$@")
    for p in "${steps[@]}"; do
        sed "s/PROGRESS_VAL/$p/" "$TEMPLATE" > "$TMP_SHADER"
        hyprctl eval "hl.config({ decoration = { screen_shader = \"$TMP_SHADER\" } })" >/dev/null
        sleep 0.016
    done
}

# 1. Play CRT close animation and hold black
play_anim 0.05 0.12 0.20 0.30 0.42 0.55 0.68 0.80 0.90 0.96 1.0
sleep 0.15

# 2. Turn monitor off
hyprctl dispatch 'hl.dsp.dpms("off")' >/dev/null
sleep 0.8

# 3. Wait until mouse move or keypress wakes DPMS back on (dpmsStatus: 1)
while hyprctl monitors | grep -q "dpmsStatus: 0"; do
    sleep 0.1
done

# 4. Wait briefly for panel backlight, play CRT open animation, then cleanup() clears shader
sleep 0.35
play_anim 0.95 0.85 0.72 0.58 0.44 0.30 0.18 0.08 0.0
