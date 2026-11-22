#version 320 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

float rand(float n) {
    return fract(sin(n * 12.9898) * 43758.5453);
}

void main() {
    float p = PROGRESS_VAL;
    vec2 uv = v_texcoord;

    float vCollapse = smoothstep(0.0, 0.55, p);
    float scaleY = mix(1.0, 0.004, vCollapse);

    float hCollapse = smoothstep(0.50, 0.95, p);
    float scaleX = mix(1.0, 0.004, hCollapse);

    vec2 centered = (uv - 0.5) / vec2(scaleX, scaleY) + 0.5;

    float glitchStrength = sin(p * 3.14159) * 0.05;
    float slice = floor(centered.y * 30.0 + p * 20.0);
    float noise = rand(slice) - 0.5;
    if (abs(noise) > 0.25) {
        centered.x += noise * glitchStrength;
    }

    if (centered.x < 0.0 || centered.x > 1.0 || centered.y < 0.0 || centered.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }

    vec3 color = texture(tex, centered).rgb;
    color -= sin(centered.y * 500.0) * 0.2;
    color += vec3(smoothstep(0.40, 0.90, p) * 2.2);

    float alpha = 1.0 - smoothstep(0.90, 1.0, p);
    fragColor = vec4(color * alpha, 1.0);
}
