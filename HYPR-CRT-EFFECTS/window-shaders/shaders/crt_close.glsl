#version 320 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform float progress;
out vec4 fragColor;

void main() {
    vec2 uv = v_texcoord;

    // 1. Squash top & bottom toward center (0.0 -> 0.75)
    float vCollapse = smoothstep(0.0, 0.75, progress);
    float scaleY = mix(1.0, 0.004, vCollapse);

    // 2. Collapse horizontal line to center dot (0.7 -> 1.0)
    float hCollapse = smoothstep(0.7, 1.0, progress);
    float scaleX = mix(1.0, 0.004, hCollapse);

    vec2 centered = (uv - 0.5) / vec2(scaleX, scaleY) + 0.5;

    if (centered.x < 0.0 || centered.x > 1.0 || centered.y < 0.0 || centered.y > 1.0) {
        fragColor = vec4(0.0);
        return;
    }

    vec4 color = texture(tex, centered);

    // Brighten into a white scanline as it squashes
    float glow = smoothstep(0.4, 0.9, progress) * 2.0;
    color.rgb += vec3(glow);

    float alpha = 1.0 - smoothstep(0.88, 1.0, progress);
    fragColor = vec4(color.rgb * alpha, color.a * alpha);
}

