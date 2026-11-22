local shader_dir = os.getenv("HOME") .. "/.config/hypr/shaders/"

hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_open:" .. shader_dir .. "crt_open.glsl",
})

hl.window_rule({
    match = { class = ".*" },
    tag = "+shader_close:" .. shader_dir .. "crt_close.glsl",
})

hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("/home/yakie/.config/hypr/scripts/crt-dpms.sh off"), { locked = true })

hl.config({
    debug = {
        suppress_errors = false,
    },
})

hl.exec_cmd("/home/yakie/.config/hypr/scripts/crt-wake-listener.sh")

