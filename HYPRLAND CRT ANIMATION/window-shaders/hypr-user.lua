local shader_dir = os.getenv("HOME") .. "/.config/hypr/shaders/"

hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_open:" .. shader_dir .. "crt_open.glsl@0.3",
})

hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_close:" .. shader_dir .. "crt_close.glsl@0.2",
})

hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("/home/yakie/.config/hypr/scripts/crt-dpms.sh off"), { locked = true })

hl.config({
    debug = {
        suppress_errors = false,
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload -n")
end)
