local home = os.getenv("HOME")
local shader_dir = home .. "/.config/hypr/shaders/"
local script_dir = home .. "/.config/hypr/scripts/"

-- Per-window CRT open/close shaders (requires HyprWindowShade)
hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_open:" .. shader_dir .. "crt_open.glsl",
})

hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_close:" .. shader_dir .. "crt_close.glsl",
})

-- Optional: Keybind for full-screen DPMS CRT power off/wake
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(script_dir .. "crt-dpms.sh"), { locked = true })

hl.config({
    debug = {
        suppress_errors = false,
    },
})
