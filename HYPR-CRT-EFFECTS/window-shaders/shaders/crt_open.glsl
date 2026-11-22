#version 320 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform float progress;
out vec4 fragColor;

void main() {
    float p = 1.0 - progress;
    vec2 uv = v_texcoord;

    float vCollapse = smoothstep(0.0, 0.75, p);
    float scaleY = mix(1.0, 0.004, vCollapse);

    float hCollapse = smoothstep(0.7, 1.0, p);
    float scaleX = mix(1.0, 0.004, hCollapse);

    vec2 centered = (uv - 0.5) / vec2(scaleX, scaleY) + 0.5;

    if (centered.x < 0.0 || centered.x > 1.0 || centered.y < 0.0 || centered.y > 1.0) {
        fragColor = vec4(0.0);
        return;
    }

    vec4 color = texture(tex, centered);
    float glow = smoothstep(0.4, 0.9, p) * 2.0;
    color.rgb += vec3(glow);

    fragColor = color;
}

